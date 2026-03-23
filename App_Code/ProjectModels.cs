using System;
using System.Collections.Generic;

// ─────────────────────────────────────────────
//  Web Site Project - App_Code folder
//  Namespace NAHI hoga - directly class likhenge
// ─────────────────────────────────────────────

// ── MASTER / LOOKUP MODELS ──────────────────

public class ProjectType
{
    public int    ProjectTypeID { get; set; }
    public string TypeCode      { get; set; }
    public string TypeName      { get; set; }
    public bool   IsActive      { get; set; }
}

public class ProjectCategory
{
    public int    CategoryID   { get; set; }
    public string CategoryName { get; set; }
    public bool   IsActive     { get; set; }
}

public class ProjectStatus
{
    public int    StatusID   { get; set; }
    public string StatusCode { get; set; }
    public string StatusName { get; set; }
    public int    SortOrder  { get; set; }
}

public class StateModel
{
    public int    StateID   { get; set; }
    public string StateName { get; set; }
}

public class BranchModel
{
    public int    BranchID     { get; set; }
    public string BranchName   { get; set; }
    public string BranchCity   { get; set; }
    public string ContactPhone { get; set; }
    public bool   IsActive     { get; set; }
}

public class AmenityModel
{
    public int    AmenityID     { get; set; }
    public string AmenityName   { get; set; }
    public string AmenityIcon   { get; set; }
    public string CategoryGroup { get; set; }
    public bool   IsActive      { get; set; }
}

public class BankModel
{
    public int    BankID   { get; set; }
    public string BankName { get; set; }
    public bool   IsActive { get; set; }
}

public class PaymentPlanType
{
    public int    PlanTypeID   { get; set; }
    public string PlanTypeName { get; set; }
}

public class UnitTypeMaster
{
    public int    UnitTypeID   { get; set; }
    public string UnitTypeName { get; set; }
}

public class DocumentType
{
    public int    DocTypeID   { get; set; }
    public string DocTypeName { get; set; }
    public string DocCategory { get; set; }
    public bool   IsRequired  { get; set; }
}

// ── MAIN PROJECT MODEL ──────────────────────

public class ProjectModel
{
    // Identity
    public int    ProjectID        { get; set; }
    public string ProjectName      { get; set; }
    public string ProjectCode      { get; set; }
    public string DeveloperName    { get; set; }
    public int    ProjectTypeID    { get; set; }
    public int?   CategoryID       { get; set; }
    public string RERANumber       { get; set; }
    public string ShortDescription { get; set; }

    // Location
    public string   KhasraPlotNo   { get; set; }
    public string   FullAddress    { get; set; }
    public string   Landmark       { get; set; }
    public string   City           { get; set; }
    public string   District       { get; set; }
    public int      StateID        { get; set; }
    public string   PinCode        { get; set; }
    public string   ZoneSector     { get; set; }
    public decimal? Latitude       { get; set; }
    public decimal? Longitude      { get; set; }
    public string   GoogleMapsLink { get; set; }

    // Timeline
    public DateTime?  LaunchDate          { get; set; }
    public DateTime?  ConstructionStart   { get; set; }
    public DateTime   PossessionDate      { get; set; }
    public DateTime?  BookingOpenDate     { get; set; }
    public int        StatusID            { get; set; }
    public string     ApprovalAuthority   { get; set; }

    // Branch & Team
    public int    BranchID           { get; set; }
    public string ProjectManager     { get; set; }
    public string SalesHead          { get; set; }
    public string SiteContactPhone   { get; set; }
    public string SiteOfficeAddress  { get; set; }
    public string SiteOfficeTimings  { get; set; }

    // Land & Area
    public decimal? TotalLandAreaSqYd  { get; set; }
    public decimal? TotalBuiltUpSqFt   { get; set; }
    public decimal? FARApproved        { get; set; }
    public int?     TotalFloors        { get; set; }
    public int?     UnitsPerFloor      { get; set; }
    public int      TotalUnits         { get; set; }
    public decimal? OpenGreenAreaPct   { get; set; }
    public string   ParkingType        { get; set; }
    public int?     NumberOfBlocks     { get; set; }

    // Pricing
    public decimal? BSPRatePerSqFt     { get; set; }
    public decimal? PLCAmount          { get; set; }
    public decimal? IFMSAmount         { get; set; }
    public decimal? ClubMembershipAmt  { get; set; }
    public decimal? PowerBackupAmt     { get; set; }
    public decimal? MaintenanceDeposit { get; set; }

    // Payment Plan
    public int?     PaymentPlanTypeID    { get; set; }
    public decimal? BookingAmount        { get; set; }
    public decimal? OnAgreementPct       { get; set; }
    public decimal? OnPossessionPct      { get; set; }
    public int?     NumberOfInstallments { get; set; }
    public decimal? GSTRatePct           { get; set; }

    // Commission
    public decimal? CommissionL1Pct  { get; set; }
    public decimal? CommissionL2Pct  { get; set; }
    public decimal? CommissionL3Pct  { get; set; }
    public decimal? BrokerageCommPct { get; set; }
    public string   CommissionPayout { get; set; }
    public decimal? TDSOnCommPct     { get; set; }

    // Specifications
    public string FlooringType     { get; set; }
    public string KitchenType      { get; set; }
    public string BathroomFixtures { get; set; }
    public string WindowType       { get; set; }
    public string SpecialFeatures  { get; set; }

    // Media
    public string CoverImagePath      { get; set; }
    public string ProjectLogoBadge    { get; set; }
    public string WalkthroughVideoURL { get; set; }
    public string VirtualTourURL      { get; set; }

    // Feature Toggles
    public bool IsOnlineBooking   { get; set; }
    public bool IsShowOnWebsite   { get; set; }
    public bool IsEMICalculator   { get; set; }
    public bool IsAgentReferral   { get; set; }
    public bool IsHoldUnitAllowed { get; set; }
    public bool IsVastuCompliant  { get; set; }

    // Publish
    public string    PublishMode       { get; set; }
    public DateTime? ScheduledLaunchAt { get; set; }

    // Audit
    public string    CreatedBy { get; set; }
    public DateTime  CreatedAt { get; set; }
    public string    UpdatedBy { get; set; }
    public DateTime? UpdatedAt { get; set; }

    // Child collections
    public List<ProjectBlockModel>    Blocks     { get; set; }
    public List<ProjectUnitTypeModel> UnitTypes  { get; set; }
    public List<int>                  AmenityIDs { get; set; }
    public List<int>                  BankIDs    { get; set; }

    public ProjectModel()
    {
        DeveloperName     = "Adarsh Realtors";
        PublishMode       = "draft";
        IsOnlineBooking   = true;
        IsShowOnWebsite   = true;
        IsEMICalculator   = true;
        IsAgentReferral   = true;
        IsHoldUnitAllowed = true;
        Blocks     = new List<ProjectBlockModel>();
        UnitTypes  = new List<ProjectUnitTypeModel>();
        AmenityIDs = new List<int>();
        BankIDs    = new List<int>();
    }
}

// ── PROJECT BLOCK ────────────────────────────

public class ProjectBlockModel
{
    public int    BlockID        { get; set; }
    public int    ProjectID      { get; set; }
    public string BlockName      { get; set; }
    public int?   NumberOfFloors { get; set; }
    public int?   UnitsPerFloor  { get; set; }
    public int    TotalUnits     { get { return (NumberOfFloors ?? 0) * (UnitsPerFloor ?? 0); } }
    public string BlockCategory  { get; set; }
    public int    SortOrder      { get; set; }
    public bool   IsActive       { get; set; }
}

// ── UNIT TYPE ROW ────────────────────────────

public class ProjectUnitTypeModel
{
    public int     UnitTypeRowID   { get; set; }
    public int     ProjectID       { get; set; }
    public int     UnitTypeID      { get; set; }
    public string  UnitTypeName    { get; set; }
    public decimal SuperAreaSqFt   { get; set; }
    public decimal? CarpetAreaSqFt { get; set; }
    public int     NumberOfUnits   { get; set; }
    public decimal? BSPPerSqFt     { get; set; }
    public decimal? PLCAmount      { get; set; }
    public bool    IsActive        { get; set; }
}

// ── DOCUMENT ─────────────────────────────────

public class ProjectDocumentModel
{
    public int      DocumentID  { get; set; }
    public int      ProjectID   { get; set; }
    public int      DocTypeID   { get; set; }
    public string   DocTypeName { get; set; }
    public string   FileName    { get; set; }
    public string   FilePath    { get; set; }
    public long?    FileSize    { get; set; }
    public string   MimeType    { get; set; }
    public string   UploadedBy  { get; set; }
    public DateTime UploadedAt  { get; set; }
    public bool     IsActive    { get; set; }
}

// ── GALLERY IMAGE ─────────────────────────────

public class ProjectGalleryImage
{
    public int      GalleryID  { get; set; }
    public int      ProjectID  { get; set; }
    public string   ImagePath  { get; set; }
    public string   Caption    { get; set; }
    public bool     IsCover    { get; set; }
    public int      SortOrder  { get; set; }
    public string   UploadedBy { get; set; }
    public DateTime UploadedAt { get; set; }
    public bool     IsActive   { get; set; }
}

// ── SUMMARY (list page ke liye) ──────────────

public class ProjectSummary
{
    public int      ProjectID        { get; set; }
    public string   ProjectCode      { get; set; }
    public string   ProjectName      { get; set; }
    public string   ProjectType      { get; set; }
    public string   ProjectCategory  { get; set; }
    public string   RERANumber       { get; set; }
    public string   City             { get; set; }
    public string   StateName        { get; set; }
    public DateTime? LaunchDate      { get; set; }
    public DateTime  PossessionDate  { get; set; }
    public string   ProjectStatus    { get; set; }
    public string   PublishMode      { get; set; }
    public int      TotalUnits       { get; set; }
    public decimal? BSPRatePerSqFt   { get; set; }
    public string   BranchName       { get; set; }
    public string   ProjectManager   { get; set; }
    public int      BlockCount       { get; set; }
    public int      AmenityCount     { get; set; }
    public int      DocumentCount    { get; set; }
    public DateTime CreatedAt        { get; set; }

    // ▼ NEW: List page ke liye image fields
    public string   CoverImagePath   { get; set; }
    public string   ProjectLogoBadge { get; set; }
}
