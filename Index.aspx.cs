using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Index : System.Web.UI.Page
{
    private ProjectDAL _projectDAL = new ProjectDAL();
    private MasterDAL _masterDAL = new MasterDAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindAllDropdowns();
        }
        else
        {

        }
    }
    private void BindAllDropdowns()
    {
        ddlProjectType.DataSource = _masterDAL.GetProjectTypes();
        ddlProjectType.DataTextField = "TypeName";
        ddlProjectType.DataValueField = "ProjectTypeID";
        ddlProjectType.DataBind();
        ddlProjectType.Items.Insert(0, new ListItem("-- Select Property Type --", "0"));

        ddlCategory.DataSource = _masterDAL.GetUnitTypes();
        ddlCategory.DataTextField = "UnitTypeName";
        ddlCategory.DataValueField = "UnitTypeID";
        ddlCategory.DataBind();
        ddlCategory.Items.Insert(0, new ListItem("-- Select Size --", "0"));
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string city = txtCity.Value.Trim();
        string type = ddlProjectType.SelectedValue;
        string budget = ddlBudget.Value.Trim();
        string size = ddlCategory.SelectedValue;

        // Inner query string banao
        string innerQuery = string.Format(
            "location={0}&type={1}&budget={2}&size={3}",
            HttpUtility.UrlEncode(city),
            HttpUtility.UrlEncode(type),
            HttpUtility.UrlEncode(budget),
            HttpUtility.UrlEncode(size)
        );

        // Base64 encode karo
        string encoded = Convert.ToBase64String(
            System.Text.Encoding.UTF8.GetBytes(innerQuery)
        );

        Response.Redirect("property-search.aspx?q=" + encoded);
    }
}