using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class agent_myagents : System.Web.UI.Page
{
    //DAL objDal = new DAL();
    //DataTable dt = new DataTable();
    //SqlConnection DbConnect;
    //string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    //string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    private double _dblAvailLeg = 0;
    private cls_DataAccess dbConnect;
    private DAL objDal = new DAL();
    private SqlCommand cmd = new SqlCommand();
    private SqlDataReader dRead;
    public string DsnName, UserName, Passw;
    private string strQuery, strCaptcha;
    private DataTable tmpTable = new DataTable();
    private int minSpnsrNoLen, minScrtchLen;
    private double Upln, dblSpons, dblState, dblBank, dblIdNo;
    private string dblDistrict, dblTehsil, IfSC;
    private string dblPlan;
    private DateTime CurrDt;
    private string scrname;
    private string LastInsertID = "";
    private string Email = "";
    private string InVoiceNo;
    private int SupplierId;
    private string BillNo;
    private string TaxType;
    private string BillDate;
    private int SBillNo;
    private string SoldBy = "WR";
    private string FType;
    private string Password = "";
    private string membername = "";
    private string clsGeneral = "";
    private clsGeneral dbGeneral = new clsGeneral();
    private string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    private string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    private SqlConnection cnn;
    DataTable Dt = new DataTable();
    string IsoStart;
    string IsoEnd;

    DAL ObjDal = new DAL();
    string query;


    protected void Page_Load(object sender, EventArgs e)
    {
       
        this.BtnAgent.Attributes.Add("onclick", DisableTheButton(this.Page, this.BtnAgent));
        if (!Page.IsPostBack)
        {
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {

                BindAgent();
                GetTotalAgent();
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
    protected void BtnAgent_Click(object sender, EventArgs e)
    {
        Response.Redirect("AgentRegistration.aspx", false);
    }
    private void GetTotalAgent()
    {
        DataSet ds = new DataSet();

        string str = ObjDal.Isostart + "Exec sp_TotalAgent '" + Session["Formno"] + "' " + ObjDal.IsoEnd;

        ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str);

        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblTotalAgent.Text = ds.Tables[0].Rows[0]["TotalAgent"].ToString();
            }


        }
    }
    private void BindAgent()
    {
        try
        {
            query = ObjDal.Isostart + "exec sp_getagent '" + Session["Formno"] + "'" + ObjDal.IsoEnd;

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