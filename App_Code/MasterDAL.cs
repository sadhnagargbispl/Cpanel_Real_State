using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

// App_Code folder - No namespace

public class MasterDAL
{
    // ── Project Types ──────────────────────────────
    public List<ProjectType> GetProjectTypes()
    {
        var list = new List<ProjectType>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT ProjectTypeID, TypeCode, TypeName FROM dbo.MstProjectTypes WHERE IsActive=1 ORDER BY TypeName", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new ProjectType
                    {
                        ProjectTypeID = Convert.ToInt32(dr["ProjectTypeID"]),
                        TypeCode      = dr["TypeCode"].ToString(),
                        TypeName      = dr["TypeName"].ToString()
                    });
        }
        return list;
    }

    // ── Project Categories ─────────────────────────
    public List<ProjectCategory> GetCategories()
    {
        var list = new List<ProjectCategory>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT CategoryID, CategoryName FROM dbo.MstProjectCategories WHERE IsActive=1", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new ProjectCategory
                    {
                        CategoryID   = Convert.ToInt32(dr["CategoryID"]),
                        CategoryName = dr["CategoryName"].ToString()
                    });
        }
        return list;
    }

    // ── Project Statuses ───────────────────────────
    public List<ProjectStatus> GetStatuses()
    {
        var list = new List<ProjectStatus>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT StatusID, StatusCode, StatusName FROM dbo.MstProjectStatuses ORDER BY SortOrder", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new ProjectStatus
                    {
                        StatusID   = Convert.ToInt32(dr["StatusID"]),
                        StatusCode = dr["StatusCode"].ToString(),
                        StatusName = dr["StatusName"].ToString()
                    });
        }
        return list;
    }

    // ── States ─────────────────────────────────────
    public List<StateModel> GetStates()
    {
        var list = new List<StateModel>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT StateID, StateName FROM dbo.MstStates ORDER BY StateName", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new StateModel
                    {
                        StateID   = Convert.ToInt32(dr["StateID"]),
                        StateName = dr["StateName"].ToString()
                    });
        }
        return list;
    }

    // ── Branches ───────────────────────────────────
    public List<BranchModel> GetBranches()
    {
        var list = new List<BranchModel>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT BranchID, BranchName, BranchCity FROM dbo.MstBranches WHERE IsActive=1 ORDER BY BranchName", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new BranchModel
                    {
                        BranchID   = Convert.ToInt32(dr["BranchID"]),
                        BranchName = dr["BranchName"].ToString(),
                        BranchCity = dr["BranchCity"].ToString()
                    });
        }
        return list;
    }

    // ── Amenities ──────────────────────────────────
    public List<AmenityModel> GetAmenities()
    {
        var list = new List<AmenityModel>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT AmenityID, AmenityName, AmenityIcon, CategoryGroup FROM dbo.MstAmenities WHERE IsActive=1 ORDER BY CategoryGroup, AmenityName", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new AmenityModel
                    {
                        AmenityID     = Convert.ToInt32(dr["AmenityID"]),
                        AmenityName   = dr["AmenityName"].ToString(),
                        AmenityIcon   = dr["AmenityIcon"].ToString(),
                        CategoryGroup = dr["CategoryGroup"].ToString()
                    });
        }
        return list;
    }

    // ── Banks ──────────────────────────────────────
    public List<BankModel> GetBanks()
    {
        var list = new List<BankModel>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT BankID, BankName FROM dbo.MstBanks WHERE IsActive=1 ORDER BY BankName", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new BankModel
                    {
                        BankID   = Convert.ToInt32(dr["BankID"]),
                        BankName = dr["BankName"].ToString()
                    });
        }
        return list;
    }

    // ── Payment Plan Types ─────────────────────────
    public List<PaymentPlanType> GetPaymentPlanTypes()
    {
        var list = new List<PaymentPlanType>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT PlanTypeID, PlanTypeName FROM dbo.MstPaymentPlanTypes ORDER BY PlanTypeName", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new PaymentPlanType
                    {
                        PlanTypeID   = Convert.ToInt32(dr["PlanTypeID"]),
                        PlanTypeName = dr["PlanTypeName"].ToString()
                    });
        }
        return list;
    }

    // ── Unit Types (BHK) ───────────────────────────
    public List<UnitTypeMaster> GetUnitTypes()
    {
        var list = new List<UnitTypeMaster>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT UnitTypeID, UnitTypeName FROM dbo.MstUnitTypes ORDER BY UnitTypeID", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new UnitTypeMaster
                    {
                        UnitTypeID   = Convert.ToInt32(dr["UnitTypeID"]),
                        UnitTypeName = dr["UnitTypeName"].ToString()
                    });
        }
        return list;
    }
}
