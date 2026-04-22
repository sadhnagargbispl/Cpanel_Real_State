using System;
using System.Collections.Generic;

namespace BookingSystem.Models
{
    // ── Customer ──────────────────────────────────────────
    public class Customer
    {
        public string CustomerID { get; set; }
        public string CustomerName { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string CNIC { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreatedAt { get; set; }
    }

    // ── Project ───────────────────────────────────────────
    public class Project
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
        public string Location { get; set; }
        public bool IsActive { get; set; }
    }

    // ── Plot ──────────────────────────────────────────────
    public class Plot
    {
        public int PlotID { get; set; }
        public int ProjectID { get; set; }
        public string PlotNumber { get; set; }
        public string PlotSize { get; set; }
        public decimal Price { get; set; }
        public string Status { get; set; }   // Available/Booked/Sold/Reserved
    }

    // ── Booking ───────────────────────────────────────────
    public class Booking
    {
        public string BookingID { get; set; }
        public string CustomerID { get; set; }
        public string CustomerName { get; set; }
        public int PlotID { get; set; }
        public string PlotNumber { get; set; }
        public string PlotSize { get; set; }
        public string ProjectName { get; set; }
        public int? AgentID { get; set; }
        public DateTime BookingDate { get; set; }
        public DateTime? PossessionDate { get; set; }
        public decimal TotalPrice { get; set; }
        public decimal DownPayment { get; set; }
        public decimal RemainingAmount { get; set; }
        public string PaymentMode { get; set; }
        public string TransactionRef { get; set; }
        public string Notes { get; set; }
        public string Status { get; set; }
        public DateTime CreatedAt { get; set; }
        public string FromID { get; set; }
        
    }

    // ── Booking Result ────────────────────────────────────
    public class BookingResult
    {
        public bool Success { get; set; }
        public string BookingID { get; set; }
        public string Message { get; set; }
    }

    // ── Commission ────────────────────────────────────────
    public class Commission
    {
        public int CommissionID { get; set; }
        public string BookingID { get; set; }
        public int AgentID { get; set; }
        public decimal CommissionRate { get; set; }
        public decimal CommissionAmt { get; set; }
        public string Status { get; set; }
    }
}