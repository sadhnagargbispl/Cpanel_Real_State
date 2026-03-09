using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class agent_customers : System.Web.UI.Page
{
    DataTable Dt = new DataTable();
    DAL ObjDal = new DAL();
    string query;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.BtnCustomer.Attributes.Add("onclick", DisableTheButton(this.Page, this.BtnCustomer));
        if (!Page.IsPostBack)
        {
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                BindCustomers();
                GetTotalCustomers();
            }
            else
            {
                Response.Redirect("agent_login.aspx", false);
            }
        }
    }
    private string DisableTheButton(System.Web.UI.Control pge, System.Web.UI.Control btn)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("if (typeof(Page_ClientValidate) == 'function') {");
        sb.Append("if (Page_ClientValidate() == false) { return false; }} ");
        sb.Append("if (confirm('Are you sure to proceed?') == false) { return false; } ");
        sb.Append("this.value = 'Please wait...';");
        sb.Append("this.disabled = true;");
        sb.Append(pge.Page.GetPostBackEventReference(btn));
        sb.Append(";");
        return sb.ToString();
    }
    protected void BtnCustomer_Click(object sender, EventArgs e)
    {
        Response.Redirect("CustomerRegistration.aspx", false);
    }
    private void GetTotalCustomers()
    {
        DataSet ds = new DataSet();

        string str = ObjDal.Isostart + "Exec sp_TotalCustomers '" + Session["Formno"] + "' " + ObjDal.IsoEnd;

        ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str);

        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblTotalCustomers.Text = ds.Tables[0].Rows[0]["TotalCustomers"].ToString();
            }

            
        }
    }

    private void BindCustomers()
    {
        try
        {
            query = ObjDal.Isostart + "exec sp_getcustomers '" + Session["Formno"] + "'" + ObjDal.IsoEnd;

            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query).Tables[0];

            if (Dt.Rows.Count > 0)
            {
                rptCustomers.DataSource = Dt;
                rptCustomers.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
}