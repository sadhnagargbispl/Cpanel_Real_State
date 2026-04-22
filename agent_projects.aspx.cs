using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class agent_projects : System.Web.UI.Page
{
    // ── Connection String ──
    private string CS = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

    // ── Banner gradients assigned per project type ──
    private static readonly Dictionary<string, string> GradientMap = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
    {
        { "Colony",     "linear-gradient(135deg,#09133A,#1B2B6B)" },
        { "Housing",    "linear-gradient(135deg,#6B2D8B,#9333EA)" },
        { "Plots",      "linear-gradient(135deg,#0F766E,#14B8A6)" },
        { "Township",   "linear-gradient(135deg,#92400E,#D97706)" },
        { "Commercial", "linear-gradient(135deg,#1E3A5F,#2563EB)" },
        { "Green",      "linear-gradient(135deg,#1B4332,#16A34A)" },
    };

    private static readonly Dictionary<string, string> IconMap = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
    {
        { "Colony",     "🏙️" },
        { "Housing",    "🏠" },
        { "Plots",      "📐" },
        { "Township",   "🌆" },
        { "Commercial", "🏢" },
        { "Green",      "🌿" },
    };

    // ── Page Load ──
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Session check
            if (Session["status"] == null)
            {
                Response.Redirect("agent_login.aspx");
                return;
            }

            string agentID = Convert.ToString(Session["idno"]);
            hdnAgentID.Value = agentID.ToString();

            LoadProjects(hdnAgentID.Value);
        }
    }

    // ── Load Projects from DB ──
    // NOTE: AgentProjects table nahi hai
    //       Projects.CreatedBy = @AgentID se agent ke projects milenge
    private void LoadProjects(string agentID)
    {
        DataTable dt = new DataTable();

        string query = @"
            SELECT 
                p.ProjectID,
                p.ProjectName,
                TypeName as ProjectType,
                city as Location,
                UnitStatus as Status,
                0 as TotalPlots,
                COUNT(CASE WHEN pl.UnitStatus = 'Available' THEN 1 END) AS AvailablePlots,
                COUNT(CASE WHEN b.fromid = @AgentID THEN 1 END)  AS MyBookings
            FROM Projects p
            LEFT JOIN Project_Units  pl ON pl.ProjectID = p.ProjectID AND p.CreatedBy = pl.CreatedBy
            LEFT JOIN Bookings b  ON b.PlotID     = pl.unitid
			 LEFT JOIN MstProjectTypes c  ON c.ProjectTypeID     = p.ProjectTypeID
            WHERE p.CreatedBy = @AgentID
            GROUP BY 
                p.ProjectID, p.ProjectName,UnitStatus,TypeName,city
            ORDER BY p.ProjectName";

        using (SqlConnection con = new SqlConnection(CS))
        using (SqlCommand cmd = new SqlCommand(query, con))
        {
            cmd.Parameters.AddWithValue("@AgentID", agentID);
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }

        // Add computed columns for banner gradient & icon
        dt.Columns.Add("BannerGradient", typeof(string));
        dt.Columns.Add("BannerIcon",     typeof(string));

        foreach (DataRow row in dt.Rows)
        {
            string type = row["ProjectType"].ToString();
            row["BannerGradient"] = GetGradient(type);
            row["BannerIcon"]     = GetIcon(type);
        }

        if (dt.Rows.Count == 0)
        {
            pnlEmpty.Visible     = true;
            litProjectCount.Text = "No projects assigned to your account.";
        }
        else
        {
            pnlEmpty.Visible     = false;
            litProjectCount.Text = dt.Rows.Count + " project" + (dt.Rows.Count == 1 ? "" : "s") + " assigned to your account";
            rptProjects.DataSource = dt;
            rptProjects.DataBind();
        }
    }

    // ── ItemDataBound ──
    protected void rptProjects_ItemDataBound(object sender, RepeaterItemEventArgs e) { }

    // ── Helper: Status CSS class ──
    protected string GetStatusClass(string status)
    {
        switch (status.ToLower())
        {
            case "active":   return "status-active";
            case "upcoming": return "status-upcoming";
            case "closed":   return "status-closed";
            default:         return "status-upcoming";
        }
    }

    // ── Helper: Banner gradient by project type ──
    private string GetGradient(string type)
    {
        foreach (var key in GradientMap.Keys)
            if (type.IndexOf(key, StringComparison.OrdinalIgnoreCase) >= 0)
                return GradientMap[key];
        return "linear-gradient(135deg,#1B2B6B,#1E6FBF)";
    }

    // ── Helper: Banner icon by project type ──
    private string GetIcon(string type)
    {
        foreach (var key in IconMap.Keys)
            if (type.IndexOf(key, StringComparison.OrdinalIgnoreCase) >= 0)
                return IconMap[key];
        return "🏘️";
    }

    // ──────────────────────────────────────────────
    //  WebMethod: Submit Project Access Request
    // ──────────────────────────────────────────────
    [WebMethod]
    public static string SubmitProjectRequest(string projectName, string note)
    {
        try
        {
            if (HttpContext.Current.Session["AgentID"] == null)
                return Newtonsoft.Json.JsonConvert.SerializeObject(new { Success = false, Message = "Session expired." });

            int    agentID = Convert.ToInt32(HttpContext.Current.Session["AgentID"]);
            string cs      = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            string query = @"
                INSERT INTO ProjectAccessRequests (AgentID, ProjectName, Note, RequestDate, Status)
                VALUES (@AgentID, @ProjectName, @Note, GETDATE(), 'Pending')";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@AgentID",     agentID);
                cmd.Parameters.AddWithValue("@ProjectName", projectName);
                cmd.Parameters.AddWithValue("@Note",        string.IsNullOrEmpty(note) ? "" : note);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            return Newtonsoft.Json.JsonConvert.SerializeObject(new { Success = true });
        }
        catch (Exception ex)
        {
            return Newtonsoft.Json.JsonConvert.SerializeObject(new { Success = false, Message = ex.Message });
        }
    }
}
