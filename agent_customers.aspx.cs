using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class agent_customers : System.Web.UI.Page
{
    private string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    DataTable Dt = new DataTable();
    DAL ObjDal = new DAL();
    string query;

    private int PageSize = 10;

    public int RowOffset
    {
        get { return (CurrentPage - 1) * PageSize; }
    }

    private int CurrentPage
    {
        get { return ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 1; }
        set { ViewState["CurrentPage"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        this.BtnCustomer.Attributes.Add("onclick", DisableTheButton(this.Page, this.BtnCustomer));

        if (!Page.IsPostBack)
        {
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
                BindCustomers();
            else
                Response.Redirect("agent_login.aspx", false);
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

    protected void BtnPrev_Click(object sender, EventArgs e)
    {
        if (CurrentPage > 1) { CurrentPage--; BindCustomers(); }
    }

    protected void BtnNext_Click(object sender, EventArgs e)
    {
        int totalPages = int.Parse(hdnTotalPages.Value);
        if (CurrentPage < totalPages) { CurrentPage++; BindCustomers(); }
    }

    private void BindCustomers()
    {
        try
        {
            query = ObjDal.Isostart + "exec sp_getcustomers '" + Session["Formno"] + "'" + ObjDal.IsoEnd;
            Dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query).Tables[0];

            int totalRecords = Dt.Rows.Count;
            int totalPages   = (int)Math.Ceiling((double)totalRecords / PageSize);
            if (totalPages == 0) totalPages = 1;

            DataTable paged = Dt.Clone();
            int start = (CurrentPage - 1) * PageSize;
            int end   = Math.Min(start + PageSize, totalRecords);
            for (int i = start; i < end; i++)
                paged.ImportRow(Dt.Rows[i]);

            rptCustomers.DataSource = paged;
            rptCustomers.DataBind();

            lblTotalCustomers.Text = totalRecords.ToString();
            lblHeaderSub.Text      = totalRecords + " customers registered under your account";
            lblRecordSummary.Text  = "Total Records: " + totalRecords;
            lblPageInfo.Text       = "Page " + CurrentPage + " of " + totalPages;

            btnPrev.Enabled      = CurrentPage > 1;
            btnNext.Enabled      = CurrentPage < totalPages;
            hdnTotalPages.Value  = totalPages.ToString();
            hdnCurrentPage.Value = CurrentPage.ToString();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
}
