using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MainMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["IDNO"] != null)
            {
                lnkLogin.Visible = false;
                pnlUser.Visible = true;

                litUserName.Text = Session["MemName"].ToString();
            }
            else
            {
                lnkLogin.Visible = true;
                pnlUser.Visible = false;
            }
        }
    }
}
