using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Configuration;
using System.Collections;
using System.Xml;
using System.Web.Configuration;

public partial class ShoppingRedirect : System.Web.UI.Page
{
    DataTable dt;
    DAL Obj;
    clsGeneral objGen = new clsGeneral();

    protected void Page_Load(object sender, EventArgs e)
    {

        string Token = "TzSfj9cF1NuI62FjXr2czywdtBCzoYCge7xGDBaKsIuc6gXqCWG2hnfdl4A1lGj0";
        string info1 = "UserName=" + Convert.ToString(Session["IDNo"].ToString()) + "&Password=" + Convert.ToString(Session["MemPassw"].ToString()) + "&Action=Login" + "&Token=" + Token;
        string ref11 = "Login";



        string red = Base64Encode(ref11);
        string ww = Base64Encode(info1);


        string url = "https://shopping.skyisyourlimit.com/Account/DirectLogin?URL=" + ww;


        Response.Redirect(url);
    }

    private string Base64Encode(string plainText)
    {
        byte[] plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
        return Convert.ToBase64String(plainTextBytes);
    }

    private string Base64Decode(string base64EncodedData)
    {
        byte[] base64EncodedBytes = Convert.FromBase64String(base64EncodedData);
        return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
    }
}


