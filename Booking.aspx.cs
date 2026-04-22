using System;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.Services;
using System.Collections.Generic;
using Newtonsoft.Json;
using BookingSystem.Models;
using BookingSystem.DAL;
using DocumentFormat.OpenXml.Drawing.Spreadsheet;
using System.Configuration;
using System.Data.SqlClient;

public partial class Booking : Page
{
    private BookingDAL _dal = new BookingDAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Status"] != null)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    hdnIdno.Value = Session["idno"].ToString();
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

    // ────────────────────────────────────────────────────────
    // [WebMethod] SearchCustomers  →  called from JS (AJAX)
    // ────────────────────────────────────────────────────────
    [WebMethod]
    public static string SearchCustomers(string keyword)
    {
        if (string.IsNullOrWhiteSpace(keyword) || keyword.Length < 2)
            return "[]";

        var dal = new BookingDAL();
        var list = dal.SearchCustomers(keyword);
        return JsonConvert.SerializeObject(list);
    }

    // ────────────────────────────────────────────────────────
    // [WebMethod] GetProjects  →  called from JS on page load
    // ────────────────────────────────────────────────────────
    [WebMethod]
    public static string GetProjects()
    {
        var dal = new BookingDAL();
        var list = dal.GetAllProjects();
        return JsonConvert.SerializeObject(list);
    }

    // ────────────────────────────────────────────────────────
    // [WebMethod] GetPlots  →  called from JS on project change
    // ────────────────────────────────────────────────────────
    [WebMethod]
    public static string GetPlots(int projectID)
    {
        var dal = new BookingDAL();
        var list = dal.GetPlotsByProject(projectID);
        return JsonConvert.SerializeObject(list);
    }

    // ────────────────────────────────────────────────────────
    // [WebMethod] SubmitBooking  →  called on form submit
    // ────────────────────────────────────────────────────────
    [WebMethod]
    public static string SubmitBooking(
        string customerID,
        int plotID,
        string bookingDate,
        string possessionDate,
        decimal totalPrice,
        decimal downPayment,
        string paymentMode,
        string transactionRef,
        string notes,
        string FromID,
        bool isDraft = false)
    {
        try
        {
            var booking = new BookingSystem.Models.Booking
            {
                CustomerID = customerID,
                FromID = FromID,
                PlotID = plotID,
                BookingDate = DateTime.Parse(bookingDate),
                PossessionDate = string.IsNullOrEmpty(possessionDate) ? (DateTime?)null : DateTime.Parse(possessionDate),
                TotalPrice = totalPrice,
                DownPayment = downPayment,
                RemainingAmount = totalPrice - downPayment,
                PaymentMode = paymentMode,
                TransactionRef = transactionRef,
                Notes = notes,
                Status = isDraft ? "Draft" : "Active"
            };

            var dal = new BookingDAL();
            var result = isDraft ? dal.SaveAsDraft(booking) : dal.SaveBooking(booking);

            return JsonConvert.SerializeObject(result);
        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new BookingResult
            {
                Success = false,
                Message = "Server error: " + ex.Message
            });
        }
    }

    // ────────────────────────────────────────────────────────
    // [WebMethod] SaveDraft
    // ────────────────────────────────────────────────────────
    //[WebMethod]
    //public static string SaveDraft(
    //    string customerID, int plotID, string bookingDate,
    //    decimal totalPrice, decimal downPayment, string paymentMode, string notes)
    //{
    //    return SubmitBooking(customerID, plotID, bookingDate, null, totalPrice, downPayment, paymentMode, null, notes, isDraft: true);
    //}

    // ────────────────────────────────────────────────────────
    // [WebMethod] UploadDocument
    // ────────────────────────────────────────────────────────
    [WebMethod]
    public static string UploadDocument(string bookingID, string base64Data, string fileName, string fileType)
    {
        try
        {
            // Save file to server
            string uploadDir = HttpContext.Current.Server.MapPath("~/Uploads/BookingDocs/" + bookingID + "/");
            if (!Directory.Exists(uploadDir)) Directory.CreateDirectory(uploadDir);

            string safeFileName = Path.GetFileNameWithoutExtension(fileName)
                                  + "_" + DateTime.Now.Ticks
                                  + Path.GetExtension(fileName);
            string filePath = Path.Combine(uploadDir, safeFileName);

            byte[] fileBytes = Convert.FromBase64String(base64Data);
            File.WriteAllBytes(filePath, fileBytes);

            int fileSizeKB = fileBytes.Length / 1024;
            string relativePath = "~/Uploads/BookingDocs/" + bookingID + "/" + safeFileName;

            var dal = new BookingDAL();
            dal.SaveDocument(bookingID, fileName, relativePath, fileType, fileSizeKB);

            return JsonConvert.SerializeObject(new { success = true, path = relativePath });
        }
        catch (Exception ex)
        {
            return JsonConvert.SerializeObject(new { success = false, message = ex.Message });
        }
    }

    // Change parameter from int to string
    [WebMethod]
    public static string GenerateReceipt(string bookingID, string agentID)
    {
        string conn = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        try
        {
            using (SqlConnection con = new SqlConnection(conn))
            {
                con.Open();

                string checkSql = "SELECT ReceiptID FROM Receipts WHERE BookingID = @BookingID";
                using (SqlCommand chk = new SqlCommand(checkSql, con))
                {
                    chk.Parameters.AddWithValue("@BookingID", bookingID);
                    object existing = chk.ExecuteScalar();
                    if (existing != null)
                        return "{\"Success\":true,\"ReceiptID\":" + existing + ",\"Message\":\"Already exists\"}";
                }

                string insertSql = @"
                INSERT INTO Receipts (BookingID, GeneratedBy, GeneratedDate, PrintCount)
                VALUES (@BookingID, @GeneratedBy, GETDATE(), 1);
                SELECT SCOPE_IDENTITY();";

                using (SqlCommand cmd = new SqlCommand(insertSql, con))
                {
                    cmd.Parameters.AddWithValue("@BookingID", bookingID);
                    cmd.Parameters.AddWithValue("@GeneratedBy", agentID ?? "");
                    int newID = Convert.ToInt32(cmd.ExecuteScalar());
                    return "{\"Success\":true,\"ReceiptID\":" + newID + ",\"Message\":\"Receipt generated\"}";
                }
            }
        }
        catch (Exception ex)
        {
            return "{\"Success\":false,\"Message\":\"" + ex.Message.Replace("\"", "'") + "\"}";
        }
    }
}
