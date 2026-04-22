using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RealEstate : System.Web.UI.Page
{
    private DAL ObjDal = new DAL();
    private DataTable dt;
    private string query;
    private string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] == null || Session["Status"].ToString() != "OK")
            {
                Response.Redirect("logout.aspx");
                return;
            }

            if (!Page.IsPostBack)
            {
                Session["DtRealEstate"] = null;
                BindCityDropdown();
                FillDetail();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                "alert('" + ex.Message.Replace("'", "\\'") + "')", true);
        }
    }

    // ── Dropdown: Cities ─────────────────────────────────────────────────
    private void BindCityDropdown()
    {
        try
        {
            string sql = ObjDal.Isostart
                + "SELECT DISTINCT City FROM " + ObjDal.dBName + "..M_PropertyMaster ORDER BY City"
                + ObjDal.IsoEnd;

            DataSet ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql);
            DdlCity.Items.Clear();
            DdlCity.Items.Add(new System.Web.UI.WebControls.ListItem("-- All Cities --", ""));
            foreach (DataRow dr in ds.Tables[0].Rows)
                DdlCity.Items.Add(new System.Web.UI.WebControls.ListItem(dr["City"].ToString(), dr["City"].ToString()));
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    // ── Main Data Loader ─────────────────────────────────────────────────
    private void FillDetail()
    {
        try
        {
            DataSet ds;

            if (Session["DtRealEstate"] == null)
            {
                string city  = DdlCity.SelectedValue;
                string ptype = DdlType.SelectedValue;

                query  = ObjDal.Isostart;
                query += "SELECT P.PropID, CAST(P.PropID AS varchar) AS VPropID,";
                query += " M.MemFirstName + ' ' + M.MemLastName AS OwnerName,";
                query += " P.PropType, P.City, P.AreaSqft,";
                query += " FORMAT(P.Price, 'N2') AS Price,";
                query += " ISNULL(REPLACE(CONVERT(varchar, P.ListDate, 106), ' ', '-'), '') AS ListDate,";
                query += " P.Status";
                query += " FROM " + ObjDal.dBName + "..M_PropertyMaster AS P";
                query += " INNER JOIN " + ObjDal.dBName + "..M_MemberMaster AS M ON P.IDNo = M.IDNo";
                query += " WHERE 1=1";

                if (!string.IsNullOrEmpty(city))
                    query += " AND P.City = '" + city + "'";

                if (!string.IsNullOrEmpty(ptype))
                    query += " AND P.PropType = '" + ptype + "'";

                query += " ORDER BY P.ListDate DESC" + ObjDal.IsoEnd;

                ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query);
                Session["DtRealEstate"] = ds;
            }
            else
            {
                ds = (DataSet)Session["DtRealEstate"];
            }

            dt = ds.Tables[0];
            Session["RealEstateData"] = dt;

            // KPI Summary
            FillKPI(dt);

            // Bind GridView
            RptDirects.DataSource = dt;
            RptDirects.DataBind();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    // ── KPI Cards ─────────────────────────────────────────────────────────
    private void FillKPI(DataTable dtData)
    {
        try
        {
            int totalListed = dtData.Rows.Count;
            int sold        = 0;
            int available   = 0;
            decimal totalVal = 0;

            foreach (DataRow dr in dtData.Rows)
            {
                string status = dr["Status"].ToString().Trim().ToLower();
                if (status == "sold")      sold++;
                if (status == "available") available++;

                decimal price;
                string rawPrice = dr["Price"].ToString().Replace(",", "");
                if (decimal.TryParse(rawPrice, out price))
                    totalVal += price;
            }

            SpnTotalListed.InnerText = totalListed.ToString();
            SpnTotalValue.InnerText  = (totalVal / 10000000).ToString("N2"); // convert to Crore
            SpnSold.InnerText        = sold.ToString();
            SpnAvailable.InnerText   = available.ToString();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    // ── Status CSS Class Helper (called from ASPX) ────────────────────────
    public string GetStatusClass(string status)
    {
        switch (status.Trim().ToLower())
        {
            case "sold":      return "badge-status badge-sold";
            case "available": return "badge-status badge-available";
            case "rented":    return "badge-status badge-rented";
            default:          return "badge-status badge-pending";
        }
    }

    // ── Search Button ─────────────────────────────────────────────────────
    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            Session["DtRealEstate"] = null;
            FillDetail();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                "alert('" + ex.Message.Replace("'", "\\'") + "')", true);
        }
    }

    // ── Export to Excel ───────────────────────────────────────────────────
    protected void BtnExport_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["RealEstateData"] == null) return;

            DataTable dtExport = (DataTable)Session["RealEstateData"];

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=RealEstateReport.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            System.IO.StringWriter sw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);

            GridView gvExport = new GridView();
            gvExport.DataSource = dtExport;
            gvExport.DataBind();
            gvExport.RenderControl(htw);

            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                "alert('" + ex.Message.Replace("'", "\\'") + "')", true);
        }
    }

    // ── GridView Paging ───────────────────────────────────────────────────
    protected void RptDirects_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            FillDetail();
            RptDirects.PageIndex = e.NewPageIndex;
            RptDirects.DataBind();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                "alert('" + ex.Message.Replace("'", "\\'") + "')", true);
        }
    }

    protected void Page_LoadComplete(object sender, EventArgs e) { }
    protected void Page_Unload(object sender, EventArgs e) { }
}
