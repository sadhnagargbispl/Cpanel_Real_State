using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class property_search : System.Web.UI.Page
{
    string type     = "";
    string size     = "";
    string location = "";
    string budget   = "";
    string status   = "";

    const int PageSize = 9;

    protected void Page_Load(object sender, EventArgs e)
    {
        ClientScript.GetPostBackEventReference(btnSearch, "");
        if (!IsPostBack)
        {
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
                catch { }
            }

            txtLocation.Text = location;
            BindAllDropdowns();
            BindSidebarFilters();
            LoadProperties();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        hfPage.Value = "1";
        BindSidebarFilters();
        LoadProperties();
    }

    private void LoadProperties()
    {
        string loc       = txtLocation.Text.Trim();
        string typeVal   = ddlProjectType.SelectedValue;
        string sizeVal   = ddlPlotSize.SelectedValue;
        string statusVal = ddlStatus.SelectedValue;
        string sortVal = ddlSort.SelectedValue;
        // Budget from slider (0=Any,1=Under50L,2=50L-1Cr,3=1Cr-3Cr,4=3Cr+)
        int budgetIdx = 0;
        int.TryParse(hfBudgetRange.Value, out budgetIdx);

        int page = 1;
        int.TryParse(hfPage.Value, out page);
        if (page < 1) page = 1;

        var where       = new StringBuilder("WHERE p.IsDeleted = 0 AND p.IsShowOnWebsite = 1");
        var paramValues = new Dictionary<string, object>();

        // Location
        if (!string.IsNullOrEmpty(loc))
        {
            where.Append(" AND (p.City LIKE @loc OR p.District LIKE @loc OR p.FullAddress LIKE @loc)");
            paramValues["@loc"] = "%" + loc + "%";
        }

        // Top bar: Project Type dropdown
        if (!string.IsNullOrEmpty(typeVal) && typeVal != "0")
        {
            where.Append(" AND p.ProjectTypeID = @typeId");
            paramValues["@typeId"] = typeVal;
        }

        // Top bar: Plot Size dropdown
        if (!string.IsNullOrEmpty(sizeVal) && sizeVal != "0")
        {
            where.Append(" AND EXISTS (SELECT 1 FROM dbo.ProjectUnitTypes pu WHERE pu.ProjectID = p.ProjectID AND pu.UnitTypeID = @sizeId)");
            paramValues["@sizeId"] = sizeVal;
        }

        // Top bar: Status dropdown
        if (!string.IsNullOrEmpty(statusVal))
        {
            where.Append(" AND p.StatusID = @statusId");
            paramValues["@statusId"] = statusVal;
        }

        // Budget slider
        string budgetClause = "";
        switch (budgetIdx)
        {
            case 1: budgetClause = "< 5000000";                     break; // Under 50L
            case 2: budgetClause = "BETWEEN 5000000 AND 10000000";  break; // 50L-1Cr
            case 3: budgetClause = "BETWEEN 10000001 AND 30000000"; break; // 1Cr-3Cr
            case 4: budgetClause = "> 30000000";                    break; // 3Cr+
        }
        // ── ORDER BY ────────────────────────────────────────────────────────
        string orderBy;
        switch (sortVal)
        {
            case "oldest": orderBy = "p.CreatedAt ASC"; break;
            case "price_asc": orderBy = "(SELECT MIN(pu.TotalBasePrice) FROM dbo.ProjectUnitTypes pu WHERE pu.ProjectID = p.ProjectID) ASC"; break;
            case "price_desc": orderBy = "(SELECT MIN(pu.TotalBasePrice) FROM dbo.ProjectUnitTypes pu WHERE pu.ProjectID = p.ProjectID) DESC"; break;
            case "name": orderBy = "p.ProjectName ASC"; break;
            default: orderBy = "p.CreatedAt DESC"; break;
        }
        if (!string.IsNullOrEmpty(budgetClause))
            where.Append(" AND (SELECT MIN(pu2.TotalBasePrice) FROM dbo.ProjectUnitTypes pu2 WHERE pu2.ProjectID = p.ProjectID) " + budgetClause);

        // Sidebar: Type checkboxes
        string selTypes = hfSelectedTypes.Value;
        if (!string.IsNullOrEmpty(selTypes))
        {
            var safeIds = new List<string>();
            foreach (var id in selTypes.Split(','))
            {
                int n;
                if (int.TryParse(id.Trim(), out n)) safeIds.Add(n.ToString());
            }
            if (safeIds.Count > 0)
                where.Append(" AND p.ProjectTypeID IN (" + string.Join(",", safeIds) + ")");
        }

        // Sidebar: Status checkboxes
        string selStatuses = hfSelectedStatuses.Value;
        if (!string.IsNullOrEmpty(selStatuses))
        {
            var labels     = selStatuses.Split(',');
            var paramNames = new List<string>();
            int si         = 0;
            foreach (var lbl in labels)
            {
                string pName = "@sLabel" + si++;
                paramNames.Add(pName);
                paramValues[pName] = lbl.Trim();
            }
            if (paramNames.Count > 0)
                where.Append(" AND p.PublishMode IN (" + string.Join(",", paramNames) + ")");
        }

        using (var con = DBHelper.GetConnection())
        {
            con.Open();

            // COUNT
            string countSql =
                @"SELECT COUNT(DISTINCT p.ProjectID)
                  FROM dbo.Projects p
                  INNER JOIN dbo.MstProjectTypes pt ON pt.ProjectTypeID = p.ProjectTypeID
                  " + where;

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

            // DATA
            int offset   = (page - 1) * PageSize;
            int rowStart = offset + 1;
            int rowEnd   = offset + PageSize;

            string dataSql =
                @"SELECT ProjectID, ProjectName, City, FullAddress,
                         'https://admin.skyisyourlimit.com/' + REPLACE(CoverImagePath,'~/','') AS CoverImagePath,
                         TotalUnits, TotalLandAreaSqYd,
                         ProjectType, TypeCode, StatusLabel, MinPrice
                  FROM
                  (
                        SELECT
                            p.ProjectID, p.ProjectName, p.City, p.FullAddress, p.CoverImagePath,
                            p.TotalUnits, p.TotalLandAreaSqYd,
                            pt.TypeName AS ProjectType, pt.TypeCode,
                            p.PublishMode AS StatusLabel,
                            (SELECT MIN(pu3.TotalBasePrice)
                             FROM dbo.ProjectUnitTypes pu3
                             WHERE pu3.ProjectID = p.ProjectID) AS MinPrice,
                            ROW_NUMBER() OVER (ORDER BY " + orderBy + @") AS RowNum
                        FROM dbo.Projects p
                        INNER JOIN dbo.MstProjectTypes pt ON pt.ProjectTypeID = p.ProjectTypeID
                        " + where + @"
                        GROUP BY
                            p.ProjectID, p.ProjectName, p.City, p.FullAddress, p.CoverImagePath,
                            p.TotalUnits, p.TotalLandAreaSqYd,
                            pt.TypeName, pt.TypeCode, p.PublishMode, p.CreatedAt
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
    protected void ddlSort_Changed(object sender, EventArgs e)
    {
        hfPage.Value = "1";
        BindSidebarFilters();
        LoadProperties();
    }
    private void BindSidebarFilters()
    {
        using (var con = DBHelper.GetConnection())
        {
            con.Open();

            string typeSql = @"
                SELECT pt.ProjectTypeID, pt.TypeName,
                       COUNT(DISTINCT p.ProjectID) AS Count
                FROM   dbo.MstProjectTypes pt
                LEFT JOIN dbo.Projects p
                    ON p.ProjectTypeID = pt.ProjectTypeID
                   AND p.IsDeleted = 0 AND p.IsShowOnWebsite = 1
                WHERE  pt.IsActive = 1
                GROUP BY pt.ProjectTypeID, pt.TypeName
                ORDER BY pt.TypeName";

            var typeList = new List<TypeFilterItem>();
            using (var cmd = new SqlCommand(typeSql, con))
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    typeList.Add(new TypeFilterItem
                    {
                        ProjectTypeID = Convert.ToInt32(dr["ProjectTypeID"]),
                        TypeName      = dr["TypeName"].ToString(),
                        Count         = Convert.ToInt32(dr["Count"])
                    });

            rptTypeFilter.DataSource = typeList;
            rptTypeFilter.DataBind();

            string statusSql = @"
                SELECT p.PublishMode AS StatusLabel,
                       COUNT(DISTINCT p.ProjectID) AS Count
                FROM   dbo.Projects p
                WHERE  p.IsDeleted = 0 AND p.IsShowOnWebsite = 1
                GROUP BY p.PublishMode
                ORDER BY p.PublishMode";

            var statusList = new List<StatusFilterItem>();
            using (var cmd2 = new SqlCommand(statusSql, con))
            using (var dr2 = cmd2.ExecuteReader())
                while (dr2.Read())
                    statusList.Add(new StatusFilterItem
                    {
                        StatusID    = dr2["StatusLabel"].ToString(),
                        StatusLabel = dr2["StatusLabel"].ToString(),
                        Count       = Convert.ToInt32(dr2["Count"])
                    });

            rptStatusFilter.DataSource = statusList;
            rptStatusFilter.DataBind();
        }
    }

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

        if (!string.IsNullOrEmpty(type) && type != "0")
            ddlProjectType.SelectedValue = type;

        if (!string.IsNullOrEmpty(size) && size != "0")
            ddlPlotSize.SelectedValue = size;
    }

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

    // ── Repeater helpers ──────────────────────────────────────────────────────

    protected string GetPlaceholderClass(object typeCode)
    {
        if (typeCode == null) return "ph-default";
        switch (typeCode.ToString().ToLower())
        {
            case "plot":       return "ph-plot";
            case "house":      return "ph-house";
            case "colony":     return "ph-colony";
            case "township":   return "ph-township";
            case "commercial": return "ph-commercial";
            default:           return "ph-default";
        }
    }

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

    // Returns Base64-encoded URL for property detail page
    protected string GetDetailUrl(object projectId)
    {
        string param = "id=" + projectId.ToString();
        string encoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(param));
        return "property-detail.aspx?q=" + encoded;
    }

    // Returns "checked" if this typeId is in hfSelectedTypes (restores checkbox state after postback)
    protected string IsTypeChecked(object typeId)
    {
        if (typeId == null || string.IsNullOrEmpty(hfSelectedTypes.Value)) return "";
        var ids = hfSelectedTypes.Value.Split(',');
        foreach (var id in ids)
            if (id.Trim() == typeId.ToString()) return "checked";
        return "";
    }

    // Returns "checked" if this statusLabel is in hfSelectedStatuses
    protected string IsStatusChecked(object statusLabel)
    {
        if (statusLabel == null || string.IsNullOrEmpty(hfSelectedStatuses.Value)) return "";
        var labels = hfSelectedStatuses.Value.Split(',');
        foreach (var lbl in labels)
            if (string.Equals(lbl.Trim(), statusLabel.ToString(), StringComparison.OrdinalIgnoreCase)) return "checked";
        return "";
    }

    protected string GetCoverUrl(object imgPath)
    {
        string path = (imgPath ?? "").ToString().Trim();
        if (string.IsNullOrEmpty(path)) return "";
        if (path.StartsWith("http://") || path.StartsWith("https://")) return path;
        if (path.StartsWith("~/")) return ResolveUrl(path);
        if (!path.StartsWith("/")) return ResolveUrl("~/Uploads/" + path);
        return path;
    }
}

// ── Model classes ─────────────────────────────────────────────────────────────

public class TypeFilterItem
{
    public int    ProjectTypeID { get; set; }
    public string TypeName      { get; set; }
    public int    Count         { get; set; }
}

public class StatusFilterItem
{
    public string StatusID    { get; set; }
    public string StatusLabel { get; set; }
    public int    Count       { get; set; }
}
