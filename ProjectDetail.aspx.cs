using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

public partial class ProjectDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // FIX: Force UTF-8 on every response to prevent encoding corruption
        Response.ContentEncoding = Encoding.UTF8;
        Response.Charset         = "utf-8";
        Response.ContentType     = "text/html";

        if (!IsPostBack)
        {
            int pid = 0;
            if (Request.QueryString["pid"] != null)
                int.TryParse(Request.QueryString["pid"], out pid);

            if (pid > 0)
                LoadProject(pid);
            else
                Response.Redirect("ProjectList.aspx");
        }
    }

    private void LoadProject(int projectId)
    {
        try
        {
            string connStr = System.Configuration.ConfigurationManager
                .ConnectionStrings["constr"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("Sp_GetProjectFullDetail", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ProjectID", projectId);

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    var payload = new Dictionary<string, object>();

                    // ── 1. MAIN PROJECT DATA ─────────────────────────────────────────
                    if (dr.Read())
                    {
                        for (int i = 0; i < dr.FieldCount; i++)
                        {
                            object dbVal = dr.IsDBNull(i) ? null : dr.GetValue(i);

                            // FIX: Convert DateTime immediately to ISO string
                            // This prevents JavaScriptSerializer from emitting /Date(...)/ tokens
                            // which caused the â€" corruption bug
                            if (dbVal is DateTime)
                                dbVal = ((DateTime)dbVal).ToString("yyyy-MM-dd");

                            payload[dr.GetName(i)] = dbVal;
                        }
                    }
                    else
                    {
                        Response.Redirect("ProjectList.aspx");
                        return;
                    }

                    // ── 2. GALLERY ───────────────────────────────────────────────────
                    dr.NextResult();
                    var images    = new List<string>();
                    int imgPathIdx = -1;
                    try { imgPathIdx = dr.GetOrdinal("ImagePath"); } catch { }

                    while (dr.Read())
                    {
                        if (imgPathIdx >= 0 && !dr.IsDBNull(imgPathIdx))
                        {
                            string rawPath = dr.GetString(imgPathIdx).Trim();
                            if (!string.IsNullOrWhiteSpace(rawPath))
                            {
                                string url = rawPath.StartsWith("~/")
                                    ? VirtualPathUtility.ToAbsolute(rawPath)
                                    : rawPath;
                                images.Add(url);
                            }
                        }
                    }
                    payload["Images"] = images;

                    // Resolve CoverImagePath virtual path
                    if (payload.ContainsKey("CoverImagePath") && payload["CoverImagePath"] != null)
                    {
                        string cover = payload["CoverImagePath"].ToString().Trim();
                        if (cover.StartsWith("~/"))
                            payload["CoverImagePath"] = VirtualPathUtility.ToAbsolute(cover);
                    }

                    // ── 3. AMENITIES ─────────────────────────────────────────────────
                    dr.NextResult();
                    var amenities = new List<string>();
                    while (dr.Read())
                    {
                        try
                        {
                            string amen = dr["AmenityName"].ToString().Trim();
                            if (!string.IsNullOrWhiteSpace(amen))
                                amenities.Add(amen);
                        }
                        catch { }
                    }
                    payload["Amenities"] = amenities;

                    // ── 4. UNIT TYPES ────────────────────────────────────────────────
                    dr.NextResult();
                    var    unitTypes = new List<Dictionary<string, object>>();
                    double minArea   = double.MaxValue;
                    double maxArea   = 0;

                    var utCols = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
                    for (int i = 0; i < dr.FieldCount; i++) utCols.Add(dr.GetName(i));

                    while (dr.Read())
                    {
                        var row = new Dictionary<string, object>();
                        for (int i = 0; i < dr.FieldCount; i++)
                        {
                            object dbVal = dr.IsDBNull(i) ? null : dr.GetValue(i);

                            // FIX: Convert DateTime in sub-results too
                            if (dbVal is DateTime)
                                dbVal = ((DateTime)dbVal).ToString("yyyy-MM-dd");

                            // FIX: Sanitize string values — replace em-dash placeholders with null
                            if (dbVal is string)
                            {
                                string sv = ((string)dbVal).Trim();
                                if (sv == "\u2014" || sv == "\u2013" || sv == "-" || sv == "--")
                                    dbVal = null;
                                else
                                    dbVal = sv;  // store trimmed value
                            }

                            row[dr.GetName(i)] = dbVal;
                        }

                        // Derive area range from unit type rows
                        double area = 0;
                        if (utCols.Contains("CarpetAreaSqFt") && row["CarpetAreaSqFt"] != null)
                        {
                            double.TryParse(row["CarpetAreaSqFt"].ToString(), out area);
                        }
                        if (area == 0 && utCols.Contains("SuperAreaSqFt") && row["SuperAreaSqFt"] != null)
                        {
                            double.TryParse(row["SuperAreaSqFt"].ToString(), out area);
                        }
                        if (area > 0)
                        {
                            if (area < minArea) minArea = area;
                            if (area > maxArea) maxArea = area;
                        }

                        unitTypes.Add(row);
                    }
                    payload["UnitTypes"] = unitTypes;
                    if (minArea != double.MaxValue && minArea > 0) payload["MinArea"] = minArea;
                    if (maxArea > 0)                               payload["MaxArea"] = maxArea;

                    // ── 5. BLOCKS ────────────────────────────────────────────────────
                    dr.NextResult();
                    var blocks = new List<Dictionary<string, object>>();
                    while (dr.Read())
                    {
                        var row = new Dictionary<string, object>();
                        for (int i = 0; i < dr.FieldCount; i++)
                        {
                            object dbVal = dr.IsDBNull(i) ? null : dr.GetValue(i);
                            if (dbVal is DateTime)
                                dbVal = ((DateTime)dbVal).ToString("yyyy-MM-dd");
                            row[dr.GetName(i)] = dbVal;
                        }
                        blocks.Add(row);
                    }
                    payload["Blocks"] = blocks;

                    // ── 6. BANKS ─────────────────────────────────────────────────────
                    dr.NextResult();
                    var banks = new List<string>();
                    while (dr.Read())
                    {
                        try
                        {
                            string bank = dr["BankName"].ToString().Trim();
                            if (!string.IsNullOrWhiteSpace(bank))
                                banks.Add(bank);
                        }
                        catch { }
                    }
                    payload["Banks"] = banks;

                    // ── 7. DOCUMENTS ─────────────────────────────────────────────────
                    dr.NextResult();
                    var docs = new List<Dictionary<string, object>>();
                    while (dr.Read())
                    {
                        var row = new Dictionary<string, object>();
                        for (int i = 0; i < dr.FieldCount; i++)
                        {
                            object dbVal = dr.IsDBNull(i) ? null : dr.GetValue(i);
                            if (dbVal is DateTime)
                                dbVal = ((DateTime)dbVal).ToString("yyyy-MM-dd");
                            row[dr.GetName(i)] = dbVal;
                        }

                        // Resolve document virtual paths
                        if (row.ContainsKey("DocumentPath") && row["DocumentPath"] != null)
                        {
                            string docPath = row["DocumentPath"].ToString().Trim();
                            if (docPath.StartsWith("~/"))
                                row["DocumentPath"] = VirtualPathUtility.ToAbsolute(docPath);
                        }

                        docs.Add(row);
                    }
                    payload["Documents"] = docs;

                    // ── Serialize & inject ────────────────────────────────────────────
                    // FIX: Ensure Response encoding is UTF-8 before writing
                    Response.ContentEncoding = Encoding.UTF8;
                    Response.Charset         = "utf-8";

                    var js = new JavaScriptSerializer();
                    js.MaxJsonLength = int.MaxValue;
                    string json = js.Serialize(payload);

                    // FIX: Use \u003c/script> unicode escape to safely close the script tag
                    litInitScript.Text = "<script type=\"text/javascript\">initDetail("
                        + json
                        + ");\u003c/script>";

                    hdnProjectID.Value = projectId.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("ProjectDetail Error: " + ex.Message);
            Response.Redirect("ProjectList.aspx");
        }
    }
}
