using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class agent_receipts : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Status"] != null)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    BindReceipts();
                }
            }
            catch (Exception ex)
            {

            }
        }
        else
        {
            Response.Redirect("logout.aspx");
        }
    }

    private void BindReceipts()
    {
        string agentID = Session["idno"].ToString() ?? "";
        string conn = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        string sql = @"
            SELECT
                r.ReceiptID,
                'RCP-' + RIGHT('000' + CAST(r.ReceiptID AS VARCHAR), 3) AS ReceiptNo,
                a.BookingID,
                a.CustomerID,
                b.memfirstname AS Customername,
                c.ProjectName + ' — ' + d.unitnumber AS ProjecPlot,
                a.TotalPrice AS Total,
                a.DownPayment AS Paid,
                a.RemainingAmount AS Remaining,
                REPLACE(CONVERT(VARCHAR, a.BookingDate, 106), ' ', '-') AS BookingDate,
                a.PaymentMode,
                a.Status,
                r.GeneratedDate
            FROM theskyprct..Receipts AS r
            JOIN theskyprct..Bookings AS a ON a.BookingID = r.BookingID
            JOIN theskyprct..m_membermaster AS b ON b.idno = a.CustomerID
            JOIN theskyprct..Project_Units AS d ON d.unitid = a.plotid
            JOIN theskyprct..projects AS c ON c.ProjectID = d.ProjectID
            WHERE a.fromid = @agentID
            ORDER BY r.GeneratedDate DESC";

        using (SqlConnection con = new SqlConnection(conn))
        using (SqlCommand cmd = new SqlCommand(sql, con))
        {
            cmd.Parameters.AddWithValue("@agentID", agentID);
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rptReceipts.DataSource = dt;
            rptReceipts.DataBind();
        }
    }
}