using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

public partial class MyDirects : System.Web.UI.Page
{
    DataSet ds;
    DAL obj = new DAL();

    string constr =
    ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

    string constr1 =
    ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;

    string isoStart;
    string isoEnd;

    private int PageSize = 10;
    public int RowOffset
    {
        get { return (PageIndex - 1) * PageSize; }
    }
    public int PageIndex
    {
        get
        {
            return ViewState["PageIndex"] != null
            ? Convert.ToInt32(ViewState["PageIndex"])
            : 1;
        }
        set
        {
            ViewState["PageIndex"] = value;
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            this.BtnAgent.Attributes.Add("onclick", DisableTheButton(this.Page, this.BtnAgent));
            if (Session["Status"] == null)
            {
                Response.Redirect("logout.aspx");
                return;
            }

            isoStart = obj.Isostart;
            isoEnd = obj.IsoEnd;

            if (!Page.IsPostBack)
            {
                FillLevel();

                PageIndex = 1;

                LevelDetail(PageIndex);

                FillData();
            }
        }
        catch (Exception ex)
        {
            LogError(ex);
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


    protected void FillLevel()
    {
        try
        {
            SqlParameter[] prms =
            new SqlParameter[2];

            prms[0] =
            new SqlParameter("@FormNo",
            Session["FormNo"]);

            prms[1] =
            new SqlParameter("@type",
            "N");

            ds =
            SqlHelper.ExecuteDataset(
            constr1,
            "sp_GetLevel",
            prms);

            DdlLevel.DataSource =
            ds.Tables[0];

            DdlLevel.DataTextField =
            "LevelName";

            DdlLevel.DataValueField =
            "MLevel";

            DdlLevel.DataBind();
        }
        catch (Exception ex)
        {
            LogError(ex);
        }
    }



    public void LevelDetail(int pageIndex)
    {
        try
        {
            string legno =
            rbtnsearch.SelectedValue == "L"
            ? "0"
            : rbtnsearch.SelectedValue;

            string level =
            rbtnsearch.SelectedValue == "L"
            ? DdlLevel.SelectedValue
            : "1";

            SqlParameter[] prms =
            new SqlParameter[7];

            prms[0] =
            new SqlParameter("@MLevel", level);

            prms[1] =
            new SqlParameter("@Legno", legno);

            prms[2] =
            new SqlParameter("@ActiveStatus",
            DDlSearchby.SelectedValue);

            prms[3] =
            new SqlParameter("@FormNo",
            Session["FormNo"]);

            prms[4] =
            new SqlParameter("@PageIndex",
            pageIndex);

            prms[5] =
            new SqlParameter("@PageSize",
            PageSize);

            prms[6] =
            new SqlParameter("@RecordCount",
            SqlDbType.Int);

            prms[6].Direction =
            ParameterDirection.Output;


            ds =
            SqlHelper.ExecuteDataset(
            constr1,
            "sp_GetLevelDetailCpanel_",
            prms);


            DataTable dt =
            ds.Tables[0];


            RptDirects.DataSource = dt;
            RptDirects.DataBind();


            // ✅ USE STORED PROCEDURE RECORD COUNT

            int recordCount =
            Convert.ToInt32(ds.Tables[1].Rows[0]["RecordCount"]);


            lblTotalRecords.Text =
            recordCount.ToString();


            int totalPages =
            (int)Math.Ceiling(
            (double)recordCount / PageSize);


            lblPageInfo.Text =
            "Page " + pageIndex +
            " of " + totalPages;


            hdnTotalPages.Value =
            totalPages.ToString();

            hdnCurrentPage.Value =
            pageIndex.ToString();


            btnPrev.Enabled =
            pageIndex > 1;

            btnNext.Enabled =
            pageIndex < totalPages;
        }
        catch (Exception ex)
        {
            LogError(ex);
        }
    }


    private void FillData()
    {
        try
        {
            string strSql =
            isoStart +
            " Select * from V#ReferalDownlineinfo where Formno="
            + Session["FormNo"] +
            isoEnd;


            DataTable dt =
            SqlHelper.ExecuteDataset(
            constr1,
            CommandType.Text,
            strSql).Tables[0];


            if (dt.Rows.Count > 0)
            {
                DataRow dr =
                dt.Rows[0];


                decimal regLeft =
                Convert.ToDecimal(
                dr["RegisterLeft"] ?? 0);

                decimal regRight =
                Convert.ToDecimal(
                dr["RegisterRight"] ?? 0);


                decimal activeLeft =
                Convert.ToDecimal(
                dr["ConfirmLeft"] ?? 0);

                decimal activeRight =
                Convert.ToDecimal(
                dr["ConfirmRight"] ?? 0);


                decimal leftBV =
                Convert.ToDecimal(
                dr["LeftBv"] ?? 0);

                decimal rightBV =
                Convert.ToDecimal(
                dr["RightBv"] ?? 0);



                tdDirectleft.InnerText =
                regLeft.ToString();

                tdDirectright.InnerText =
                regRight.ToString();

                TotalDirect.InnerText =
                (regLeft + regRight).ToString();



                tddirectActive.InnerText =
                activeLeft.ToString();

                tdindirectActive.InnerText =
                activeRight.ToString();

                TotalActive.InnerText =
                (activeLeft + activeRight).ToString();



                Directunit.InnerText =
                leftBV.ToString("0.##");

                indirectunit.InnerText =
                rightBV.ToString("0.##");

                totalunit.InnerText =
                (leftBV + rightBV).ToString("0.##");
            }
        }
        catch (Exception ex)
        {
            LogError(ex);
        }
    }



    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        PageIndex = 1;

        LevelDetail(PageIndex);
    }



    protected void lnkPrev_Click(object sender, EventArgs e)
    {
        if (PageIndex > 1)
        {
            PageIndex--;

            LevelDetail(PageIndex);
        }
    }



    protected void lnkNext_Click(object sender, EventArgs e)
    {
        int totalPages =
        Convert.ToInt32(
        hdnTotalPages.Value);

        if (PageIndex < totalPages)
        {
            PageIndex++;

            LevelDetail(PageIndex);
        }
    }



    private void LogError(Exception ex)
    {
        string path =
        HttpContext.Current.Request.Url.AbsoluteUri;

        string text =
        path + ": " +
        DateTime.Now.ToString(
        "dd-MMM-yyyy hh:mm:ss:fff") +
        Environment.NewLine;

        obj.WriteToFile(
        text + ex.Message);

        Response.Write(
        "Try later.");
    }
}