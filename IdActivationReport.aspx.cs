using DocumentFormat.OpenXml.Drawing.Charts;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net;
using System.Collections;
using DataTable = System.Data.DataTable;
using System.Web.UI.HtmlControls;
public partial class IdActivationReport : System.Web.UI.Page
{
    string scrName;
    DAL ObjDAL = new DAL();
    string IsoStart;
    string IsoEnd;
    string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    private DataTable Dt = new DataTable();
    private DAL ObjDal = new DAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (Session["Status"] == null)
            {
                Response.Redirect("logout.aspx");
            }
            else
            {
                if (!Page.IsPostBack)
                {
                    FillDetail();
                }

            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff ") + Environment.NewLine;
            ObjDAL.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }

    private void FillDetail()
    {
        try
        {
            Dt = new DataTable();
            //string query = ObjDal.Isostart + "select Sno,Investmentdate as [Investment date],Amount As [Investment Amount],Kitname as [Kit name],Status from V#InvestmentDetail where IdNo='" + Session["Idno"] + "'Order by InvestMentDate Desc " + ObjDal.IsoEnd;
            string query = "Exec Sp_GetIDInvestmentDetail '" + Session["formno"] + "'";
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query).Tables[0];
            Session["ShopFund"] = Dt;
            if (Dt.Rows.Count > 0)
            {
                RptDirects.DataSource = Dt;
                RptDirects.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }


    protected void RptDirects_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        try
        {
            RptDirects.PageIndex = e.NewPageIndex;
            FillDetail();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
}
