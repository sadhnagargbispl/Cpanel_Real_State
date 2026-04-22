using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class order_thankyou : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string orderId = Request.QueryString["orderid"];

            if (!string.IsNullOrEmpty(orderId))
            {
                LoadOrderDetails(orderId);
                LoadOrderItems(orderId);
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }
    }

    private void LoadOrderDetails(string orderId)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            string query = @" SELECT OrderNo, FirstName, LastName, Phone,Address, City, State, PinCode,TotalAmount, OrderDate, Status FROM T_Orders WHERE OrderNo = @OrderID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@OrderID", orderId);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                lblOrderID.Text = row["OrderNo"].ToString();
                lblName.Text = row["FirstName"] + " " + row["LastName"];
                lblPhone.Text = row["Phone"].ToString();
                lblDate.Text = Convert.ToDateTime(row["OrderDate"]).ToString("dd MMM yyyy, hh:mm tt");
                lblTotal.Text = "₹ " + Convert.ToDecimal(row["TotalAmount"]).ToString("N2");
                lblStatus.Text = row["Status"].ToString();
            }
        }
    }
    private void LoadOrderItems(string orderId)
    {
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            string query = @"
                SELECT
                    m.kitname AS ProductName,
                    oi.Price,
                    oi.Qty
                FROM T_OrderItems oi
                INNER JOIN m_kitmaster m ON m.KitID = oi.KitID
                WHERE oi.OrderID = @OrderID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@OrderID", orderId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptOrderItems.DataSource = dt;
            rptOrderItems.DataBind();
        }
    }
}