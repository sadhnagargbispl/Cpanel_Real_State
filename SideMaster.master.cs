using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SideMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["IDNO"] != null)
            {
                //lnkLogin.Visible = false;
               // pnlUser.Visible = true;
                litUserName.Text = Session["MemName"].ToString();
                //Literal1.Text = Session["MemName"].ToString();
                int cartCount = 0;
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM T_Cart WHERE status = 1 AND formno = '" + Session["formno"].ToString() + "' ", con);
                    con.Open();
                    cartCount = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();
                }
                // Example: show in label
                // lblTotal.Text = cartCount.ToString();
                cartCountID.InnerText = cartCount.ToString();
            }
            else
            {
               // lnkLogin.Visible = true;
                //pnlUser.Visible = false;
            }
        }

    }
}
