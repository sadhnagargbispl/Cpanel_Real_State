
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using BookingSystem.Models;

namespace BookingSystem.DAL
{
    public class BookingDAL
    {
        // Connection string from Web.config
        private string _conn = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        // ────────────────────────────────────────────────────
        // CUSTOMER METHODS
        // ────────────────────────────────────────────────────

        /// <summary>
        /// Search customers by ID or name (live search dropdown)
        /// </summary>
        public List<Customer> SearchCustomers(string keyword)
        {
            var list = new List<Customer>();
            string sql = @"
                SELECT TOP 10 idno as CustomerID, memfirstname as CustomerName, mobl as Phone, Email
                FROM   m_membermaster
                WHERE idno = @kw";

            using (var con = new SqlConnection(_conn))
            using (var cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@kw", keyword.Trim());
                con.Open();
                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        list.Add(new Customer
                        {
                            CustomerID = dr["CustomerID"].ToString(),
                            CustomerName = dr["CustomerName"].ToString(),
                            Phone = dr["Phone"].ToString(),
                            Email = dr["Email"].ToString()
                        });
                    }
                }
            }
            return list;
        }

        /// <summary>
        /// Get single customer by exact ID
        /// </summary>
        public Customer GetCustomerByID(string customerID)
        {
            string sql = @"
                SELECT CustomerID, CustomerName, Phone, Email, CNIC, Address, City
                FROM   Customers
                WHERE  CustomerID = @id AND IsActive = 1";

            using (var con = new SqlConnection(_conn))
            using (var cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@id", customerID.Trim());
                con.Open();
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        return new Customer
                        {
                            CustomerID = dr["CustomerID"].ToString(),
                            CustomerName = dr["CustomerName"].ToString(),
                            Phone = dr["Phone"].ToString(),
                            Email = dr["Email"].ToString(),
                            CNIC = dr["CNIC"].ToString(),
                            Address = dr["Address"].ToString(),
                            City = dr["City"].ToString()
                        };
                    }
                }
            }
            return null;
        }

        // ────────────────────────────────────────────────────
        // PROJECT METHODS
        // ────────────────────────────────────────────────────

        /// <summary>
        /// Get all active projects for dropdown
        /// </summary>
        public List<Project> GetAllProjects()
        {
            var list = new List<Project>();
            string sql = "SELECT ProjectID, ProjectName, GoogleMapsLink as Location FROM Projects WHERE IsDeleted = 0 AND PublishMode = 'active' ORDER BY ProjectName";

            using (var con = new SqlConnection(_conn))
            using (var cmd = new SqlCommand(sql, con))
            {
                con.Open();
                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        list.Add(new Project
                        {
                            ProjectID = Convert.ToInt32(dr["ProjectID"]),
                            ProjectName = dr["ProjectName"].ToString(),
                            Location = dr["Location"].ToString()
                        });
                    }
                }
            }
            return list;
        }

        // ────────────────────────────────────────────────────
        // PLOT METHODS
        // ────────────────────────────────────────────────────

        /// <summary>
        /// Get available plots by project ID
        /// </summary>
        public List<Plot> GetPlotsByProject(int projectID)
        {
            var list = new List<Plot>();
            string sql = @"
                SELECT UnitID as PlotID, UnitNumber as PlotNumber, b.SuperAreaSqFt as PlotSize, TotalBasePrice as Price, UnitStatus as Status
                FROM   Project_Units as a,ProjectUnitTypes as b
                WHERE a.ProjectID = b.ProjectID AND a.ProjectID = @pid AND UnitStatus = 'Available'
                ORDER BY UnitNumber";

            using (var con = new SqlConnection(_conn))
            using (var cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@pid", projectID);
                con.Open();
                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        list.Add(new Plot
                        {
                            PlotID = Convert.ToInt32(dr["PlotID"]),
                            PlotNumber = dr["PlotNumber"].ToString(),
                            PlotSize = dr["PlotSize"].ToString(),
                            Price = Convert.ToDecimal(dr["Price"]),
                            Status = dr["Status"].ToString()
                        });
                    }
                }
            }
            return list;
        }

        /// <summary>
        /// Get single plot by ID
        /// </summary>
        public Plot GetPlotByID(int plotID)
        {
            string sql = "SELECT PlotID, PlotNumber, PlotSize, Price, Status FROM Plots WHERE PlotID = @id";

            using (var con = new SqlConnection(_conn))
            using (var cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@id", plotID);
                con.Open();
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        return new Plot
                        {
                            PlotID = Convert.ToInt32(dr["PlotID"]),
                            PlotNumber = dr["PlotNumber"].ToString(),
                            PlotSize = dr["PlotSize"].ToString(),
                            Price = Convert.ToDecimal(dr["Price"]),
                            Status = dr["Status"].ToString()
                        };
                    }
                }
            }
            return null;
        }

        // ────────────────────────────────────────────────────
        // BOOKING METHODS
        // ────────────────────────────────────────────────────

        /// <summary>
        /// Generate next Booking ID  e.g. BK-1042
        /// </summary>
        private string GenerateBookingID(SqlConnection con, SqlTransaction trx)
        {
            string sql = "SELECT NEXT VALUE FOR BookingSeq";
            using (var cmd = new SqlCommand(sql, con, trx))
            {
                long seq = Convert.ToInt64(cmd.ExecuteScalar());
                return "BK-" + seq.ToString();
            }
        }

        /// <summary>
        /// Save new booking (with commission) — uses transaction
        /// </summary>
        public BookingResult SaveBooking(Booking booking, int agentID = 1)
        {
            var result = new BookingResult();

            using (var con = new SqlConnection(_conn))
            {
                con.Open();
                using (var trx = con.BeginTransaction())
                {
                    try
                    {
                        // 1. Generate Booking ID
                        string bookingID = GenerateBookingID(con, trx);
                        booking.BookingID = bookingID;

                        // 2. Insert Booking
                        string sqlBooking = @"
                            INSERT INTO Bookings
                                (BookingID, CustomerID, PlotID, AgentID,
                                 BookingDate, PossessionDate,
                                 TotalPrice, DownPayment, RemainingAmount,
                                 PaymentMode, TransactionRef, Notes, Status,FromID)
                            VALUES
                                (@BookingID, @CustomerID, @PlotID, @AgentID,
                                 @BookingDate, @PossessionDate,
                                 @TotalPrice, @DownPayment, @RemainingAmount,
                                 @PaymentMode, @TransactionRef, @Notes, 'Active',@FromID)";

                        using (var cmd = new SqlCommand(sqlBooking, con, trx))
                        {
                            cmd.Parameters.AddWithValue("@BookingID", bookingID);
                            cmd.Parameters.AddWithValue("@CustomerID", booking.CustomerID);
                            cmd.Parameters.AddWithValue("@PlotID", booking.PlotID);
                            cmd.Parameters.AddWithValue("@AgentID", agentID);
                            cmd.Parameters.AddWithValue("@BookingDate", booking.BookingDate);
                            cmd.Parameters.AddWithValue("@PossessionDate", (object)booking.PossessionDate ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@TotalPrice", booking.TotalPrice);
                            cmd.Parameters.AddWithValue("@DownPayment", booking.DownPayment);
                            cmd.Parameters.AddWithValue("@RemainingAmount", booking.RemainingAmount);
                            cmd.Parameters.AddWithValue("@PaymentMode", booking.PaymentMode);
                            cmd.Parameters.AddWithValue("@TransactionRef", (object)booking.TransactionRef ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@Notes", (object)booking.Notes ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@FromID", booking.FromID);
                            cmd.ExecuteNonQuery();
                        }
                        // 3. Update Plot status → Booked
                        string sqlPlot = "UPDATE Project_Units SET UnitStatus = 'Booked', UpdatedOn = GETDATE() WHERE UnitID = @pid";
                        using (var cmd = new SqlCommand(sqlPlot, con, trx))
                        {
                            cmd.Parameters.AddWithValue("@pid", booking.PlotID);
                            cmd.ExecuteNonQuery();
                        }

                        // 4. Insert Commission record
                        decimal commRate = 2.00m;
                        decimal commAmt = Math.Round(booking.TotalPrice * commRate / 100, 2);

                        string sqlComm = @"
                            INSERT INTO Commissions (BookingID, AgentID, CommissionRate, CommissionAmt, Status)
                            VALUES (@bid, @aid, @rate, @amt, 'Pending')";

                        using (var cmd = new SqlCommand(sqlComm, con, trx))
                        {
                            cmd.Parameters.AddWithValue("@bid", bookingID);
                            cmd.Parameters.AddWithValue("@aid", agentID);
                            cmd.Parameters.AddWithValue("@rate", commRate);
                            cmd.Parameters.AddWithValue("@amt", commAmt);
                            cmd.ExecuteNonQuery();
                        }

                        trx.Commit();

                        result.Success = true;
                        result.BookingID = bookingID;
                        result.Message = "Booking created successfully.";
                    }
                    catch (Exception ex)
                    {
                        trx.Rollback();
                        result.Success = false;
                        result.Message = "Error: " + ex.Message;
                    }
                }
            }
            return result;
        }

        /// <summary>
        /// Save booking as Draft
        /// </summary>
        public BookingResult SaveAsDraft(Booking booking, int agentID = 1)
        {
            booking.Status = "Draft";
            return SaveBooking(booking, agentID);
        }

        /// <summary>
        /// Get booking by ID (for receipt)
        /// </summary>
        public Booking GetBookingByID(string bookingID)
        {
            string sql = @"
                SELECT b.*, c.CustomerName, p.PlotNumber, p.PlotSize, pr.ProjectName
                FROM   Bookings b
                JOIN   Customers c  ON c.CustomerID = b.CustomerID
                JOIN   Plots     p  ON p.PlotID     = b.PlotID
                JOIN   Projects  pr ON pr.ProjectID = p.ProjectID
                WHERE  b.BookingID = @id";

            using (var con = new SqlConnection(_conn))
            using (var cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@id", bookingID);
                con.Open();
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        return new Booking
                        {
                            BookingID = dr["BookingID"].ToString(),
                            CustomerID = dr["CustomerID"].ToString(),
                            CustomerName = dr["CustomerName"].ToString(),
                            PlotID = Convert.ToInt32(dr["PlotID"]),
                            PlotNumber = dr["PlotNumber"].ToString(),
                            PlotSize = dr["PlotSize"].ToString(),
                            ProjectName = dr["ProjectName"].ToString(),
                            BookingDate = Convert.ToDateTime(dr["BookingDate"]),
                            PossessionDate = dr["PossessionDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dr["PossessionDate"]),
                            TotalPrice = Convert.ToDecimal(dr["TotalPrice"]),
                            DownPayment = Convert.ToDecimal(dr["DownPayment"]),
                            RemainingAmount = Convert.ToDecimal(dr["RemainingAmount"]),
                            PaymentMode = dr["PaymentMode"].ToString(),
                            TransactionRef = dr["TransactionRef"].ToString(),
                            Notes = dr["Notes"].ToString(),
                            Status = dr["Status"].ToString(),
                            CreatedAt = Convert.ToDateTime(dr["CreatedAt"])
                        };
                    }
                }
            }
            return null;
        }

        // ────────────────────────────────────────────────────
        // DOCUMENT SAVE
        // ────────────────────────────────────────────────────

        public void SaveDocument(string bookingID, string fileName, string filePath, string fileType, int fileSizeKB)
        {
            string sql = @"
                INSERT INTO BookingDocuments (BookingID, FileName, FilePath, FileType, FileSizeKB)
                VALUES (@bid, @fn, @fp, @ft, @fs)";

            using (var con = new SqlConnection(_conn))
            using (var cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@bid", bookingID);
                cmd.Parameters.AddWithValue("@fn", fileName);
                cmd.Parameters.AddWithValue("@fp", filePath);
                cmd.Parameters.AddWithValue("@ft", fileType);
                cmd.Parameters.AddWithValue("@fs", fileSizeKB);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}