using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class property_search : System.Web.UI.Page
{
    // ── filter state ─────────────────────────────────────────────────────────
    string type     = "";
    string size     = "";
    string location = "";
    string budget   = "";
    string status   = "";

    const int PageSize = 9;

    // ─────────────────────────────────────────────────────────────────────────
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Decode Base64 ?q= param passed from the hero search card
            string encoded = Request.QueryString["q"];
            if (!string.IsNullOrEmpty(encoded))
            {
                try
                {
                    string decoded = Encoding.UTF8.GetString(Convert.FromBase64String(encoded));
                    var q = System.Web.HttpUtility.ParseQueryString(decoded);
                    location = q["location"] ?? "";
                    type     = q["type"]     ?? "";
                    budget   = q["budget"]   ?? "";
                    size     = q["size"]     ?? "";
                    status   = q["status"]   ?? "";
                }
                catch { /* ignore malformed token */ }
            }

            txtLocation.Text = location;

            BindAllDropdowns();   // unchanged — your existing method
            LoadProperties();
        }
    }
    // Placeholder background class based on property type
    protected string GetPlaceholderClass(object typeCode)
    {
        if (typeCode == null) return "ph-default";
        switch (typeCode.ToString().ToLower())
        {
            case "plot": return "ph-plot";
            case "house": return "ph-house";
            case "colony": return "ph-colony";
            case "township": return "ph-township";
            case "commercial": return "ph-commercial";
            default: return "ph-default";
        }
    }
    // ── Search button PostBack ────────────────────────────────────────────────
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        hfPage.Value = "1";
        LoadProperties();
    }

    // ── Core data loader ──────────────────────────────────────────────────────
    private void LoadProperties()
    {
        string loc = txtLocation.Text.Trim();
        string typeVal = ddlProjectType.SelectedValue;  // "0" = All
        string sizeVal = ddlPlotSize.SelectedValue;     // "0" = All
        string budgetVal = ddlBudget.SelectedValue;       // ""  = Any
        string statusVal = ddlStatus.SelectedValue;       // ""  = All

        int page = 1;
        int.TryParse(hfPage.Value, out page);
        if (page < 1) page = 1;

        // WHERE builder
        var where = new StringBuilder("WHERE p.IsDeleted = 0 AND p.IsShowOnWebsite = 1");

        // Store parameter values (not SqlParameter objects)
        var paramValues = new Dictionary<string, object>();

        if (!string.IsNullOrEmpty(loc))
        {
            where.Append(" AND (p.City LIKE @loc OR p.District LIKE @loc OR p.FullAddress LIKE @loc)");
            paramValues["@loc"] = "%" + loc + "%";
        }

        if (!string.IsNullOrEmpty(typeVal) && typeVal != "0")
        {
            where.Append(" AND p.ProjectTypeID = @typeId");
            paramValues["@typeId"] = typeVal;
        }

        if (!string.IsNullOrEmpty(sizeVal) && sizeVal != "0")
        {
            where.Append(" AND EXISTS (SELECT 1 FROM dbo.ProjectUnitTypes pu WHERE pu.ProjectID = p.ProjectID AND pu.UnitTypeID = @sizeId)");
            paramValues["@sizeId"] = sizeVal;
        }

        if (!string.IsNullOrEmpty(statusVal))
        {
            where.Append(" AND p.StatusID = @statusId");
            paramValues["@statusId"] = statusVal;
        }

        // Budget filter
        string budgetClause = "";

        switch (budgetVal)
        {
            case "1":
                budgetClause = "< 5000000";
                break;

            case "2":
                budgetClause = "BETWEEN 5000000 AND 10000000";
                break;

            case "3":
                budgetClause = "BETWEEN 10000001 AND 30000000";
                break;

            case "4":
                budgetClause = "> 30000000";
                break;
        }

        if (!string.IsNullOrEmpty(budgetClause))
        {
            where.Append(" AND (SELECT MIN(pu2.TotalBasePrice) FROM dbo.ProjectUnitTypes pu2 WHERE pu2.ProjectID = p.ProjectID) " + budgetClause);
        }

        using (var con = DBHelper.GetConnection())
        {
            con.Open();

            // ================= COUNT QUERY =================

            string countSql =
                @"SELECT COUNT(DISTINCT p.ProjectID)
              FROM dbo.Projects p
              INNER JOIN dbo.MstProjectTypes pt 
              ON pt.ProjectTypeID = p.ProjectTypeID
              " + where.ToString();

            int total = 0;

            using (var cmd = new SqlCommand(countSql, con))
            {
                foreach (var p in paramValues)
                    cmd.Parameters.AddWithValue(p.Key, p.Value);

                total = (int)cmd.ExecuteScalar();
            }

            int totalPages = (int)Math.Ceiling((double)total / PageSize);

            lblResultCount.Text = total.ToString();

            BuildPagination(page, totalPages);

            // ================= DATA QUERY =================

            int offset = (page - 1) * PageSize;
            int rowStart = offset + 1;
            int rowEnd = offset + PageSize;

            string dataSql =
                @"SELECT ProjectID, ProjectName, City, FullAddress,
                     'https://admin.skyisyourlimit.com/' + REPLACE(CoverImagePath,'~/','') AS CoverImagePath,
                     TotalUnits, TotalLandAreaSqYd,
                     ProjectType, TypeCode, StatusLabel, MinPrice
              FROM
              (
                    SELECT
                        p.ProjectID,
                        p.ProjectName,
                        p.City,
                        p.FullAddress,
                        p.CoverImagePath,
                        p.TotalUnits,
                        p.TotalLandAreaSqYd,
                        pt.TypeName AS ProjectType,
                        pt.TypeCode,
                        p.PublishMode AS StatusLabel,
                        (SELECT MIN(pu3.TotalBasePrice)
                         FROM dbo.ProjectUnitTypes pu3
                         WHERE pu3.ProjectID = p.ProjectID) AS MinPrice,
                        ROW_NUMBER() OVER (ORDER BY p.CreatedAt DESC) AS RowNum
                    FROM dbo.Projects p
                    INNER JOIN dbo.MstProjectTypes pt
                    ON pt.ProjectTypeID = p.ProjectTypeID
                    " + where.ToString() + @"
                    GROUP BY
                        p.ProjectID,
                        p.ProjectName,
                        p.City,
                        p.FullAddress,
                        p.CoverImagePath,
                        p.TotalUnits,
                        p.TotalLandAreaSqYd,
                        pt.TypeName,
                        pt.TypeCode,
                        p.PublishMode,
                        p.CreatedAt
              ) AS Paged
              WHERE RowNum BETWEEN " + rowStart + " AND " + rowEnd;

            var dt = new DataTable();

            using (var cmd = new SqlCommand(dataSql, con))
            {
                foreach (var p in paramValues)
                    cmd.Parameters.AddWithValue(p.Key, p.Value);

                new SqlDataAdapter(cmd).Fill(dt);
            }

            rptProperties.DataSource = dt;
            rptProperties.DataBind();

            pnlNoResults.Visible = (dt.Rows.Count == 0);
        }
    }
    //private void LoadProperties()
    //{
    //    string loc       = txtLocation.Text.Trim();
    //    string typeVal   = ddlProjectType.SelectedValue;  // "0" = All
    //    string sizeVal   = ddlPlotSize.SelectedValue;     // "0" = All
    //    string budgetVal = ddlBudget.SelectedValue;       // ""  = Any
    //    string statusVal = ddlStatus.SelectedValue;       // ""  = All

    //    int page = 1;
    //    int.TryParse(hfPage.Value, out page);
    //    if (page < 1) page = 1;

    //    // ── Dynamic WHERE ────────────────────────────────────────────────────
    //    var where = new StringBuilder("WHERE p.IsDeleted = 0 AND p.IsShowOnWebsite = 1");
    //    var parms = new List<SqlParameter>();

    //    if (!string.IsNullOrEmpty(loc))
    //    {
    //        where.Append(" AND (p.City LIKE @loc OR p.District LIKE @loc OR p.FullAddress LIKE @loc)");
    //        parms.Add(new SqlParameter("@loc", "%" + loc + "%"));
    //    }

    //    if (!string.IsNullOrEmpty(typeVal) && typeVal != "0")
    //    {
    //        where.Append(" AND p.ProjectTypeID = @typeId");
    //        parms.Add(new SqlParameter("@typeId", typeVal));
    //    }

    //    if (!string.IsNullOrEmpty(sizeVal) && sizeVal != "0")
    //    {
    //        where.Append(" AND EXISTS (SELECT 1 FROM dbo.ProjectUnitTypes pu WHERE pu.ProjectID = p.ProjectID AND pu.UnitTypeID = @sizeId)");
    //        parms.Add(new SqlParameter("@sizeId", sizeVal));
    //    }

    //    if (!string.IsNullOrEmpty(statusVal))
    //    {
    //        where.Append(" AND p.StatusID = @statusId");
    //        parms.Add(new SqlParameter("@statusId", statusVal));
    //    }

    //    // Budget — compare against cheapest unit price for the project
    //    string budgetClause = "";
    //    switch (budgetVal)
    //    {
    //        case "1": budgetClause = "< 5000000";                    break;  // Under 50 Lac
    //        case "2": budgetClause = "BETWEEN 5000000 AND 10000000"; break;  // 50L – 1 Cr
    //        case "3": budgetClause = "BETWEEN 10000001 AND 30000000";break;  // 1–3 Cr
    //        case "4": budgetClause = "> 30000000";                   break;  // 3 Cr+
    //    }
    //    if (!string.IsNullOrEmpty(budgetClause))
    //        where.Append(" AND (SELECT MIN(pu2.TotalBasePrice) FROM dbo.ProjectUnitTypes pu2 WHERE pu2.ProjectID = p.ProjectID) " + budgetClause);

    //    // ── Execute ──────────────────────────────────────────────────────────
    //    using (var con = DBHelper.GetConnection())
    //    {
    //        con.Open();

    //        // Total count
    //        string countSql =
    //            "SELECT COUNT(DISTINCT p.ProjectID) " +
    //            "FROM   dbo.Projects p " +
    //            "INNER JOIN dbo.MstProjectTypes pt ON pt.ProjectTypeID = p.ProjectTypeID " +
    //            where.ToString();

    //        int total = 0;
    //        using (var cmd = new SqlCommand(countSql, con))
    //        {
    //            cmd.Parameters.AddRange(parms.ToArray());
    //            total = (int)cmd.ExecuteScalar();
    //        }

    //        int totalPages = (int)Math.Ceiling((double)total / PageSize);
    //        lblResultCount.Text = total.ToString();
    //        BuildPagination(page, totalPages);

    //        // Paged rows - using ROW_NUMBER() for SQL Server 2008 compatibility
    //        int offset   = (page - 1) * PageSize;
    //        int rowStart = offset + 1;
    //        int rowEnd   = offset + PageSize;

    //        string dataSql =
    //            "SELECT ProjectID, ProjectName, City, FullAddress, 'https://admin.skyisyourlimit.com/'+replace(CoverImagePath,'~/','') as CoverImagePath, " +
    //            "       TotalUnits, TotalLandAreaSqYd, ProjectType, TypeCode, StatusLabel, MinPrice " +
    //            "FROM ( " +
    //            "  SELECT " +
    //            "    p.ProjectID, p.ProjectName, p.City, p.FullAddress, p.CoverImagePath, " +
    //            "    p.TotalUnits, p.TotalLandAreaSqYd, " +
    //            "    pt.TypeName AS ProjectType, pt.TypeCode, " +
    //            "    p.PublishMode AS StatusLabel, " +
    //            "    (SELECT MIN(pu3.TotalBasePrice) FROM dbo.ProjectUnitTypes pu3 WHERE pu3.ProjectID = p.ProjectID) AS MinPrice, " +
    //            "    ROW_NUMBER() OVER (ORDER BY p.CreatedAt DESC) AS RowNum " +
    //            "  FROM dbo.Projects p " +
    //            "  INNER JOIN dbo.MstProjectTypes pt ON pt.ProjectTypeID = p.ProjectTypeID " +
    //            "  " + where.ToString() + " " +
    //            "  GROUP BY p.ProjectID, p.ProjectName, p.City, p.FullAddress, " +
    //            "           p.CoverImagePath, p.TotalUnits, p.TotalLandAreaSqYd, " +
    //            "           pt.TypeName, pt.TypeCode, p.PublishMode, p.CreatedAt " +
    //            ") AS Paged " +
    //            "WHERE RowNum BETWEEN " + rowStart + " AND " + rowEnd;

    //        var dt = new DataTable();
    //        using (var cmd = new SqlCommand(dataSql, con))
    //        {
    //            cmd.Parameters.AddRange(parms.ToArray());
    //            new SqlDataAdapter(cmd).Fill(dt);
    //        }

    //        rptProperties.DataSource = dt;
    //        rptProperties.DataBind();

    //        pnlNoResults.Visible = (dt.Rows.Count == 0);
    //    }
    //}

    // ── Pagination HTML ───────────────────────────────────────────────────────
    private void BuildPagination(int current, int totalPages)
    {
        if (totalPages <= 1) { litPagination.Text = ""; return; }

        var sb = new StringBuilder();

        if (current > 1)
            sb.AppendFormat("<button class='pg-btn prev-next' onclick='goPage({0})'>← Prev</button>", current - 1);
        else
            sb.Append("<button class='pg-btn prev-next' disabled>← Prev</button>");

        int start = Math.Max(1, current - 2);
        int end   = Math.Min(totalPages, start + 4);

        if (start > 1) sb.Append("<button class='pg-btn' onclick='goPage(1)'>1</button>");
        if (start > 2) sb.Append("<span style='align-self:center;color:var(--slate)'>…</span>");

        for (int i = start; i <= end; i++)
            sb.AppendFormat("<button class='pg-btn{1}' onclick='goPage({0})'>{0}</button>",
                            i, i == current ? " active" : "");

        if (end < totalPages - 1) sb.Append("<span style='align-self:center;color:var(--slate)'>…</span>");
        if (end < totalPages)
            sb.AppendFormat("<button class='pg-btn' onclick='goPage({0})'>{0}</button>", totalPages);

        if (current < totalPages)
            sb.AppendFormat("<button class='pg-btn prev-next' onclick='goPage({0})'>Next →</button>", current + 1);
        else
            sb.Append("<button class='pg-btn prev-next' disabled>Next →</button>");

        litPagination.Text = sb.ToString();
    }

    // ── Your existing dropdown methods — UNCHANGED ────────────────────────────
    public List<ProjectType> GetProjectTypes()
    {
        var list = new List<ProjectType>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT ProjectTypeID, TypeCode, TypeName FROM dbo.MstProjectTypes WHERE IsActive=1 ORDER BY TypeName", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new ProjectType
                    {
                        ProjectTypeID = Convert.ToInt32(dr["ProjectTypeID"]),
                        TypeCode      = dr["TypeCode"].ToString(),
                        TypeName      = dr["TypeName"].ToString()
                    });
        }
        return list;
    }

    public List<UnitTypeMaster> GetUnitTypes()
    {
        var list = new List<UnitTypeMaster>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT UnitTypeID, UnitTypeName FROM dbo.MstUnitTypes ORDER BY UnitTypeID", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new UnitTypeMaster
                    {
                        UnitTypeID   = Convert.ToInt32(dr["UnitTypeID"]),
                        UnitTypeName = dr["UnitTypeName"].ToString()
                    });
        }
        return list;
    }

    private void BindAllDropdowns()
    {
        ddlProjectType.DataSource     = GetProjectTypes();
        ddlProjectType.DataTextField  = "TypeName";
        ddlProjectType.DataValueField = "ProjectTypeID";
        ddlProjectType.DataBind();
        ddlProjectType.Items.Insert(0, new ListItem("-- Select Type --", "0"));

        ddlPlotSize.DataSource     = GetUnitTypes();
        ddlPlotSize.DataTextField  = "UnitTypeName";
        ddlPlotSize.DataValueField = "UnitTypeID";
        ddlPlotSize.DataBind();
        ddlPlotSize.Items.Insert(0, new ListItem("-- Select Size --", "0"));

        // Restore values from decoded query-string
        if (!string.IsNullOrEmpty(type) && type != "0")
            ddlProjectType.SelectedValue = type;

        if (!string.IsNullOrEmpty(size) && size != "0")
            ddlPlotSize.SelectedValue = size;
    }

    // ── Repeater helper methods — called from <%# %> in the ASPX ─────────────
    protected string GetBadgeClass(object statusLabel)
    {
        switch ((statusLabel ?? "").ToString().ToLower())
        {
            case "active":     return "badge-new";
            case "upcoming":   return "badge-up";
            case "pre-launch": return "badge-up";
            case "sold out":   return "badge-hot";
            default:           return "badge-ft";
        }
    }

    protected string GetBadgeText(object statusLabel)
    {
        switch ((statusLabel ?? "").ToString().ToLower())
        {
            case "active":     return "✅ Active";
            case "upcoming":   return "🕐 Upcoming";
            case "pre-launch": return "🚀 Pre-Launch";
            case "sold out":   return "🔥 Sold Out";
            default:           return statusLabel != null ? statusLabel.ToString() : "Listed";
        }
    }

    protected string GetTypeEmoji(object typeCode)
    {
        switch ((typeCode ?? "").ToString().ToLower())
        {
            case "res":   return "🏡";
            case "com":   return "🏢";
            case "mixed": return "🏙️";
            case "plot":  return "📐";
            default:      return "🏘️";
        }
    }

    protected string GetStatusColor(object statusLabel)
    {
        switch ((statusLabel ?? "").ToString().ToLower())
        {
            case "active":   return "#22C55E";
            case "sold out": return "#EF4444";
            default:         return "var(--gold)";
        }
    }

    protected string FormatPrice(object priceObj)
    {
        if (priceObj == null || priceObj == DBNull.Value) return "On Request";
        decimal p = Convert.ToDecimal(priceObj);
        if (p >= 10000000) return "₹ " + (p / 10000000m).ToString("0.##") + " Cr";
        if (p >= 100000)   return "₹ " + (p / 100000m).ToString("0.##") + " Lac";
        return "₹ " + p.ToString("N0");
    }

    protected string FormatArea(object areaObj)
    {
        if (areaObj == null || areaObj == DBNull.Value) return "—";
        return Convert.ToDecimal(areaObj).ToString("0.##") + " Sq.Yd";
    }

    protected string GetCoverUrl(object imgPath)
    {
        string path = (imgPath ?? "").ToString().Trim();
        if (string.IsNullOrEmpty(path)) return "";

        // Already absolute URL hai
        if (path.StartsWith("http://") || path.StartsWith("https://"))
            return path;

        // ~ wala path ResolveUrl handle karta hai
        if (path.StartsWith("~/"))
            return ResolveUrl(path);

        // Sirf filename hai jaise "abc.jpg"
        if (!path.StartsWith("/"))
            return ResolveUrl("~/Uploads/" + path); // apna folder naam likho

        // Already "/" se start ho raha
        return path;
    }
}
