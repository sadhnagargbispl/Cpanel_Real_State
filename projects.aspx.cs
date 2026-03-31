using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class projects : System.Web.UI.Page
{
    const int PageSize = 12;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDropdowns();
            LoadProjects();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        hfPage.Value = "1";
        LoadProjects();
    }

    protected void ddlSort_Changed(object sender, EventArgs e)
    {
        hfPage.Value = "1";
        LoadProjects();
    }

    // ── Bind filter dropdowns ─────────────────────────────────────────────────
    private void BindDropdowns()
    {
        // Project Types
        var typeList = new List<KeyValuePair<string, string>>();
        typeList.Add(new KeyValuePair<string, string>("0", "All Types"));

        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT ProjectTypeID, TypeName FROM dbo.MstProjectTypes WHERE IsActive=1 ORDER BY TypeName", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    typeList.Add(new KeyValuePair<string, string>(
                        dr["ProjectTypeID"].ToString(), dr["TypeName"].ToString()));
        }

        ddlType.DataSource     = typeList;
        ddlType.DataTextField  = "Value";
        ddlType.DataValueField = "Key";
        ddlType.DataBind();

        // Cities (distinct from Projects table)
        var cityList = new List<string>();
        cityList.Add("");

        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT DISTINCT City FROM dbo.Projects WHERE IsDeleted=0 AND IsShowOnWebsite=1 AND City IS NOT NULL AND City <> '' ORDER BY City", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    cityList.Add(dr["City"].ToString());
        }

        ddlCity.Items.Clear();
        ddlCity.Items.Add(new ListItem("All Cities", ""));
        foreach (var c in cityList)
            if (!string.IsNullOrEmpty(c))
                ddlCity.Items.Add(new ListItem(c, c));
    }

    // ── Core loader ───────────────────────────────────────────────────────────
    private void LoadProjects()
    {
        string search    = txtSearch.Text.Trim();
        string typeVal   = ddlType.SelectedValue;
        string statusVal = ddlStatus.SelectedValue;
        string cityVal   = ddlCity.SelectedValue;
        string sortVal   = ddlSort.SelectedValue;

        int page = 1;
        int.TryParse(hfPage.Value, out page);
        if (page < 1) page = 1;

        // ── WHERE ────────────────────────────────────────────────────────────
        var where       = new StringBuilder("WHERE p.IsDeleted = 0 AND p.IsShowOnWebsite = 1");
        var paramValues = new Dictionary<string, object>();

        if (!string.IsNullOrEmpty(search))
        {
            where.Append(" AND (p.ProjectName LIKE @search OR p.City LIKE @search OR p.FullAddress LIKE @search)");
            paramValues["@search"] = "%" + search + "%";
        }

        if (!string.IsNullOrEmpty(typeVal) && typeVal != "0")
        {
            where.Append(" AND p.ProjectTypeID = @typeId");
            paramValues["@typeId"] = typeVal;
        }

        if (!string.IsNullOrEmpty(statusVal))
        {
            where.Append(" AND p.PublishMode = @status");
            paramValues["@status"] = statusVal;
        }

        if (!string.IsNullOrEmpty(cityVal))
        {
            where.Append(" AND p.City = @city");
            paramValues["@city"] = cityVal;
        }

        // ── ORDER BY ────────────────────────────────────────────────────────
        string orderBy;
        switch (sortVal)
        {
            case "oldest":    orderBy = "p.CreatedAt ASC";  break;
            case "price_asc": orderBy = "(SELECT MIN(pu.TotalBasePrice) FROM dbo.ProjectUnitTypes pu WHERE pu.ProjectID = p.ProjectID) ASC";     break;
            case "price_desc":orderBy = "(SELECT MIN(pu.TotalBasePrice) FROM dbo.ProjectUnitTypes pu WHERE pu.ProjectID = p.ProjectID) DESC";    break;
            case "name":      orderBy = "p.ProjectName ASC";break;
            default:          orderBy = "p.CreatedAt DESC"; break;
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
                foreach (var kv in paramValues)
                    cmd.Parameters.AddWithValue(kv.Key, kv.Value);
                total = (int)cmd.ExecuteScalar();
            }

            lblCount.Text = total.ToString();
            int totalPages = (int)Math.Ceiling((double)total / PageSize);
            BuildPagination(page, totalPages);

            // DATA
            int offset   = (page - 1) * PageSize;
            int rowStart = offset + 1;
            int rowEnd   = offset + PageSize;

            string dataSql =
                @"SELECT ProjectID, ProjectName, City, FullAddress,
                         'https://admin.skyisyourlimit.com/' + REPLACE(CoverImagePath,'~/','') AS CoverImagePath,
                         TotalUnits, TotalLandAreaSqYd, ProjectType, TypeCode, StatusLabel, MinPrice
                  FROM
                  (
                      SELECT
                          p.ProjectID, p.ProjectName, p.City, p.FullAddress, p.CoverImagePath,
                          p.TotalUnits, p.TotalLandAreaSqYd,
                          pt.TypeName AS ProjectType, pt.TypeCode,
                          p.PublishMode AS StatusLabel,
                          (SELECT MIN(pu.TotalBasePrice) FROM dbo.ProjectUnitTypes pu WHERE pu.ProjectID = p.ProjectID) AS MinPrice,
                          ROW_NUMBER() OVER (ORDER BY " + orderBy + @") AS RowNum
                      FROM dbo.Projects p
                      INNER JOIN dbo.MstProjectTypes pt ON pt.ProjectTypeID = p.ProjectTypeID
                      " + where + @"
                      GROUP BY p.ProjectID, p.ProjectName, p.City, p.FullAddress, p.CoverImagePath,
                               p.TotalUnits, p.TotalLandAreaSqYd, pt.TypeName, pt.TypeCode,
                               p.PublishMode, p.CreatedAt
                  ) AS Paged
                  WHERE RowNum BETWEEN " + rowStart + " AND " + rowEnd;

            var dt = new DataTable();
            using (var cmd = new SqlCommand(dataSql, con))
            {
                foreach (var kv in paramValues)
                    cmd.Parameters.AddWithValue(kv.Key, kv.Value);
                new SqlDataAdapter(cmd).Fill(dt);
            }

            rptProjects.DataSource = dt;
            rptProjects.DataBind();
            pnlNoResults.Visible = (dt.Rows.Count == 0);
        }
    }

    // ── Pagination ────────────────────────────────────────────────────────────
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

    // ── Helper methods ────────────────────────────────────────────────────────
    protected string GetDetailUrl(object projectId)
    {
        string param   = "id=" + projectId.ToString();
        string encoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(param));
        return "property-detail.aspx?q=" + encoded;
    }

    protected string GetPlaceholderClass(object typeCode)
    {
        switch ((typeCode ?? "").ToString().ToLower())
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
            default:           return (statusLabel ?? "Listed").ToString();
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
        if (path.StartsWith("http://") || path.StartsWith("https://")) return path;
        if (path.StartsWith("~/")) return ResolveUrl(path);
        if (!path.StartsWith("/")) return ResolveUrl("~/Uploads/" + path);
        return path;
    }
}
