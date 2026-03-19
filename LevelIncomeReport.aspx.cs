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
public partial class LevelIncomeReport : System.Web.UI.Page
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

            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                if (!Page.IsPostBack)
                {
                    FillDetail();
                }

            }
            else
            {
                Response.Redirect("logout.aspx");
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
            DataSet DS = new DataSet();
            //string query = ObjDal.Isostart + "select Sno,Investmentdate as [Investment date],Amount As [Investment Amount],Kitname as [Kit name],Status from V#InvestmentDetail where IdNo='" + Session["Idno"] + "'Order by InvestMentDate Desc " + ObjDal.IsoEnd;
            string query = "Exec sp_GetLevelIncome '" + Session["formno"] + "'";
            DS = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query);
            Session["ShopFund"] = DS.Tables[0];
            RptDirects.DataSource = DS.Tables[0];
            RptDirects.DataBind();
            lblTotalBonus.Text = DS.Tables[1].Rows[0]["TotalIncome"].ToString();
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
