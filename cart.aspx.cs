using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Status"] != null && Session["Status"].ToString() == "OK")
        {
            if (!IsPostBack)
            {
                ShowMessage();
                LoadCart();
            }
        }
        else
        {
            Response.Redirect("MainLogout.aspx");
        }
    }

    private void LoadCart()
    {
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            string query = @"
                SELECT
                    p.kitname   AS ProductName,
                    p.kitamount AS ProductPrice,
                    p.img       AS ProductImage,
                    c.Qty,
                    c.KitID
                FROM T_Cart c
                INNER JOIN m_kitmaster p ON p.KitID = c.KitID
                WHERE c.Status = 1 AND formno = '" + Session["formno"].ToString() + "'";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@SessionID", Session.SessionID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptCart.DataSource = dt;
            rptCart.DataBind();
            CalculateGrandTotal(dt);
        }
    }

    private void CalculateGrandTotal(DataTable dt)
    {
        decimal total = 0;
        foreach (DataRow row in dt.Rows)
            total += Convert.ToDecimal(row["Qty"]) * Convert.ToDecimal(row["ProductPrice"]);

        lblGrandTotal.Text = "Grand Total : ₹ " + total.ToString("N2");
    }

    protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int kitid = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "DeleteItem")
        {
            DeleteItem(kitid);
        }
        else if (e.CommandName == "UpdateQty")
        {
            TextBox txtQty = (TextBox)e.Item.FindControl("txtQty");
            int qty = Convert.ToInt32(txtQty.Text);
            if (qty > 0)
                UpdateQty(kitid, qty);
            else
                lblMsg.Text = "Quantity must be at least 1.";
        }

        LoadCart();
    }

    private void UpdateQty(int kitid, int qty)
    {
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            string query = @"
                UPDATE T_Cart SET Qty = @Qty
                WHERE formno = '" + Session["formno"].ToString() + "' AND KitID = @KitID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Qty", qty);
            cmd.Parameters.AddWithValue("@SessionID", Session.SessionID);
            cmd.Parameters.AddWithValue("@KitID", kitid);
            con.Open();
            cmd.ExecuteNonQuery();
        }
        lblMsg.Text = "✅ Quantity updated successfully.";
        Response.Redirect("cart.aspx");
    }

    private void DeleteItem(int kitid)
    {
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            string query = @"
                UPDATE T_Cart SET Status = 0
                WHERE formno = '" + Session["formno"].ToString() + "' AND KitID = @KitID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@SessionID", Session.SessionID);
            cmd.Parameters.AddWithValue("@KitID", kitid);
            con.Open();
            cmd.ExecuteNonQuery();
        }
        lblMsg.Text = "🗑️ Item removed successfully.";
        Response.Redirect("Cart.aspx");
    }

    private void ShowMessage()
    {
        if (Session["CartMsg"] != null)
        {
            lblMsg.Text = Session["CartMsg"].ToString();
            Session.Remove("CartMsg");
        }
    }
}