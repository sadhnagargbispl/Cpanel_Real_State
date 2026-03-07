using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
     
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
        Response.Cache.SetAllowResponseInBrowserHistory(false);
        Response.Cache.SetNoStore();

        string nextpage = "agent_login.aspx";
        Session.Abandon();


        if (nextpage == null || nextpage == "agent_login.aspx")
        {
            nextpage = "Index.aspx?mod=logout";
        }

        Response.Redirect(nextpage, false);
       
    }
}
