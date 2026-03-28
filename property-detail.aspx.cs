//using DocumentFormat.OpenXml.Drawing.Charts;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class property_detail : System.Web.UI.Page
{
    // ─────────────────────────────────────────────────────────────────────────
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string idStr   = Request.QueryString["id"];
            int    projectId = 0;

            if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out projectId) && projectId > 0)
                LoadPropertyDetail(projectId);
            else
                Response.Redirect("property-search.aspx");
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    private void LoadPropertyDetail(int projectId)
    {
        string sql = @"
            SELECT
                p.ProjectID,
                p.ProjectName,
                p.City,
                p.District,
                p.FullAddress,
                p.CoverImagePath,
                p.TotalUnits,
                p.TotalLandAreaSqYd,
                '' as Description,
                p.LaunchDate,
                 '' as ExpectedPossession,
                 '' as RoadWidthMain,
                 '' as RoadWidthInternal,
                 '' as   IsNOCApproved,
                 '' as   IsRegistryAvailable,
                p.PublishMode                      AS StatusLabel,
                pt.TypeName                        AS ProjectType,
                pt.TypeCode,
                '' as DeveloperName,
                (SELECT MIN(pu.TotalBasePrice)
                 FROM   dbo.ProjectUnitTypes pu
                 WHERE  pu.ProjectID = p.ProjectID) AS MinPrice,
                (SELECT STRING_AGG(ut.UnitTypeName, ', ')
                 FROM   dbo.ProjectUnitTypes pu2
                 INNER JOIN dbo.MstUnitTypes ut ON ut.UnitTypeID = pu2.UnitTypeID
                 WHERE  pu2.ProjectID = p.ProjectID)  AS PlotSizes
            FROM  dbo.Projects p
            INNER JOIN dbo.MstProjectTypes pt ON pt.ProjectTypeID = p.ProjectTypeID

            WHERE p.ProjectID = @id AND p.IsDeleted = 0";
        //LEFT JOIN dbo.MstDevelopers d  ON d.DeveloperID = p.DeveloperID
        using (var con = DBHelper.GetConnection())
        {
            con.Open();

            var dt = new DataTable();
            using (var cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@id", projectId);
                new SqlDataAdapter(cmd).Fill(dt);
            }

            if (dt.Rows.Count == 0)
            {
                Response.Redirect("property-search.aspx");
                return;
            }

            DataRow r = dt.Rows[0];

            // ── Page <title> ──────────────────────────────────────────────────
            Page.Title = r["ProjectName"] + " | Sky Is Your Limit";

            // ── Breadcrumb ────────────────────────────────────────────────────
            litPropertyName.Text = HE(r["ProjectName"]);
            litCityName.Text     = HE(r["City"]);

            // ── Title Row ─────────────────────────────────────────────────────
            litStatusBadge.Text = GetStatusBadgeHtml(r["StatusLabel"]);
            litTypeBadge.Text   = HE(r["ProjectType"]);
            litMainTitle.Text   = HE(r["ProjectName"]);
            litLocation.Text    = HE(r["FullAddress"] != DBNull.Value
                                        ? r["FullAddress"].ToString()
                                        : r["City"].ToString());

            // ── Price ─────────────────────────────────────────────────────────
            litMinPrice.Text = FormatPrice(r["MinPrice"]);

            // ── Inquiry default message ───────────────────────────────────────
            litInquiryDefault.Text = HE(r["ProjectName"]);

            // ── Gallery: cover image ──────────────────────────────────────────
            string imgUrl = ResolveCoverUrl(r["CoverImagePath"]);
            if (!string.IsNullOrEmpty(imgUrl))
            {
                litCoverImage.Text  = string.Format(
                    "<img src='{0}' style='width:100%;height:100%;object-fit:cover;display:block;' alt='{1}'/>",
                    imgUrl, HE(r["ProjectName"]));
                litLightboxMain.Text = string.Format(
                    "<img src='{0}' style='width:100%;height:100%;object-fit:cover;display:block;' alt='{1}'/>",
                    imgUrl, HE(r["ProjectName"]));
                litPhotoCount.Text = "View All Photos";
            }
            else
            {
                string placeholder =
                    "<div style='width:100%;height:100%;background:linear-gradient(135deg,#0D1B4B,#1E6FBF,#2a9fd6);" +
                    "display:flex;align-items:center;justify-content:center;font-size:96px;'>🏙️</div>";
                litCoverImage.Text   = placeholder;
                litLightboxMain.Text = placeholder;
                litPhotoCount.Text   = "View Gallery";
            }

            // ── Quick Stats ───────────────────────────────────────────────────
            litTotalArea.Text  = r["TotalLandAreaSqYd"] != DBNull.Value
                ? Convert.ToDecimal(r["TotalLandAreaSqYd"]).ToString("0.##") + " Sq.Yd"
                : "—";
            litTotalUnits.Text = r["TotalUnits"] != DBNull.Value
                ? r["TotalUnits"].ToString()
                : "—";
            litLaunchDate.Text = r["LaunchDate"] != DBNull.Value
                ? Convert.ToDateTime(r["LaunchDate"]).ToString("MMM yyyy")
                : "—";
            litStatusVal.Text = HE(r["StatusLabel"]);

            // ── Overview ──────────────────────────────────────────────────────
            string desc = r["Description"] != DBNull.Value ? r["Description"].ToString().Trim() : "";
            if (string.IsNullOrEmpty(desc))
                litDescription.Text = "<p>Full project details coming soon. Please contact our agent for comprehensive information about " + HE(r["ProjectName"]) + ".</p>";
            else
                litDescription.Text = "<p>" + System.Web.HttpUtility.HtmlEncode(desc)
                                        .Replace("&#xD;&#xA;", "</p><p>")
                                        .Replace("&#xA;", "</p><p>") + "</p>";

            // ── Details Grid ──────────────────────────────────────────────────
            litProjectType.Text   = HE(r["ProjectType"]);
            litAreaDetail.Text    = litTotalArea.Text;
            litUnitsDetail.Text   = r["TotalUnits"] != DBNull.Value ? r["TotalUnits"] + " Units" : "—";
            litPlotSizes.Text     = r["PlotSizes"] != DBNull.Value ? HE(r["PlotSizes"]) : "—";
            litLaunchDetail.Text  = litLaunchDate.Text;
            //litPossession.Text    = r["ExpectedPossession"] != DBNull.Value
            //    ? Convert.ToDateTime(r["ExpectedPossession"]).ToString("MMMM yyyy")
            //    : "—";
            litStatusDetail.Text  = HE(r["StatusLabel"]);
            litLocationDetail.Text= HE(r["City"]);
            litDeveloper.Text     = r["DeveloperName"] != DBNull.Value ? HE(r["DeveloperName"]) : "—";
            //litApproval.Text      = Convert.ToBoolean(r["IsNOCApproved"]) ? "NOC Approved ✓" : "Pending";
            string rw = "";
            if (r["RoadWidthMain"] != DBNull.Value)     rw += r["RoadWidthMain"] + " ft Main";
            if (r["RoadWidthInternal"] != DBNull.Value) rw += (rw.Length > 0 ? ", " : "") + r["RoadWidthInternal"] + " ft Internal";
            litRoadWidth.Text  = rw.Length > 0 ? rw : "—";
           // litRegistry.Text   = Convert.ToBoolean(r["IsRegistryAvailable"]) ? "Available ✓" : "Not Available";

            // ── Map address ───────────────────────────────────────────────────
            litMapAddress.Text = r["FullAddress"] != DBNull.Value
                ? HE(r["FullAddress"])
                : HE(r["ProjectName"]) + " — " + HE(r["City"]);

            // ── Payment Plan ──────────────────────────────────────────────────
            LoadPaymentPlan(projectId, con);

            // ── Similar Properties ────────────────────────────────────────────
            LoadSimilarProperties(projectId, r["ProjectTypeID"] != null
                ? (object)r["ProjectTypeID"] : DBNull.Value, r["City"].ToString(), con);
        }
    }

    // ── Payment Plan ──────────────────────────────────────────────────────────
    private void LoadPaymentPlan(int projectId, SqlConnection con)
    {
        string sql = @"
            SELECT
                ut.UnitTypeName,
                pu.TotalBasePrice,
                 '200' as BookingAmount,
                '100' as MonthlyInstallment,
                 '12' as InstallmentMonths
            FROM  dbo.ProjectUnitTypes pu
            INNER JOIN dbo.MstUnitTypes ut ON ut.UnitTypeID = pu.UnitTypeID
            WHERE pu.ProjectID = @id
            ORDER BY pu.TotalBasePrice ASC";

        var dt = new DataTable();
        using (var cmd = new SqlCommand(sql, con))
        {
            cmd.Parameters.AddWithValue("@id", projectId);
            new SqlDataAdapter(cmd).Fill(dt);
        }

        if (dt.Rows.Count > 0)
        {
            rptPayment.DataSource = dt;
            rptPayment.DataBind();
            pnlNoPayment.Visible = false;
        }
        else
        {
            rptPayment.DataSource = null;
            rptPayment.DataBind();
            pnlNoPayment.Visible = true;
        }
    }

    // ── Similar Properties ────────────────────────────────────────────────────
    private void LoadSimilarProperties(int currentProjectId, object projectTypeId, string city, SqlConnection con)
    {
        string sql = @"
            SELECT TOP 3
                p.ProjectID,
                p.ProjectName,
                p.City,
                pt.TypeCode,
                (SELECT MIN(pu.TotalBasePrice)
                 FROM dbo.ProjectUnitTypes pu
                 WHERE pu.ProjectID = p.ProjectID) AS MinPrice
            FROM  dbo.Projects p
            INNER JOIN dbo.MstProjectTypes pt ON pt.ProjectTypeID = p.ProjectTypeID
            WHERE p.IsDeleted = 0
              AND p.IsShowOnWebsite = 1
              AND p.ProjectID <> @currentId
              AND (p.ProjectTypeID = @typeId OR p.City = @city)
            ORDER BY NEWID()";

        var dt = new DataTable();
        using (var cmd = new SqlCommand(sql, con))
        {
            cmd.Parameters.AddWithValue("@currentId", currentProjectId);
            cmd.Parameters.AddWithValue("@typeId",    projectTypeId ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@city",      city ?? "");
            new SqlDataAdapter(cmd).Fill(dt);
        }

        rptSimilar.DataSource = dt;
        rptSimilar.DataBind();
    }

    // ── Repeater events ───────────────────────────────────────────────────────
    protected void rptPayment_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
    {
        // Extend here if you need per-row customization
    }

    // ── Helper: Price formatter ───────────────────────────────────────────────
    protected string FormatPrice(object priceObj)
    {
        if (priceObj == null || priceObj == DBNull.Value) return "On Request";
        decimal p = Convert.ToDecimal(priceObj);
        if (p >= 10000000) return "₹ " + (p / 10000000m).ToString("0.##") + " Cr";
        if (p >= 100000)   return "₹ " + (p / 100000m).ToString("0.##") + " Lac";
        return "₹ " + p.ToString("N0");
    }

    // ── Helper: Type emoji ────────────────────────────────────────────────────
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

    // ── Helper: Status badge HTML ─────────────────────────────────────────────
    private string GetStatusBadgeHtml(object status)
    {
        switch ((status ?? "").ToString().ToLower())
        {
            case "active":     return "<span class='pbadge pbadge-active'>● Active</span>";
            case "upcoming":   return "<span class='pbadge pbadge-type'>🕐 Upcoming</span>";
            case "pre-launch": return "<span class='pbadge pbadge-hot'>🚀 Pre-Launch</span>";
            case "sold out":   return "<span class='pbadge pbadge-hot'>🔥 Sold Out</span>";
            default:           return "<span class='pbadge pbadge-type'>" + HE(status) + "</span>";
        }
    }

    // ── Helper: Resolve cover image URL ──────────────────────────────────────
    private string ResolveCoverUrl(object imgPath)
    {
        string path = (imgPath ?? "").ToString().Trim();
        if (string.IsNullOrEmpty(path)) return "";
        if (path.StartsWith("http://") || path.StartsWith("https://")) return path;
        if (path.StartsWith("~/")) return ResolveUrl(path);
        if (!path.StartsWith("/")) return "https://admin.skyisyourlimit.com/" + path.TrimStart('/');
        return path;
    }

    // ── Helper: HtmlEncode shortcut ───────────────────────────────────────────
    private static string HE(object val)
    {
        return System.Web.HttpUtility.HtmlEncode((val ?? "").ToString());
    }
}
