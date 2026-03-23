using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

// App_Code folder - No namespace

public class ProjectDAL
{
    // ══════════════════════════════════════════════
    //  SAVE PROJECT — Insert ya Update (ProjectID=0 → Insert)
    // ══════════════════════════════════════════════
    public bool IsProjectCodeExists(string code)
    {
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT COUNT(1) FROM dbo.Projects WHERE ProjectCode=@Code AND IsDeleted=0", con))
        {
            cmd.Parameters.AddWithValue("@Code", code);
            con.Open();
            return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
        }
    }
    public int SaveProject(ProjectModel p, string changedBy)
    {
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand("dbo.usp_SaveProject_BasicInfo", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;

            var outID = new SqlParameter("@ProjectID", SqlDbType.Int);
            if (p.ProjectID == 0)
                outID.Direction = ParameterDirection.Output;
            else
            {
                outID.Direction = ParameterDirection.InputOutput;
                outID.Value     = p.ProjectID;
            }
            cmd.Parameters.Add(outID);

            cmd.Parameters.AddWithValue("@ProjectName",        (object)p.ProjectName        ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ProjectCode",        (object)p.ProjectCode        ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@DeveloperName",      (object)p.DeveloperName      ?? DBNull.Value);
            // FK columns — 0 pe DBNull bhejo (warna FK violation)
            cmd.Parameters.AddWithValue("@ProjectTypeID",      p.ProjectTypeID > 0 ? (object)p.ProjectTypeID : DBNull.Value);
            cmd.Parameters.AddWithValue("@CategoryID",         p.CategoryID.HasValue && p.CategoryID.Value > 0 ? (object)p.CategoryID.Value : DBNull.Value);
            cmd.Parameters.AddWithValue("@RERANumber",         (object)p.RERANumber         ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ShortDescription",   (object)p.ShortDescription   ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@KhasraPlotNo",       (object)p.KhasraPlotNo       ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@FullAddress",        (object)p.FullAddress        ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@Landmark",           (object)p.Landmark           ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@City",               (object)p.City               ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@District",           (object)p.District           ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@StateID",            p.StateID > 0 ? (object)p.StateID : DBNull.Value);
            cmd.Parameters.AddWithValue("@PinCode",            (object)p.PinCode            ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ZoneSector",         (object)p.ZoneSector         ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@Latitude",           (object)p.Latitude           ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@Longitude",          (object)p.Longitude          ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@GoogleMapsLink",     (object)p.GoogleMapsLink     ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@LaunchDate",         (object)p.LaunchDate         ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ConstructionStart",  (object)p.ConstructionStart  ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@PossessionDate",
                p.PossessionDate == DateTime.MinValue ? (object)DBNull.Value : p.PossessionDate);
            cmd.Parameters.AddWithValue("@BookingOpenDate",    (object)p.BookingOpenDate    ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@StatusID",           p.StatusID > 0 ? (object)p.StatusID : DBNull.Value);
            cmd.Parameters.AddWithValue("@ApprovalAuthority",  (object)p.ApprovalAuthority  ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@BranchID",           p.BranchID > 0 ? (object)p.BranchID : DBNull.Value);
            cmd.Parameters.AddWithValue("@ProjectManager",     (object)p.ProjectManager     ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@SalesHead",          (object)p.SalesHead          ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@SiteContactPhone",   (object)p.SiteContactPhone   ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@SiteOfficeAddress",  (object)p.SiteOfficeAddress  ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@SiteOfficeTimings",  (object)p.SiteOfficeTimings  ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ChangedBy",          changedBy ?? "system");

            con.Open();
            cmd.ExecuteNonQuery();
            return Convert.ToInt32(outID.Value);
        }
    }

    // ══════════════════════════════════════════════
    //  SAVE CONFIGURATION  (Step 2)
    // ══════════════════════════════════════════════
    public void SaveConfiguration(ProjectModel p, string changedBy)
    {
        const string sql = @"
            UPDATE dbo.Projects SET
                TotalLandAreaSqYd    = @TotalLandAreaSqYd,
                TotalBuiltUpSqFt     = @TotalBuiltUpSqFt,
                FARApproved          = @FARApproved,
                TotalFloors          = @TotalFloors,
                UnitsPerFloor        = @UnitsPerFloor,
                TotalUnits           = @TotalUnits,
                OpenGreenAreaPct     = @OpenGreenAreaPct,
                ParkingType          = @ParkingType,
                NumberOfBlocks       = @NumberOfBlocks,
                BSPRatePerSqFt       = @BSPRatePerSqFt,
                PLCAmount            = @PLCAmount,
                IFMSAmount           = @IFMSAmount,
                ClubMembershipAmt    = @ClubMembershipAmt,
                PowerBackupAmt       = @PowerBackupAmt,
                MaintenanceDeposit   = @MaintenanceDeposit,
                PaymentPlanTypeID    = @PaymentPlanTypeID,
                BookingAmount        = @BookingAmount,
                OnAgreementPct       = @OnAgreementPct,
                OnPossessionPct      = @OnPossessionPct,
                NumberOfInstallments = @NumberOfInstallments,
                GSTRatePct           = @GSTRatePct,
                CommissionL1Pct      = @CommissionL1Pct,
                CommissionL2Pct      = @CommissionL2Pct,
                CommissionL3Pct      = @CommissionL3Pct,
                BrokerageCommPct     = @BrokerageCommPct,
                CommissionPayout     = @CommissionPayout,
                TDSOnCommPct         = @TDSOnCommPct,
                UpdatedBy            = @ChangedBy,
                UpdatedAt            = GETDATE()
            WHERE ProjectID = @ProjectID AND IsDeleted = 0";

        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(sql, con))
        {
            cmd.Parameters.AddWithValue("@ProjectID",            p.ProjectID);
            cmd.Parameters.AddWithValue("@TotalLandAreaSqYd",    (object)p.TotalLandAreaSqYd    ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@TotalBuiltUpSqFt",     (object)p.TotalBuiltUpSqFt     ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@FARApproved",          (object)p.FARApproved          ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@TotalFloors",          (object)p.TotalFloors          ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@UnitsPerFloor",        (object)p.UnitsPerFloor        ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@TotalUnits",           p.TotalUnits > 0 ? (object)p.TotalUnits : DBNull.Value);
            cmd.Parameters.AddWithValue("@OpenGreenAreaPct",     (object)p.OpenGreenAreaPct     ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ParkingType",          (object)p.ParkingType          ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@NumberOfBlocks",       (object)p.NumberOfBlocks       ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@BSPRatePerSqFt",       (object)p.BSPRatePerSqFt       ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@PLCAmount",            (object)p.PLCAmount            ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@IFMSAmount",           (object)p.IFMSAmount           ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ClubMembershipAmt",    (object)p.ClubMembershipAmt    ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@PowerBackupAmt",       (object)p.PowerBackupAmt       ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@MaintenanceDeposit",   (object)p.MaintenanceDeposit   ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@PaymentPlanTypeID",    (object)p.PaymentPlanTypeID    ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@BookingAmount",        (object)p.BookingAmount        ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@OnAgreementPct",       (object)p.OnAgreementPct       ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@OnPossessionPct",      (object)p.OnPossessionPct      ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@NumberOfInstallments", (object)p.NumberOfInstallments ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@GSTRatePct",           (object)p.GSTRatePct           ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@CommissionL1Pct",      (object)p.CommissionL1Pct      ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@CommissionL2Pct",      (object)p.CommissionL2Pct      ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@CommissionL3Pct",      (object)p.CommissionL3Pct      ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@BrokerageCommPct",     (object)p.BrokerageCommPct     ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@CommissionPayout",     (object)p.CommissionPayout     ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@TDSOnCommPct",         (object)p.TDSOnCommPct         ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ChangedBy",            changedBy ?? "system");
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    // ══════════════════════════════════════════════
    //  SAVE SPECIFICATIONS + TOGGLES  (Step 3)
    // ══════════════════════════════════════════════
    public void SaveSpecifications(ProjectModel p, string changedBy)
    {
        const string sql = @"
            UPDATE dbo.Projects SET
                FlooringType      = @FlooringType,
                KitchenType       = @KitchenType,
                BathroomFixtures  = @BathroomFixtures,
                WindowType        = @WindowType,
                SpecialFeatures   = @SpecialFeatures,
                IsOnlineBooking   = @IsOnlineBooking,
                IsShowOnWebsite   = @IsShowOnWebsite,
                IsEMICalculator   = @IsEMICalculator,
                IsAgentReferral   = @IsAgentReferral,
                IsHoldUnitAllowed = @IsHoldUnitAllowed,
                IsVastuCompliant  = @IsVastuCompliant,
                UpdatedBy         = @ChangedBy,
                UpdatedAt         = GETDATE()
            WHERE ProjectID = @ProjectID AND IsDeleted = 0";

        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(sql, con))
        {
            cmd.Parameters.AddWithValue("@ProjectID",         p.ProjectID);
            cmd.Parameters.AddWithValue("@FlooringType",      (object)p.FlooringType     ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@KitchenType",       (object)p.KitchenType      ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@BathroomFixtures",  (object)p.BathroomFixtures ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@WindowType",        (object)p.WindowType       ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@SpecialFeatures",   (object)p.SpecialFeatures  ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@IsOnlineBooking",   p.IsOnlineBooking);
            cmd.Parameters.AddWithValue("@IsShowOnWebsite",   p.IsShowOnWebsite);
            cmd.Parameters.AddWithValue("@IsEMICalculator",   p.IsEMICalculator);
            cmd.Parameters.AddWithValue("@IsAgentReferral",   p.IsAgentReferral);
            cmd.Parameters.AddWithValue("@IsHoldUnitAllowed", p.IsHoldUnitAllowed);
            cmd.Parameters.AddWithValue("@IsVastuCompliant",  p.IsVastuCompliant);
            cmd.Parameters.AddWithValue("@ChangedBy",         changedBy ?? "system");
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    // ══════════════════════════════════════════════
    //  SAVE MEDIA  (Step 4)
    // ══════════════════════════════════════════════
    public void SaveMedia(ProjectModel p, string changedBy)
    {
        const string sql = @"
            UPDATE dbo.Projects SET
                CoverImagePath      = @CoverImagePath,
                ProjectLogoBadge    = @ProjectLogoBadge,
                WalkthroughVideoURL = @WalkthroughVideoURL,
                VirtualTourURL      = @VirtualTourURL,
                UpdatedBy           = @ChangedBy,
                UpdatedAt           = GETDATE()
            WHERE ProjectID = @ProjectID AND IsDeleted = 0";

        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(sql, con))
        {
            cmd.Parameters.AddWithValue("@ProjectID",           p.ProjectID);
            cmd.Parameters.AddWithValue("@CoverImagePath",      (object)p.CoverImagePath      ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ProjectLogoBadge",    (object)p.ProjectLogoBadge    ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@WalkthroughVideoURL", (object)p.WalkthroughVideoURL ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@VirtualTourURL",      (object)p.VirtualTourURL      ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ChangedBy",           changedBy ?? "system");
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    // ══════════════════════════════════════════════
    //  PUBLISH PROJECT  (Step 5)
    // ══════════════════════════════════════════════
    public void PublishProject(int projectID, string publishMode, DateTime? scheduledAt, string changedBy)
    {
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand("dbo.usp_PublishProject", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProjectID",   projectID);
            cmd.Parameters.AddWithValue("@PublishMode", publishMode);
            cmd.Parameters.AddWithValue("@LaunchAt",    (object)scheduledAt ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ChangedBy",   changedBy ?? "system");
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    // ══════════════════════════════════════════════
    //  SAVE BLOCKS
    // ══════════════════════════════════════════════
    public void SaveBlocks(int projectID, List<ProjectBlockModel> blocks, string changedBy)
    {
        using (var con = DBHelper.GetConnection())
        {
            con.Open();
            using (var tran = con.BeginTransaction())
            {
                try
                {
                    using (var del = new SqlCommand(
                        "DELETE FROM dbo.ProjectBlocks WHERE ProjectID=@PID", con, tran))
                    {
                        del.Parameters.AddWithValue("@PID", projectID);
                        del.ExecuteNonQuery();
                    }

                    int sort = 0;
                    foreach (var b in blocks)
                    {
                        using (var ins = new SqlCommand(@"
                            INSERT INTO dbo.ProjectBlocks
                                (ProjectID, BlockName, NumberOfFloors, UnitsPerFloor, BlockCategory, SortOrder)
                            VALUES (@PID, @Name, @Floors, @UPF, @Cat, @Sort)", con, tran))
                        {
                            ins.Parameters.AddWithValue("@PID",   projectID);
                            ins.Parameters.AddWithValue("@Name",  b.BlockName);
                            ins.Parameters.AddWithValue("@Floors",(object)b.NumberOfFloors ?? DBNull.Value);
                            ins.Parameters.AddWithValue("@UPF",   (object)b.UnitsPerFloor  ?? DBNull.Value);
                            ins.Parameters.AddWithValue("@Cat",   (object)b.BlockCategory  ?? DBNull.Value);
                            ins.Parameters.AddWithValue("@Sort",  sort++);
                            ins.ExecuteNonQuery();
                        }
                    }
                    tran.Commit();
                }
                catch
                {
                    tran.Rollback();
                    throw;
                }
            }
        }
    }

    // ══════════════════════════════════════════════
    //  SAVE UNIT TYPES
    // ══════════════════════════════════════════════
    public void SaveUnitTypes(int projectID, List<ProjectUnitTypeModel> units, string changedBy)
    {
        using (var con = DBHelper.GetConnection())
        {
            con.Open();
            using (var tran = con.BeginTransaction())
            {
                try
                {
                    using (var del = new SqlCommand(
                        "DELETE FROM dbo.ProjectUnitTypes WHERE ProjectID=@PID", con, tran))
                    {
                        del.Parameters.AddWithValue("@PID", projectID);
                        del.ExecuteNonQuery();
                    }

                    foreach (var u in units)
                    {
                        using (var ins = new SqlCommand(@"
                            INSERT INTO dbo.ProjectUnitTypes
                                (ProjectID, UnitTypeID, SuperAreaSqFt, CarpetAreaSqFt, NumberOfUnits, BSPPerSqFt, PLCAmount)
                            VALUES (@PID, @UID, @Super, @Carpet, @Count, @BSP, @PLC)", con, tran))
                        {
                            ins.Parameters.AddWithValue("@PID",    projectID);
                            ins.Parameters.AddWithValue("@UID",    u.UnitTypeID);
                            ins.Parameters.AddWithValue("@Super",  u.SuperAreaSqFt);
                            ins.Parameters.AddWithValue("@Carpet", (object)u.CarpetAreaSqFt ?? DBNull.Value);
                            ins.Parameters.AddWithValue("@Count",  u.NumberOfUnits);
                            ins.Parameters.AddWithValue("@BSP",    (object)u.BSPPerSqFt    ?? DBNull.Value);
                            ins.Parameters.AddWithValue("@PLC",    (object)u.PLCAmount      ?? DBNull.Value);
                            ins.ExecuteNonQuery();
                        }
                    }
                    tran.Commit();
                }
                catch
                {
                    tran.Rollback();
                    throw;
                }
            }
        }
    }

    // ══════════════════════════════════════════════
    //  SAVE AMENITIES
    // ══════════════════════════════════════════════
    public void SaveAmenities(int projectID, List<int> amenityIDs, string changedBy)
    {
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand("dbo.usp_SaveProjectAmenities", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProjectID",  projectID);
            cmd.Parameters.AddWithValue("@AmenityIDs", string.Join(",", amenityIDs));
            cmd.Parameters.AddWithValue("@ChangedBy",  changedBy ?? "system");
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    // ══════════════════════════════════════════════
    //  SAVE BANK LINKS
    // ══════════════════════════════════════════════
    public void SaveBankLinks(int projectID, List<int> bankIDs, string changedBy)
    {
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand("dbo.usp_SaveProjectBankLinks", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProjectID", projectID);
            cmd.Parameters.AddWithValue("@BankIDs",   string.Join(",", bankIDs));
            cmd.Parameters.AddWithValue("@ChangedBy", changedBy ?? "system");
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    // ══════════════════════════════════════════════
    //  SAVE DOCUMENT
    // ══════════════════════════════════════════════
    public void SaveDocument(ProjectDocumentModel doc)
    {
        const string sql = @"
            UPDATE dbo.ProjectDocuments SET IsActive=0
            WHERE ProjectID=@PID AND DocTypeID=@DT;

            INSERT INTO dbo.ProjectDocuments
                (ProjectID, DocTypeID, FileName, FilePath, FileSize, MimeType, UploadedBy)
            VALUES (@PID, @DT, @FN, @FP, @FS, @MT, @UB)";

        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(sql, con))
        {
            cmd.Parameters.AddWithValue("@PID", doc.ProjectID);
            cmd.Parameters.AddWithValue("@DT",  doc.DocTypeID);
            cmd.Parameters.AddWithValue("@FN",  doc.FileName);
            cmd.Parameters.AddWithValue("@FP",  doc.FilePath);
            cmd.Parameters.AddWithValue("@FS",  (object)doc.FileSize ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@MT",  (object)doc.MimeType ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@UB",  (object)doc.UploadedBy ?? DBNull.Value);
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    // ══════════════════════════════════════════════
    //  GET DOCUMENTS
    // ══════════════════════════════════════════════
    public List<ProjectDocumentModel> GetDocuments(int projectID)
    {
        var list = new List<ProjectDocumentModel>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT DocTypeID, FileName, FilePath FROM dbo.ProjectDocuments WHERE ProjectID=@PID AND IsActive=1", con))
        {
            cmd.Parameters.AddWithValue("@PID", projectID);
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new ProjectDocumentModel
                    {
                        ProjectID  = projectID,
                        DocTypeID  = Convert.ToInt32(dr["DocTypeID"]),
                        FileName   = dr["FileName"].ToString(),
                        FilePath   = dr["FilePath"].ToString()
                    });
        }
        return list;
    }

    // ══════════════════════════════════════════════
    //  CLEAR GALLERY IMAGES (before re-save)
    // ══════════════════════════════════════════════
    public void ClearGalleryImages(int projectID)
    {
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "DELETE FROM dbo.ProjectGallery WHERE ProjectID=@PID", con))
        {
            cmd.Parameters.AddWithValue("@PID", projectID);
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    // ══════════════════════════════════════════════
    //  GET GALLERY IMAGES
    // ══════════════════════════════════════════════
    public List<ProjectGalleryImage> GetGalleryImages(int projectID)
    {
        var list = new List<ProjectGalleryImage>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT * FROM dbo.ProjectGallery WHERE ProjectID=@PID ORDER BY SortOrder", con))
        {
            cmd.Parameters.AddWithValue("@PID", projectID);
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new ProjectGalleryImage
                    {
                        ProjectID  = projectID,
                        ImagePath  = dr["ImagePath"].ToString(),
                        IsCover    = dr["IsCover"] != DBNull.Value && Convert.ToBoolean(dr["IsCover"]),
                        SortOrder  = dr["SortOrder"] != DBNull.Value ? Convert.ToInt32(dr["SortOrder"]) : 0,
                        Caption    = dr["Caption"] == DBNull.Value ? "" : dr["Caption"].ToString()
                    });
        }
        return list;
    }

    // ══════════════════════════════════════════════
    //  SAVE GALLERY IMAGE
    // ══════════════════════════════════════════════
    public void SaveGalleryImage(ProjectGalleryImage img)
    {
        const string sql = @"
            IF @IsCover = 1
                UPDATE dbo.ProjectGallery SET IsCover=0 WHERE ProjectID=@PID;
            INSERT INTO dbo.ProjectGallery
                (ProjectID, ImagePath, Caption, IsCover, SortOrder, UploadedBy)
            VALUES (@PID, @IP, @Cap, @IsCover, @Sort, @UB)";

        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(sql, con))
        {
            cmd.Parameters.AddWithValue("@PID",     img.ProjectID);
            cmd.Parameters.AddWithValue("@IP",      img.ImagePath);
            cmd.Parameters.AddWithValue("@Cap",     (object)img.Caption ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@IsCover", img.IsCover);
            cmd.Parameters.AddWithValue("@Sort",    img.SortOrder);
            cmd.Parameters.AddWithValue("@UB",      (object)img.UploadedBy ?? DBNull.Value);
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    // ══════════════════════════════════════════════
    //  GET PROJECT BY ID
    // ══════════════════════════════════════════════
    public ProjectModel GetProjectByID(int projectID)
    {
        ProjectModel project = null;

        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT * FROM dbo.Projects WHERE ProjectID=@ID AND IsDeleted=0", con))
        {
            cmd.Parameters.AddWithValue("@ID", projectID);
            con.Open();
            using (var dr = cmd.ExecuteReader())
                if (dr.Read()) project = MapProject(dr);
        }

        if (project != null)
        {
            project.Blocks     = GetBlocks(projectID);
            project.UnitTypes  = GetUnitTypes(projectID);
            project.AmenityIDs = GetAmenityIDs(projectID);
            project.BankIDs    = GetBankIDs(projectID);
        }
        return project;
    }

    public List<ProjectSummary> GetAllProjects()
    {
        var list = new List<ProjectSummary>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT * FROM dbo.vw_ProjectSummary ORDER BY CreatedAt DESC", con))
        {
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new ProjectSummary
                    {
                        ProjectID = Convert.ToInt32(dr["ProjectID"]),
                        ProjectCode = dr["ProjectCode"].ToString(),
                        ProjectName = dr["ProjectName"].ToString(),
                        ProjectType = dr["ProjectType"].ToString(),
                        ProjectCategory = dr["ProjectCategory"].ToString(),
                        RERANumber = dr["RERANumber"].ToString(),
                        City = dr["City"].ToString(),
                        StateName = dr["StateName"].ToString(),
                        LaunchDate = dr["LaunchDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dr["LaunchDate"]),
                        PossessionDate = dr["PossessionDate"] == DBNull.Value ? DateTime.MinValue : Convert.ToDateTime(dr["PossessionDate"]),
                        ProjectStatus = dr["ProjectStatus"].ToString(),
                        PublishMode = dr["PublishMode"].ToString(),
                        TotalUnits = Convert.ToInt32(dr["TotalUnits"]),
                        BSPRatePerSqFt = dr["BSPRatePerSqFt"] == DBNull.Value ? (decimal?)null : Convert.ToDecimal(dr["BSPRatePerSqFt"]),
                        BranchName = dr["BranchName"].ToString(),
                        ProjectManager = dr["ProjectManager"].ToString(),
                        BlockCount = Convert.ToInt32(dr["BlockCount"]),
                        AmenityCount = Convert.ToInt32(dr["AmenityCount"]),
                        DocumentCount = Convert.ToInt32(dr["DocumentCount"]),
                        CreatedAt = Convert.ToDateTime(dr["CreatedAt"]),

                        // ▼ NEW: Cover image aur Logo
                        CoverImagePath = dr["CoverImagePath"] == DBNull.Value ? "" : dr["CoverImagePath"].ToString(),
                        ProjectLogoBadge = dr["ProjectLogoBadge"] == DBNull.Value ? "" : dr["ProjectLogoBadge"].ToString()
                    });
        }
        return list;
    }
    // ══════════════════════════════════════════════
    //  GET ALL PROJECTS (list page)
    // ══════════════════════════════════════════════
    //public List<ProjectSummary> GetAllProjects()
    //{
    //    var list = new List<ProjectSummary>();
    //    using (var con = DBHelper.GetConnection())
    //    using (var cmd = new SqlCommand(
    //        "SELECT * FROM dbo.vw_ProjectSummary ORDER BY CreatedAt DESC", con))
    //    {
    //        con.Open();
    //        using (var dr = cmd.ExecuteReader())
    //            while (dr.Read())
    //                list.Add(new ProjectSummary
    //                {
    //                    ProjectID      = Convert.ToInt32(dr["ProjectID"]),
    //                    ProjectCode    = dr["ProjectCode"].ToString(),
    //                    ProjectName    = dr["ProjectName"].ToString(),
    //                    ProjectType    = dr["ProjectType"].ToString(),
    //                    RERANumber     = dr["RERANumber"].ToString(),
    //                    City           = dr["City"].ToString(),
    //                    StateName      = dr["StateName"].ToString(),
    //                    LaunchDate     = dr["LaunchDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dr["LaunchDate"]),
    //                    PossessionDate = Convert.ToDateTime(dr["PossessionDate"]),
    //                    ProjectStatus  = dr["ProjectStatus"].ToString(),
    //                    PublishMode    = dr["PublishMode"].ToString(),
    //                    TotalUnits     = Convert.ToInt32(dr["TotalUnits"]),
    //                    BranchName     = dr["BranchName"].ToString(),
    //                    ProjectManager = dr["ProjectManager"].ToString(),
    //                    AmenityCount   = Convert.ToInt32(dr["AmenityCount"]),
    //                    DocumentCount  = Convert.ToInt32(dr["DocumentCount"]),
    //                    CreatedAt      = Convert.ToDateTime(dr["CreatedAt"])
    //                });
    //    }
    //    return list;
    //}

    // ══════════════════════════════════════════════
    //  SOFT DELETE
    // ══════════════════════════════════════════════
    public void DeleteProject(int projectID, string deletedBy)
    {
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand("dbo.usp_DeleteProject", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProjectID", projectID);
            cmd.Parameters.AddWithValue("@DeletedBy", deletedBy ?? "system");
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    // ══════════════════════════════════════════════
    //  PRIVATE HELPERS
    // ══════════════════════════════════════════════
    private ProjectModel MapProject(SqlDataReader dr)
    {
        // Helper functions
        Func<string, string>   S   = col => dr[col] == DBNull.Value ? "" : dr[col].ToString();
        Func<string, int>      I   = col => dr[col] == DBNull.Value ? 0  : Convert.ToInt32(dr[col]);
        Func<string, int?>     IN  = col => dr[col] == DBNull.Value ? (int?)null     : Convert.ToInt32(dr[col]);
        Func<string, decimal?> DN  = col => dr[col] == DBNull.Value ? (decimal?)null : Convert.ToDecimal(dr[col]);
        Func<string, DateTime?> DT = col => dr[col] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dr[col]);
        Func<string, bool>     B   = col => dr[col] != DBNull.Value && Convert.ToBoolean(dr[col]);

        var p = new ProjectModel();

        // Identity
        p.ProjectID        = I("ProjectID");
        p.ProjectName      = S("ProjectName");
        p.ProjectCode      = S("ProjectCode");
        p.DeveloperName    = S("DeveloperName");
        p.ProjectTypeID    = I("ProjectTypeID");
        p.CategoryID       = IN("CategoryID");
        p.RERANumber       = S("RERANumber");
        p.ShortDescription = S("ShortDescription");

        // Location
        p.KhasraPlotNo     = S("KhasraPlotNo");
        p.FullAddress      = S("FullAddress");
        p.Landmark         = S("Landmark");
        p.City             = S("City");
        p.District         = S("District");
        p.StateID          = I("StateID");
        p.PinCode          = S("PinCode");
        p.ZoneSector       = S("ZoneSector");
        p.Latitude         = DN("Latitude");
        p.Longitude        = DN("Longitude");
        p.GoogleMapsLink   = S("GoogleMapsLink");

        // Timeline
        p.LaunchDate        = DT("LaunchDate");
        p.ConstructionStart = DT("ConstructionStart");
        p.PossessionDate    = dr["PossessionDate"] == DBNull.Value
                                ? DateTime.MinValue
                                : Convert.ToDateTime(dr["PossessionDate"]);
        p.BookingOpenDate   = DT("BookingOpenDate");
        p.StatusID          = I("StatusID");
        p.ApprovalAuthority = S("ApprovalAuthority");

        // Branch & Team
        p.BranchID          = I("BranchID");
        p.ProjectManager    = S("ProjectManager");
        p.SalesHead         = S("SalesHead");
        p.SiteContactPhone  = S("SiteContactPhone");
        p.SiteOfficeAddress = S("SiteOfficeAddress");
        p.SiteOfficeTimings = S("SiteOfficeTimings");

        // Land & Area
        p.TotalLandAreaSqYd  = DN("TotalLandAreaSqYd");
        p.TotalBuiltUpSqFt   = DN("TotalBuiltUpSqFt");
        p.FARApproved        = DN("FARApproved");
        p.TotalFloors        = IN("TotalFloors");
        p.UnitsPerFloor      = IN("UnitsPerFloor");
        p.TotalUnits         = I("TotalUnits");
        p.OpenGreenAreaPct   = DN("OpenGreenAreaPct");
        p.ParkingType        = S("ParkingType");
        p.NumberOfBlocks     = IN("NumberOfBlocks");

        // Pricing
        p.BSPRatePerSqFt     = DN("BSPRatePerSqFt");
        p.PLCAmount          = DN("PLCAmount");
        p.IFMSAmount         = DN("IFMSAmount");
        p.ClubMembershipAmt  = DN("ClubMembershipAmt");
        p.PowerBackupAmt     = DN("PowerBackupAmt");
        p.MaintenanceDeposit = DN("MaintenanceDeposit");

        // Payment Plan
        p.PaymentPlanTypeID    = IN("PaymentPlanTypeID");
        p.BookingAmount        = DN("BookingAmount");
        p.OnAgreementPct       = DN("OnAgreementPct");
        p.OnPossessionPct      = DN("OnPossessionPct");
        p.NumberOfInstallments = IN("NumberOfInstallments");
        p.GSTRatePct           = DN("GSTRatePct");

        // Commission
        p.CommissionL1Pct  = DN("CommissionL1Pct");
        p.CommissionL2Pct  = DN("CommissionL2Pct");
        p.CommissionL3Pct  = DN("CommissionL3Pct");
        p.BrokerageCommPct = DN("BrokerageCommPct");
        p.CommissionPayout = S("CommissionPayout");
        p.TDSOnCommPct     = DN("TDSOnCommPct");

        // Specifications
        p.FlooringType     = S("FlooringType");
        p.KitchenType      = S("KitchenType");
        p.BathroomFixtures = S("BathroomFixtures");
        p.WindowType       = S("WindowType");
        p.SpecialFeatures  = S("SpecialFeatures");

        // Media
        p.CoverImagePath      = S("CoverImagePath");
        p.ProjectLogoBadge    = S("ProjectLogoBadge");
        p.WalkthroughVideoURL = S("WalkthroughVideoURL");
        p.VirtualTourURL      = S("VirtualTourURL");

        // Feature Toggles
        p.IsOnlineBooking   = B("IsOnlineBooking");
        p.IsShowOnWebsite   = B("IsShowOnWebsite");
        p.IsEMICalculator   = B("IsEMICalculator");
        p.IsAgentReferral   = B("IsAgentReferral");
        p.IsHoldUnitAllowed = B("IsHoldUnitAllowed");
        p.IsVastuCompliant  = B("IsVastuCompliant");

        // Publish & Audit
        p.PublishMode = S("PublishMode");
        p.CreatedBy   = S("CreatedBy");
        p.CreatedAt   = dr["CreatedAt"] == DBNull.Value ? DateTime.Now : Convert.ToDateTime(dr["CreatedAt"]);
        p.UpdatedAt   = DT("UpdatedAt");

        return p;
    }

    private List<ProjectBlockModel> GetBlocks(int projectID)
    {
        var list = new List<ProjectBlockModel>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT * FROM dbo.ProjectBlocks WHERE ProjectID=@PID AND IsActive=1 ORDER BY SortOrder", con))
        {
            cmd.Parameters.AddWithValue("@PID", projectID);
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new ProjectBlockModel
                    {
                        BlockID        = Convert.ToInt32(dr["BlockID"]),
                        ProjectID      = projectID,
                        BlockName      = dr["BlockName"].ToString(),
                        NumberOfFloors = dr["NumberOfFloors"] == DBNull.Value ? (int?)null : Convert.ToInt32(dr["NumberOfFloors"]),
                        UnitsPerFloor  = dr["UnitsPerFloor"]  == DBNull.Value ? (int?)null : Convert.ToInt32(dr["UnitsPerFloor"]),
                        BlockCategory  = dr["BlockCategory"].ToString(),
                        SortOrder      = Convert.ToInt32(dr["SortOrder"])
                    });
        }
        return list;
    }

    private List<ProjectUnitTypeModel> GetUnitTypes(int projectID)
    {
        var list = new List<ProjectUnitTypeModel>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(@"
            SELECT pu.*, ut.UnitTypeName
            FROM dbo.ProjectUnitTypes pu
            JOIN dbo.MstUnitTypes ut ON ut.UnitTypeID = pu.UnitTypeID
            WHERE pu.ProjectID=@PID AND pu.IsActive=1", con))
        {
            cmd.Parameters.AddWithValue("@PID", projectID);
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(new ProjectUnitTypeModel
                    {
                        UnitTypeRowID  = Convert.ToInt32(dr["UnitTypeRowID"]),
                        ProjectID      = projectID,
                        UnitTypeID     = Convert.ToInt32(dr["UnitTypeID"]),
                        UnitTypeName   = dr["UnitTypeName"].ToString(),
                        SuperAreaSqFt  = Convert.ToDecimal(dr["SuperAreaSqFt"]),
                        CarpetAreaSqFt = dr["CarpetAreaSqFt"] == DBNull.Value ? (decimal?)null : Convert.ToDecimal(dr["CarpetAreaSqFt"]),
                        NumberOfUnits  = Convert.ToInt32(dr["NumberOfUnits"]),
                        BSPPerSqFt     = dr["BSPPerSqFt"] == DBNull.Value ? (decimal?)null : Convert.ToDecimal(dr["BSPPerSqFt"]),
                        PLCAmount      = dr["PLCAmount"]  == DBNull.Value ? (decimal?)null : Convert.ToDecimal(dr["PLCAmount"])
                    });
        }
        return list;
    }

    private List<int> GetAmenityIDs(int projectID)
    {
        var list = new List<int>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT AmenityID FROM dbo.ProjectAmenities WHERE ProjectID=@PID", con))
        {
            cmd.Parameters.AddWithValue("@PID", projectID);
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(Convert.ToInt32(dr["AmenityID"]));
        }
        return list;
    }

    private List<int> GetBankIDs(int projectID)
    {
        var list = new List<int>();
        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT BankID FROM dbo.ProjectBankLinks WHERE ProjectID=@PID", con))
        {
            cmd.Parameters.AddWithValue("@PID", projectID);
            con.Open();
            using (var dr = cmd.ExecuteReader())
                while (dr.Read())
                    list.Add(Convert.ToInt32(dr["BankID"]));
        }
        return list;
    }
}
