using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Main : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(
        ConfigurationManager.ConnectionStrings["constr1"].ConnectionString
    );
    DAL ObjDal = new DAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindServices();
        }
    }
    private void BindServices()
    {
        SqlDataAdapter da = new SqlDataAdapter(ObjDal.Isostart + "SELECT * FROM " + ObjDal.dBName + "..PortalServices WHERE ActiveStatus='Y' ORDER BY DisplayOrder" + ObjDal.IsoEnd, con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        rptServices.DataSource = dt;
        rptServices.DataBind();
    }
}