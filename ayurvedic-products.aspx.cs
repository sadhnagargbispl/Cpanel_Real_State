using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

public partial class ayurvedic_products : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(
        ConfigurationManager.ConnectionStrings["constr"].ConnectionString);
    SqlConnection conselect = new SqlConnection(
    ConfigurationManager.ConnectionStrings["constr1"].ConnectionString);
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
        SqlDataAdapter da = new SqlDataAdapter(
            ObjDal.Isostart + " Exec Sp_GetProductList " + ObjDal.IsoEnd, conselect);
        DataTable dt = new DataTable();
        da.Fill(dt);
        rptServices.DataSource = dt;
        rptServices.DataBind();
    }

    protected void btnBuyNow_Command(object sender,System.Web.UI.WebControls.CommandEventArgs e)
    {
        if (Session["Status"] != null && Session["Status"].ToString() == "OK")
        {
            string kitid = e.CommandArgument.ToString();
            AddToCartDB(kitid);
            Response.Redirect("Cart.aspx");
        }
        else
        {
            Response.Redirect("MainLogout.aspx");
        }
    }

    private void AddToCartDB(string kitid)
    {
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            string query = @"
                IF EXISTS (
                    SELECT 1 FROM T_Cart WHERE KitID = @KitID AND formno = @formno AND Status = 1
                )
                BEGIN
                    UPDATE T_Cart SET Qty = Qty + 1 WHERE KitID = @KitID AND formno = @formno AND Status = 1
                END
                ELSE
                BEGIN
                    INSERT INTO T_Cart (SessionID, KitID, Qty, Status,FormNo)
                    VALUES (@SessionID, @KitID, 1, 1,@formno)
                END";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@SessionID", Session.SessionID);
            cmd.Parameters.AddWithValue("@KitID", kitid);
            cmd.Parameters.AddWithValue("@formno", Session["formno"]);
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }
}