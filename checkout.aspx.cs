using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

public partial class checkout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Status"] != null && Session["Status"].ToString() == "OK")
        {
            if (!IsPostBack)
            {
                GetBalance();
                Fill_State();
                LoadCartSummary();
            }
        }
        else
        {
            Response.Redirect("MainLogout.aspx");
        }

    }
    protected void GetBalance()
    {
        try
        {
            DataTable dt = new DataTable();
            string str = " SELECT * FROM dbo.ufnGetBalance('" + Convert.ToInt32(Session["Formno"]) + "','S')";
            dt = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr1"].ConnectionString, CommandType.Text, str).Tables[0];

            if (dt.Rows.Count > 0)
            {
                AvailableBal.Text = Convert.ToDecimal(dt.Rows[0]["Balance"]).ToString();
            }
            else
            {
                AvailableBal.Text = "0";
            }

            Session["ServiceWallet"] = AvailableBal.Text;
        }
        catch (Exception ex)
        {
        }
    }
    private void Fill_State()
    {
        try
        {
            DataTable dtMaster = new DataTable();

            string str = "Select StateCode, StateName from M_StateDivMaster Where ActiveStatus = 'Y' And RowStatus = 'Y' Order by StateName";
            dtMaster = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr"].ConnectionString, CommandType.Text, str).Tables[0];
            if (dtMaster.Rows.Count > 0)
            {
                ddlPostSate.DataSource = dtMaster;
                ddlPostSate.DataValueField = "StateCode";
                ddlPostSate.DataTextField = "StateName";
                ddlPostSate.DataBind();
            }
        }
        catch (Exception ex)
        {
            // optional: log exception
            // Obj.WriteToFile(ex.Message);
        }
    }
    private void LoadCartSummary()
    {
        try
        {
            string idverified = "";
            string sql = "exec sp_MemDtl ' and mMst.Formno=''" + Session["formno"] + "''' ";
            DataTable dt = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr"].ConnectionString, CommandType.Text, sql).Tables[0];
            if (dt.Rows.Count > 0)
            {
                txtFirstName.Text = dt.Rows[0]["memfirstname"].ToString();
                txtEmail.Text = dt.Rows[0]["email"].ToString();
                txtPhone.Text = dt.Rows[0]["mobl"].ToString();
                TxtPostPincode.Text = dt.Rows[0]["PostalPin"].ToString();
                ddlPostSate.SelectedValue = dt.Rows[0]["PostalStateCode"].ToString();

                TxtPostDistrict.Text = dt.Rows[0]["Post"] == DBNull.Value ? "" : dt.Rows[0]["Post"].ToString();
                TxtPostCity.Text = dt.Rows[0]["Tehsil"] == DBNull.Value ? "" : dt.Rows[0]["Tehsil"].ToString();
                TxtPostalAddress.Text = dt.Rows[0]["DeliveryAddress"].ToString();
                ddlPostSate.Text = dt.Rows[0]["PostalStatecode"].ToString();
            }
        }
        catch (Exception ex)
        {
        }

        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            string query = @"
                SELECT
                    p.kitname   AS ProductName,
                    p.kitamount AS ProductPrice,
                    p.img       AS ProductImage,
                    c.Qty,
                    c.KitID,
                    (c.Qty * p.kitamount) AS LineTotal
                FROM T_Cart c
                INNER JOIN m_kitmaster p ON p.KitID = c.KitID
                WHERE formno = @formno AND c.Status = 1";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@SessionID", Session.SessionID);
            cmd.Parameters.AddWithValue("@formno", Session["formno"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            // Bind cart items
            rptCheckoutCart.DataSource = dt;
            rptCheckoutCart.DataBind();

            // Bind summary sidebar
            rptSummary.DataSource = dt;
            rptSummary.DataBind();

            // Calculate total
            decimal grandTotal = 0;
            foreach (DataRow row in dt.Rows)
                grandTotal += Convert.ToDecimal(row["LineTotal"]);

            lblTotal.Text = "₹ " + grandTotal.ToString("N2");
            ViewState["GrandTotal"] = grandTotal;
        }
    }
    protected void btnConfirmOrder_Click(object sender, EventArgs e)
    {
        // Validation
        if (string.IsNullOrWhiteSpace(txtFirstName.Text) ||
    string.IsNullOrWhiteSpace(TxtPostDistrict.Text) ||
    string.IsNullOrWhiteSpace(txtPhone.Text) ||
    string.IsNullOrWhiteSpace(TxtPostalAddress.Text) ||
    string.IsNullOrWhiteSpace(TxtPostCity.Text) ||
    ddlPostSate.SelectedValue == "0" ||
    string.IsNullOrWhiteSpace(TxtPostPincode.Text))
        {
            lblMsg.Text = "⚠️ Please fill all required fields.";
            return;
        }
        if (Convert.ToDecimal(Session["ServiceWallet"]) >= Convert.ToDecimal(ViewState["GrandTotal"]))
        {
            string orderId = PlaceOrder();

            if (!string.IsNullOrEmpty(orderId))
            {
                ClearCart();
                Response.Redirect("order-thankyou.aspx?orderid=" + orderId);
            }
            else
            {
                lblMsg.Text = "❌ Something went wrong. Please try again.";
            }
        }
        else
        {
            string scrName = "<SCRIPT language='javascript'>alert('Insufficient Balance!! ');</SCRIPT>";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Upgraded", scrName, false);
        }

    }
    private int GetValidKitID(string MemberID, string CartKitID)
    {
        DataTable dt;

        int NewKitTopupseq = 0;
        int CurrentTopupseq = 0;

        int NewKitID = 0;
        int CurrentKitID = 0;

        MemberID = MemberID.Trim()
                           .Replace(";", "")
                           .Replace("'", "")
                           .Replace("=", "");

        // Get Cart Kit Details
        string q =
            "SELECT KitId, TopUpSeq FROM M_KitMaster " +
            "WHERE KitId = '" + Convert.ToInt32(CartKitID) + "' " +
            "AND Allowtopup='Y' AND RowStatus='Y' AND activeStatus='Y'";

        dt = SqlHelper.ExecuteDataset(
            ConfigurationManager.ConnectionStrings["constr"].ConnectionString,
            CommandType.Text, q).Tables[0];

        if (dt.Rows.Count > 0)
        {
            NewKitTopupseq = Convert.ToInt32(dt.Rows[0]["TopUpSeq"]);
            NewKitID = Convert.ToInt32(dt.Rows[0]["KitId"]);
        }
        else
        {
            return 0;
        }


        // Get Current Member Kit Details
        string qr1 =
            "SELECT a.KitId, b.TopUpSeq " +
            "FROM M_MemberMaster a " +
            "INNER JOIN M_KitMaster b ON a.KitId=b.KitId " +
            "WHERE a.formno='" + MemberID + "'";

        dt = SqlHelper.ExecuteDataset(
            ConfigurationManager.ConnectionStrings["constr"].ConnectionString,
            CommandType.Text, qr1).Tables[0];

        if (dt.Rows.Count > 0)
        {
            CurrentTopupseq = Convert.ToInt32(dt.Rows[0]["TopUpSeq"]);
            CurrentKitID = Convert.ToInt32(dt.Rows[0]["KitId"]);

            // MAIN LOGIC
            if (NewKitTopupseq >= CurrentTopupseq)
            {
                return NewKitID;
            }
            else
            {
                return CurrentKitID;
            }
        }

        return 0;
    }
    //private bool IsValidID(string MemberID, string PinNo, ref string Msg)
    //{
    //    DataTable dt;
    //    bool BoolResult = false;
    //    int NewKitTopupseq;
    //    string NewKitMacAdrs = "";

    //    MemberID = MemberID.Trim()
    //                       .Replace(";", "")
    //                       .Replace("'", "")
    //                       .Replace("=", "");

    //    string q =
    //        "Select a.KitName,a.Allowtopup,a.MACAdrs,a.TopUpSeq,a.KitAmount,a.KitId,a.RP " +
    //        "FROM M_KitMaster as a WHERE cast(a.kitAmount as Numeric)='" + Convert.ToDecimal(PinNo) + "' " +
    //        "AND a.Allowtopup='Y' and a.RowStatus='Y' and a.activeStatus='Y' order by a.kitid desc";
    //    dt = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr"].ConnectionString, CommandType.Text, q).Tables[0];

    //    if (dt.Rows.Count > 0)
    //    {
    //        NewKitTopupseq = Convert.ToInt32(dt.Rows[0]["TopUpSeq"]);
    //    }
    //    else
    //    {
    //        Msg = "Package not found.";
    //        return false;
    //    }

    //    string qr1 =
    //       "Select a.Formno,a.MemFirstName + ' ' + a.MemLastName as MemName," +
    //        "isnull(c.Idno,' ') as SponsorId," +
    //        "Isnull((c.MemFirstName+' '+c.MemLastname),' ') as SponsorName," +
    //        "a.IsTopup,a.KitId,b.KitName,b.MACAdrs,b.TopUpSeq,a.LegNo,'' as Is_FranKit " +
    //        "from M_KitMaster as b,M_MemberMaster as a " +
    //        "Left Join M_MemberMaster as c on a.RefFormno=c.Formno " +
    //        "where a.KitId=b.KitId and b.RowStatus='Y' and a.formno='" + MemberID + "'";
    //    dt = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings["constr"].ConnectionString, CommandType.Text, qr1).Tables[0];
    //    if (dt.Rows.Count > 0)
    //    {
    //        BoolResult = true;
    //        if (NewKitTopupseq >= Convert.ToInt32(dt.Rows[0]["TopUpSeq"]))
    //        {
    //            Msg = "OK";
    //        }
    //        else
    //        {
    //            Msg = " Member Could Not Be Upgraded By This Package.";
    //        }
    //    }
    //    return Msg == "OK";
    //}
    private string PlaceOrder()
    {
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            con.Open();
            SqlTransaction txn = con.BeginTransaction();
            string Bill_No = GenerateRandomStringActive(6);
            try
            {
                // STEP 1: Insert Order
                string orderQuery = @"
                INSERT INTO T_Orders
                (SessionID, FirstName, LastName, Email, Phone,
                 Address, City, State, PinCode, TotalAmount,
                 OrderDate, Status, FormNo, District,OrderNo)
                 OUTPUT INSERTED.OrderID
                VALUES
                (@SessionID, @FirstName, @LastName, @Email, @Phone,
                 @Address, @City, @State, @PinCode, @TotalAmount,
                 GETDATE(), 'Pending', @FormNo, @District,@OrderID)";

                SqlCommand orderCmd = new SqlCommand(orderQuery, con, txn);

                orderCmd.Parameters.AddWithValue("@SessionID", Session.SessionID);
                orderCmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                orderCmd.Parameters.AddWithValue("@LastName", txtFirstName.Text.Trim());
                orderCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                orderCmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                orderCmd.Parameters.AddWithValue("@Address", TxtPostalAddress.Text.Trim());
                orderCmd.Parameters.AddWithValue("@City", TxtPostCity.Text.Trim());
                orderCmd.Parameters.AddWithValue("@State", ddlPostSate.SelectedItem.Text.Trim());
                orderCmd.Parameters.AddWithValue("@PinCode", TxtPostPincode.Text.Trim());
                orderCmd.Parameters.AddWithValue("@TotalAmount", ViewState["GrandTotal"]);
                orderCmd.Parameters.AddWithValue("@FormNo", Session["formno"]);
                orderCmd.Parameters.AddWithValue("@District", TxtPostDistrict.Text.Trim());
                orderCmd.Parameters.AddWithValue("@OrderID", Bill_No);
                int orderId = (int)orderCmd.ExecuteScalar();
                // STEP 2: Insert Order Items from Cart
                string itemQuery = @"
                INSERT INTO T_OrderItems
                (OrderID, KitID, Qty, Price, FormNo,OrderNo)
                SELECT
                    @OrderID,
                    c.KitID,
                    c.Qty,
                    p.kitamount,
                    @FormNo,@OrderNo
                FROM T_Cart c
                INNER JOIN m_kitmaster p
                    ON p.KitID = c.KitID
                WHERE
                    c.SessionID = @SessionID
                    AND c.Status = 1";

                SqlCommand itemCmd = new SqlCommand(itemQuery, con, txn);

                itemCmd.Parameters.AddWithValue("@OrderID", orderId);
                itemCmd.Parameters.AddWithValue("@SessionID", Session.SessionID);
                itemCmd.Parameters.AddWithValue("@FormNo", Session["formno"]);
                itemCmd.Parameters.AddWithValue("@OrderNo", Bill_No);
                itemCmd.ExecuteNonQuery();


                // STEP 3: Select inserted order items
                string selectQuery = @"
                SELECT KitID, Price, FormNo
                FROM T_OrderItems
                WHERE OrderID = @OrderID";

                SqlCommand selectCmd = new SqlCommand(selectQuery, con, txn);

                selectCmd.Parameters.AddWithValue("@OrderID", orderId);

                List<OrderItemModel> items = new List<OrderItemModel>();

                SqlDataReader reader = selectCmd.ExecuteReader();

                while (reader.Read())
                {
                    items.Add(new OrderItemModel
                    {
                        KitID = reader["KitID"].ToString(),
                        Price = reader["Price"].ToString(),
                        FormNo = reader["FormNo"].ToString()
                    });
                }

                reader.Close();

                // STEP 4: Call Activation Procedure for each item
                // STEP 4: Call Activation Procedure for each item
                foreach (var item in items)
                {
                    SqlCommand procCmd = new SqlCommand("Sp_IDActivationUpdate", con, txn);

                    procCmd.CommandType = CommandType.StoredProcedure;

                    procCmd.Parameters.AddWithValue("@IDNo", Session["idno"].ToString());
                    procCmd.Parameters.AddWithValue("@CAmount", Convert.ToDecimal(item.Price));
                    procCmd.Parameters.AddWithValue("@FromFormno", Convert.ToInt32(item.FormNo));
                    procCmd.Parameters.AddWithValue("@StackType", "");
                    procCmd.Parameters.AddWithValue("@BillNo", Bill_No);
                    // Direct cart kitid pass karo (SP khud decide karega upgrade/downgrade)
                    procCmd.Parameters.AddWithValue("@KitID", Convert.ToInt32(item.KitID));
                    // Address parameters
                    procCmd.Parameters.AddWithValue("@Post", TxtPostDistrict.Text.Trim());
                    procCmd.Parameters.AddWithValue("@Tehsil", TxtPostCity.Text.Trim());
                    procCmd.Parameters.AddWithValue("@PostalStateCode", ddlPostSate.SelectedValue);
                    procCmd.Parameters.AddWithValue("@PostalPin", TxtPostPincode.Text.Trim());
                    procCmd.Parameters.AddWithValue("@DeliveryAddress", TxtPostalAddress.Text.Trim());
                    procCmd.ExecuteNonQuery();
                }
                // STEP 5: Commit transaction
                txn.Commit();
                return Bill_No.ToString();
            }
            catch (Exception ex)
            {
                txn.Rollback();
                // Optional debugging
                // lblMsg.Text = ex.Message;
                return null;
            }
        }
    }
    
    public string GenerateRandomStringActive(int iLength)
    {
        Random rdm = new Random();
        char[] allowChrs = "123456789".ToCharArray();
        string sResult = "";

        for (int i = 0; i < iLength; i++)
        {
            sResult += allowChrs[rdm.Next(0, allowChrs.Length)];
        }

        return sResult;
    }
    private void ClearCart()
    {
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            string query = @"
                UPDATE T_Cart SET Status = 0
                WHERE SessionID = @SessionID AND formno = @formno ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@SessionID", Session.SessionID);
            cmd.Parameters.AddWithValue("@formno", Session["formno"]);
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }
}
public class OrderItemModel
{
    public string KitID { get; set; }
    public string Price { get; set; }
    public string FormNo { get; set; }
}