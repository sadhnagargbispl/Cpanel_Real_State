using System;
using System.Collections.Generic;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.UI;

public partial class ProjectList : System.Web.UI.Page
{
    private ProjectDAL _projectDAL = new ProjectDAL();

    private string CurrentUser
    {
        get { return Session["UserName"] != null ? Session["UserName"].ToString() : "admin"; }
    }

    // ─────────────────────────────────────────────
    //  PAGE LOAD
    // ─────────────────────────────────────────────
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadProjects();

            // ── Toast message agar ProjectCreate se redirect hua ho ──
            if (Request.QueryString["msg"] != null)
            {
                string msg  = Request.QueryString["msg"];
                string type = Request.QueryString["type"] ?? "success";
                ShowToast(Server.HtmlDecode(msg), type);
            }
        }
    }

    // ─────────────────────────────────────────────
    //  LOAD ALL PROJECTS → JS mein inject karo
    // ─────────────────────────────────────────────
    private void LoadProjects()
    {
        try
        {
            var projects = _projectDAL.GetAllProjects();

            if (projects == null || projects.Count == 0)
            {
                litProjectsJSON.Text = "<script>initProjects([]);</script>";
                return;
            }

            var js   = new JavaScriptSerializer();
            var list = new List<object>();

            foreach (var p in projects)
            {
                list.Add(new
                {
                    ProjectID        = p.ProjectID,
                    ProjectCode      = p.ProjectCode      ?? "",
                    ProjectName      = p.ProjectName      ?? "",
                    ProjectType      = p.ProjectType      ?? "",
                    RERANumber       = p.RERANumber       ?? "",
                    City             = p.City             ?? "",
                    StateName        = p.StateName        ?? "",
                    BranchName       = p.BranchName       ?? "",
                    ProjectManager   = p.ProjectManager   ?? "",
                    TotalUnits       = p.TotalUnits,
                    BSPRatePerSqFt   = p.BSPRatePerSqFt,
                    PossessionDate   = p.PossessionDate != DateTime.MinValue
                                         ? p.PossessionDate.ToString("yyyy-MM-dd") : "",
                    LaunchDate       = p.LaunchDate.HasValue
                                         ? p.LaunchDate.Value.ToString("yyyy-MM-dd") : "",
                    PublishMode      = p.PublishMode      ?? "draft",
                    ProjectStatus    = p.ProjectStatus    ?? "",
                    AmenityCount     = p.AmenityCount,
                    DocumentCount    = p.DocumentCount,
                    // ▼ Cover image aur Logo — ProjectSummary se directly
                    CoverImagePath   = !string.IsNullOrEmpty(p.CoverImagePath)
                                         ? ResolveUrl(p.CoverImagePath) : "",
                    ProjectLogoBadge = !string.IsNullOrEmpty(p.ProjectLogoBadge)
                                         ? ResolveUrl(p.ProjectLogoBadge) : "",
                    CreatedAt        = p.CreatedAt.ToString("dd MMM yyyy")
                });
            }

            string json = js.Serialize(list);
            // XSS safe — JSON encode for inline script
            litProjectsJSON.Text = string.Format(
                "<script>initProjects({0});</script>", json);
        }
        catch (Exception ex)
        {
            ShowToast("Error loading projects: " + ex.Message, "error");
            litProjectsJSON.Text = "<script>initProjects([]);</script>";
        }
    }

    // ─────────────────────────────────────────────
    //  DELETE PROJECT
    // ─────────────────────────────────────────────
    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        int pid = 0;
        if (!int.TryParse(hdnDeleteID.Value, out pid) || pid <= 0)
        {
            ShowToast("Invalid project ID.", "error");
            return;
        }

        try
        {
            _projectDAL.DeleteProject(pid, CurrentUser);
            ShowToast("Project deleted successfully.", "success");
            LoadProjects();   // Refresh list
        }
        catch (Exception ex)
        {
            ShowToast("Error deleting project: " + ex.Message, "error");
        }
        finally
        {
            hdnDeleteID.Value = "";
            // Modal close karo
            ScriptManager.RegisterStartupScript(this, GetType(), "closeModal",
                "closeDeleteModal();", true);
        }
    }

    // ─────────────────────────────────────────────
    //  TOAST HELPER
    // ─────────────────────────────────────────────
    private void ShowToast(string msg, string type)
    {
        msg = msg.Replace("'", "\\'");
        ScriptManager.RegisterStartupScript(this, GetType(), "toast_" + DateTime.Now.Ticks,
            string.Format("showToast('{0}','{1}');", msg, type), true);
    }
}
