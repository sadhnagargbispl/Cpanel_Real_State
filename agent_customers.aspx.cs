using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class agent_customers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.BtnCustomer.Attributes.Add("onclick", DisableTheButton(this.Page, this.BtnCustomer));
        if (!Page.IsPostBack)
        {
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
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
}