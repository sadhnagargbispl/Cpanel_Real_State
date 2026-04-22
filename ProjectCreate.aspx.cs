using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ProjectCreate : System.Web.UI.Page
{
    private ProjectDAL _projectDAL = new ProjectDAL();
    private MasterDAL _masterDAL = new MasterDAL();

    private int CurrentProjectID
    {
        get { return Session["CurrentProjectID"] != null ? (int)Session["CurrentProjectID"] : 0; }
        set { Session["CurrentProjectID"] = value; }
    }

    private int LastSavedStep
    {
        get { return Session["LastSavedStep"] != null ? (int)Session["LastSavedStep"] : 0; }
        set { Session["LastSavedStep"] = value; }
    }

    private string CurrentUser
    {
        get { return Session["idno"] != null ? Session["idno"].ToString() : ""; }
    }

    // ─────────────────────────────────────────────
    //  PAGE LOAD
    // ─────────────────────────────────────────────
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Status"] != null)
        {
            Session["PageName"] = " Wallet / Wallet Transfer  ";
            if (!IsPostBack)
            {
                BindAllDropdowns();

                if (Request.QueryString["pid"] != null)
                {
                    int editID;
                    if (int.TryParse(Request.QueryString["pid"], out editID) && editID > 0)
                    {
                        CurrentProjectID = editID;
                        LastSavedStep = 5;
                        LoadProjectIntoForm(editID);
                        // Edit mode mein Step 5 pe land karo ya Step 1 — choice aapki
                        hdnCurrentStep.Value = "1";
                    }
                }
                else
                {
                    CurrentProjectID = 0;
                    LastSavedStep = 0;

                    string code = ProjectCodeGenerator.GenerateUnique(
                        "", code2 => _projectDAL.IsProjectCodeExists(code2));
                    txtProjectCode.Text = code;
                    hdnProjectCode.Value = code;
                    hdnCurrentStep.Value = "1";
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "initState",
                    string.Format("lastSavedStep={0}; currentProjectID={1};",
                        LastSavedStep, CurrentProjectID), true);
            }
            else
            {
                // Postback — fallback state restore
                ScriptManager.RegisterStartupScript(this, GetType(), "pageState_" + DateTime.Now.Ticks,
                    string.Format(
                        "if(typeof lastSavedStep==='undefined'||lastSavedStep===0){{" +
                        "  lastSavedStep={0}; currentProjectID={1};" +
                        "}}",
                        LastSavedStep, CurrentProjectID), true);
            }
        }
        else
            Response.Redirect("logout.aspx");

    }

    // ─────────────────────────────────────────────
    //  DROPDOWNS
    // ─────────────────────────────────────────────
    private void BindAllDropdowns()
    {
        ddlProjectType.DataSource = _masterDAL.GetProjectTypes();
        ddlProjectType.DataTextField = "TypeName";
        ddlProjectType.DataValueField = "ProjectTypeID";
        ddlProjectType.DataBind();
        ddlProjectType.Items.Insert(0, new ListItem("-- Select Type --", "0"));

        ddlCategory.DataSource = _masterDAL.GetCategories();
        ddlCategory.DataTextField = "CategoryName";
        ddlCategory.DataValueField = "CategoryID";
        ddlCategory.DataBind();
        ddlCategory.Items.Insert(0, new ListItem("-- Select Category --", "0"));

        ddlStatus.DataSource = _masterDAL.GetStatuses();
        ddlStatus.DataTextField = "StatusName";
        ddlStatus.DataValueField = "StatusID";
        ddlStatus.DataBind();

        ddlState.DataSource = _masterDAL.GetStates();
        ddlState.DataTextField = "StateName";
        ddlState.DataValueField = "StateID";
        ddlState.DataBind();
        ddlState.Items.Insert(0, new ListItem("-- Select State --", "0"));

        ddlBranch.DataSource = _masterDAL.GetBranches();
        ddlBranch.DataTextField = "BranchName";
        ddlBranch.DataValueField = "BranchID";
        ddlBranch.DataBind();
        ddlBranch.Items.Insert(0, new ListItem("-- Select Branch --", "0"));

        ddlPaymentPlan.DataSource = _masterDAL.GetPaymentPlanTypes();
        ddlPaymentPlan.DataTextField = "PlanTypeName";
        ddlPaymentPlan.DataValueField = "PlanTypeID";
        ddlPaymentPlan.DataBind();
        ddlPaymentPlan.Items.Insert(0, new ListItem("-- Select Plan --", "0"));

        rptBanks.DataSource = _masterDAL.GetBanks();
        rptBanks.DataBind();

        BindStatic(ddlParkingType, new string[] { "Covered + Open", "Only Covered", "Only Open", "Multi-level Basement" });
        BindStatic(ddlCommPayout, new string[] { "On Booking", "On Agreement", "On Demand Letter", "On Possession" });
        BindStatic(ddlFlooring, new string[] { "Vitrified Tiles", "Marble", "Wooden Flooring", "Combination" });
        BindStatic(ddlKitchen, new string[] { "Modular Kitchen", "Semi Modular", "Basic" });
        BindStatic(ddlBathroom, new string[] { "Premium (Jaguar/Kohler)", "Standard", "Basic" });
        BindStatic(ddlWindowType, new string[] { "UPVC Double Glazed", "Aluminium Sliding", "Wooden Frame" });
    }

    private void BindStatic(DropDownList ddl, string[] items)
    {
        ddl.Items.Clear();
        foreach (string item in items) ddl.Items.Add(new ListItem(item, item));
    }

    // ─────────────────────────────────────────────
    //  LOAD PROJECT INTO FORM (edit / back navigation)
    // ─────────────────────────────────────────────
    private void LoadProjectIntoForm(int projectID)
    {
        ProjectModel p = _projectDAL.GetProjectByID(projectID);
        if (p == null) return;

        // Step 1
        txtProjectName.Text = p.ProjectName;
        txtProjectCode.Text = p.ProjectCode;
        hdnProjectCode.Value = p.ProjectCode;       // ← sync hidden
        txtDeveloperName.Text = p.DeveloperName;
        txtRERA.Text = p.RERANumber;
        txtDescription.Text = p.ShortDescription;
        SetDDL(ddlProjectType, p.ProjectTypeID.ToString());
        SetDDL(ddlCategory, p.CategoryID.HasValue ? p.CategoryID.Value.ToString() : "0");

        txtKhasra.Text = p.KhasraPlotNo;
        txtAddress.Text = p.FullAddress;
        txtLandmark.Text = p.Landmark;
        txtCity.Text = p.City;
        txtDistrict.Text = p.District;
        SetDDL(ddlState, p.StateID.ToString());
        txtPinCode.Text = p.PinCode;
        txtZone.Text = p.ZoneSector;

        // ← ReadOnly fields + hidden fields dono sync karo
        txtLatitude.Text = p.Latitude.HasValue ? p.Latitude.Value.ToString() : "";
        txtLongitude.Text = p.Longitude.HasValue ? p.Longitude.Value.ToString() : "";
        hdnLatitude.Value = txtLatitude.Text;
        hdnLongitude.Value = txtLongitude.Text;
        txtGoogleMaps.Text = p.GoogleMapsLink;

        txtLaunchDate.Text = p.LaunchDate.HasValue ? p.LaunchDate.Value.ToString("yyyy-MM-dd") : "";
        txtConstructionStart.Text = p.ConstructionStart.HasValue ? p.ConstructionStart.Value.ToString("yyyy-MM-dd") : "";
        txtPossessionDate.Text = p.PossessionDate != DateTime.MinValue ? p.PossessionDate.ToString("yyyy-MM-dd") : "";
        txtBookingOpenDate.Text = p.BookingOpenDate.HasValue ? p.BookingOpenDate.Value.ToString("yyyy-MM-dd") : "";
        SetDDL(ddlStatus, p.StatusID.ToString());
        txtApprovalAuthority.Text = p.ApprovalAuthority;

        SetDDL(ddlBranch, p.BranchID.ToString());
        txtProjectManager.Text = p.ProjectManager;
        txtSalesHead.Text = p.SalesHead;
        txtSitePhone.Text = p.SiteContactPhone;
        txtSiteAddress.Text = p.SiteOfficeAddress;
        txtSiteTimings.Text = p.SiteOfficeTimings;

        // Step 2
        txtLandArea.Text = p.TotalLandAreaSqYd.HasValue ? p.TotalLandAreaSqYd.Value.ToString() : "";
        txtBuiltUp.Text = p.TotalBuiltUpSqFt.HasValue ? p.TotalBuiltUpSqFt.Value.ToString() : "";
        txtFAR.Text = p.FARApproved.HasValue ? p.FARApproved.Value.ToString() : "";
        txtTotalFloors.Text = p.TotalFloors.HasValue ? p.TotalFloors.Value.ToString() : "";
        txtUnitsPerFloor.Text = p.UnitsPerFloor.HasValue ? p.UnitsPerFloor.Value.ToString() : "";
        txtTotalUnits.Text = p.TotalUnits.ToString();
        txtGreenArea.Text = p.OpenGreenAreaPct.HasValue ? p.OpenGreenAreaPct.Value.ToString() : "";
        txtNumBlocks.Text = p.NumberOfBlocks.HasValue ? p.NumberOfBlocks.Value.ToString() : "";
        SetDDL(ddlParkingType, p.ParkingType);
        txtBSP.Text = p.BSPRatePerSqFt.HasValue ? p.BSPRatePerSqFt.Value.ToString() : "";
        txtPLC.Text = p.PLCAmount.HasValue ? p.PLCAmount.Value.ToString() : "";
        txtIFMS.Text = p.IFMSAmount.HasValue ? p.IFMSAmount.Value.ToString() : "";
        txtClubMembership.Text = p.ClubMembershipAmt.HasValue ? p.ClubMembershipAmt.Value.ToString() : "";
        txtPowerBackup.Text = p.PowerBackupAmt.HasValue ? p.PowerBackupAmt.Value.ToString() : "";
        txtMaintDeposit.Text = p.MaintenanceDeposit.HasValue ? p.MaintenanceDeposit.Value.ToString() : "";
        SetDDL(ddlPaymentPlan, p.PaymentPlanTypeID.HasValue ? p.PaymentPlanTypeID.Value.ToString() : "0");
        txtBookingAmount.Text = p.BookingAmount.HasValue ? p.BookingAmount.Value.ToString() : "";
        txtOnAgreement.Text = p.OnAgreementPct.HasValue ? p.OnAgreementPct.Value.ToString() : "";
        txtOnPossession.Text = p.OnPossessionPct.HasValue ? p.OnPossessionPct.Value.ToString() : "";
        txtInstallments.Text = p.NumberOfInstallments.HasValue ? p.NumberOfInstallments.Value.ToString() : "";
        txtGST.Text = p.GSTRatePct.HasValue ? p.GSTRatePct.Value.ToString() : "";
        txtCommL1.Text = p.CommissionL1Pct.HasValue ? p.CommissionL1Pct.Value.ToString() : "";
        txtCommL2.Text = p.CommissionL2Pct.HasValue ? p.CommissionL2Pct.Value.ToString() : "";
        txtCommL3.Text = p.CommissionL3Pct.HasValue ? p.CommissionL3Pct.Value.ToString() : "";
        txtBrokerage.Text = p.BrokerageCommPct.HasValue ? p.BrokerageCommPct.Value.ToString() : "";
        txtTDS.Text = p.TDSOnCommPct.HasValue ? p.TDSOnCommPct.Value.ToString() : "";
        SetDDL(ddlCommPayout, p.CommissionPayout);

        // Step 3
        SetDDL(ddlFlooring, p.FlooringType);
        SetDDL(ddlKitchen, p.KitchenType);
        SetDDL(ddlBathroom, p.BathroomFixtures);
        SetDDL(ddlWindowType, p.WindowType);
        txtSpecialFeatures.Text = p.SpecialFeatures;
        chkOnlineBooking.Checked = p.IsOnlineBooking;
        chkShowWebsite.Checked = p.IsShowOnWebsite;
        chkEMICalc.Checked = p.IsEMICalculator;
        chkAgentReferral.Checked = p.IsAgentReferral;
        chkHoldUnit.Checked = p.IsHoldUnitAllowed;
        chkVastu.Checked = p.IsVastuCompliant;

        // Step 4
        txtVideoURL.Text = p.WalkthroughVideoURL;
        txtVirtualTour.Text = p.VirtualTourURL;

        // Documents badge data
        var docList = _projectDAL.GetDocuments(CurrentProjectID);
        if (docList != null && docList.Count > 0)
        {
            var js = new JavaScriptSerializer();
            var dList = new List<object>();
            foreach (var d in docList)
                dList.Add(new { docTypeID = d.DocTypeID, fileName = d.FileName });
            hdnDocsJSON.Value = js.Serialize(dList);
        }
        else hdnDocsJSON.Value = "";

        hdnCoverImage.Value = !string.IsNullOrEmpty(p.CoverImagePath) ? ResolveUrl(p.CoverImagePath) : "";
        hdnLogoImage.Value = !string.IsNullOrEmpty(p.ProjectLogoBadge) ? ResolveUrl(p.ProjectLogoBadge) : "";

        // Gallery
        var galleryList = _projectDAL.GetGalleryImages(CurrentProjectID);
        if (galleryList != null && galleryList.Count > 0)
        {
            var js2 = new JavaScriptSerializer();
            var gList = new List<object>();
            foreach (var g in galleryList)
                gList.Add(new { path = ResolveUrl(g.ImagePath), name = Path.GetFileName(g.ImagePath), isCover = g.IsCover });
            hdnGalleryJSON.Value = js2.Serialize(gList);
        }
        else hdnGalleryJSON.Value = "";

        // JS dynamic grids
        hdnAmenityIDs.Value = string.Join(",", p.AmenityIDs);
        hdnBankIDs.Value = string.Join(",", p.BankIDs);
        try
        {
            var js = new JavaScriptSerializer();

            // ── Blocks + BHK types (DB se load) ──
            if (p.Blocks != null && p.Blocks.Count > 0)
            {
                var bList = new List<object>();
                foreach (var b in p.Blocks)
                {
                    // BhkTypes bhi include karo
                    var bhkList = new List<object>();
                    if (b.BhkTypes != null)
                    {
                        foreach (var t in b.BhkTypes)
                            bhkList.Add(new { typeID = t.TypeID, count = t.UnitCount });
                    }

                    bList.Add(new
                    {
                        BlockName = b.BlockName,
                        Floors = b.NumberOfFloors ?? 0,
                        UPF = b.UnitsPerFloor ?? 0,
                        Category = b.BlockCategory ?? "Standard",
                        BhkTypes = bhkList          // ← YE MISSING THA
                    });
                }
                hdnBlocksJSON.Value = js.Serialize(bList);
            }

            // ── Unit Types ──
            if (p.UnitTypes != null && p.UnitTypes.Count > 0)
            {
                var uList = new List<object>();
                foreach (var u in p.UnitTypes)
                    uList.Add(new
                    {
                        UnitTypeID = u.UnitTypeID,
                        Super = u.SuperAreaSqFt,
                        Carpet = u.CarpetAreaSqFt ?? 0,
                        Count = u.NumberOfUnits,
                        BSP = u.BSPPerSqFt ?? 0,
                        PLC = u.PLCAmount ?? 0
                    });
                hdnUnitTypesJSON.Value = js.Serialize(uList);
            }
        }
        catch { }
        //try
        //{
        //    var js = new JavaScriptSerializer();
        //    if (p.Blocks != null && p.Blocks.Count > 0)
        //    {
        //        var bList = new List<object>();
        //        foreach (var b in p.Blocks)
        //            bList.Add(new { BlockName = b.BlockName, Floors = b.NumberOfFloors ?? 0, UPF = b.UnitsPerFloor ?? 0, Category = b.BlockCategory ?? "Standard" });
        //        hdnBlocksJSON.Value = js.Serialize(bList);
        //    }
        //    if (p.UnitTypes != null && p.UnitTypes.Count > 0)
        //    {
        //        var uList = new List<object>();
        //        foreach (var u in p.UnitTypes)
        //            uList.Add(new { UnitTypeID = u.UnitTypeID, Super = u.SuperAreaSqFt, Carpet = u.CarpetAreaSqFt ?? 0, Count = u.NumberOfUnits, BSP = u.BSPPerSqFt ?? 0, PLC = u.PLCAmount ?? 0 });
        //        hdnUnitTypesJSON.Value = js.Serialize(uList);
        //    }
        //}
        //catch { }
    }

    private void SetDDL(DropDownList ddl, string value)
    {
        if (string.IsNullOrEmpty(value)) return;
        ListItem item = ddl.Items.FindByValue(value);
        if (item != null) item.Selected = true;
    }

    // ─────────────────────────────────────────────
    //  BACK BUTTON
    // ─────────────────────────────────────────────
    protected void btnGoBack_Click(object sender, EventArgs e)
    {
        NavigateBack();
    }

    // ─────────────────────────────────────────────
    //  SAVE STEP 1
    // ─────────────────────────────────────────────
    protected void btnSaveStep1_Click(object sender, EventArgs e)
    {
        try
        {
            ProjectModel p = BuildStep1Model();

            if (CurrentProjectID == 0)
            {
                p.ProjectCode = ProjectCodeGenerator.GenerateUnique("", code => _projectDAL.IsProjectCodeExists(code));
                hdnProjectCode.Value = p.ProjectCode;
            }

            if (string.IsNullOrWhiteSpace(p.ProjectName))
            {
                ShowToast("Project Name required hai.", "error");
                return;
            }

            int pid = _projectDAL.SaveProject(p, CurrentUser);
            CurrentProjectID = pid;
            LastSavedStep = Math.Max(LastSavedStep, 1);

            // ▼ Server step 2 pe bhejega
            hdnCurrentStep.Value = "2";

            string code2 = (p.ProjectCode ?? "").Replace("'", "\\'");
            ShowToast("Step 1 saved!", "success");
            ScriptManager.RegisterStartupScript(this, GetType(), "s1ok",
                string.Format(
                    "currentProjectID={0}; lastSavedStep={1};" +
                    "document.getElementById('{2}').value='{3}';" +
                    "document.getElementById('{4}').value='{3}';" +
                    "onServerSaveSuccess(1);",
                    pid, LastSavedStep,
                    txtProjectCode.ClientID, code2, hdnProjectCode.ClientID), true);
        }
        catch (Exception ex) { ShowToast("Error: " + ex.Message, "error"); }
    }

    // ─────────────────────────────────────────────
    //  SAVE STEP 2
    // ─────────────────────────────────────────────
    protected void btnSaveStep2_Click(object sender, EventArgs e)
    {
        if (CurrentProjectID == 0) { ShowToast("Pehle Step 1 save karo.", "error"); return; }
        try
        {
            //_projectDAL.SaveConfiguration(BuildStep2Model(), CurrentUser);
            // Force sync from blocks JSON if txtTotalUnits is empty
            if (string.IsNullOrEmpty(txtTotalUnits.Text) || txtTotalUnits.Text == "0")
            {
                if (!string.IsNullOrEmpty(hdnBlocksJSON.Value))
                {
                    try
                    {
                        var js2 = new JavaScriptSerializer();
                        var blks = js2.Deserialize<List<BlockJsonDTO>>(hdnBlocksJSON.Value);
                        int totalU = 0, maxF = 0, maxU = 0;
                        if (blks != null)
                            foreach (var b in blks)
                            {
                                totalU += b.Floors * b.UPF;
                                if (b.Floors > maxF) maxF = b.Floors;
                                if (b.UPF > maxU) maxU = b.UPF;
                            }
                        txtTotalUnits.Text = totalU.ToString();
                        txtTotalFloors.Text = maxF.ToString();
                        txtUnitsPerFloor.Text = maxU.ToString();
                    }
                    catch { }
                }
            }
            _projectDAL.SaveConfiguration(BuildStep2Model(), CurrentUser);
            if (!string.IsNullOrEmpty(hdnBlocksJSON.Value)) SaveBlocksFromJSON(hdnBlocksJSON.Value);
            if (!string.IsNullOrEmpty(hdnUnitTypesJSON.Value)) SaveUnitTypesFromJSON(hdnUnitTypesJSON.Value);
            List<int> bankIDs = ParseIDs(hdnBankIDs.Value);
            if (bankIDs.Count > 0) _projectDAL.SaveBankLinks(CurrentProjectID, bankIDs, CurrentUser);
            LastSavedStep = Math.Max(LastSavedStep, 2);

            hdnCurrentStep.Value = "3";

            ShowToast("Step 2 saved!", "success");
            ScriptManager.RegisterStartupScript(this, GetType(), "s2ok",
                string.Format("lastSavedStep={0}; onServerSaveSuccess(2);", LastSavedStep), true);
        }
        catch (Exception ex) { ShowToast("Error: " + ex.Message, "error"); }
    }

    // ─────────────────────────────────────────────
    //  SAVE STEP 3
    // ─────────────────────────────────────────────
    protected void btnSaveStep3_Click(object sender, EventArgs e)
    {
        if (CurrentProjectID == 0) { ShowToast("Pehle Step 1 save karo.", "error"); return; }
        try
        {
            List<int> amenityIDs = ParseIDs(hdnAmenityIDs.Value);
            if (amenityIDs.Count > 0) _projectDAL.SaveAmenities(CurrentProjectID, amenityIDs, CurrentUser);
            _projectDAL.SaveSpecifications(BuildStep3Model(), CurrentUser);
            LastSavedStep = Math.Max(LastSavedStep, 3);

            hdnCurrentStep.Value = "4";

            ShowToast("Step 3 saved!", "success");
            ScriptManager.RegisterStartupScript(this, GetType(), "s3ok",
                string.Format("lastSavedStep={0}; onServerSaveSuccess(3);", LastSavedStep), true);
        }
        catch (Exception ex) { ShowToast("Error: " + ex.Message, "error"); }
    }

    // ─────────────────────────────────────────────
    //  SAVE STEP 4
    // ─────────────────────────────────────────────

    protected void btnSaveStep4_Click(object sender, EventArgs e)
    {
        if (CurrentProjectID == 0) { ShowToast("Pehle Step 1 save karo.", "error"); return; }
        try
        {
            string folder = Server.MapPath("~/Uploads/Projects/" + CurrentProjectID + "/");
            if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);

            ProjectModel p = new ProjectModel { ProjectID = CurrentProjectID };
            if (fuCoverImage.HasFile) p.CoverImagePath = SaveFile(fuCoverImage.PostedFile, folder, "cover");
            if (fuProjectLogo.HasFile) p.ProjectLogoBadge = SaveFile(fuProjectLogo.PostedFile, folder, "logo");
            p.WalkthroughVideoURL = txtVideoURL.Text.Trim();
            p.VirtualTourURL = txtVirtualTour.Text.Trim();
            _projectDAL.SaveMedia(p, CurrentUser);

            // ▼ Cover/Logo save hone ke baad hdnCoverImage/hdnLogoImage update karo
            // Taaki Edit pe wapas aane par DB path se preview dikhega
            if (!string.IsNullOrEmpty(p.CoverImagePath))
            {
                hdnCoverImage.Value = ResolveUrl(p.CoverImagePath);
                hdnNewCoverBase64.Value = "";  // naya base64 clear karo — ab DB path use hoga
            }
            if (!string.IsNullOrEmpty(p.ProjectLogoBadge))
            {
                hdnLogoImage.Value = ResolveUrl(p.ProjectLogoBadge);
                hdnNewLogoBase64.Value = "";   // naya base64 clear karo
            }

            // Gallery base64
            string galleryJson = hdnNewGalleryBase64.Value;
            if (!string.IsNullOrEmpty(galleryJson) && galleryJson != "[]")
            {
                var js = new JavaScriptSerializer();
                js.MaxJsonLength = int.MaxValue;
                var imgList = js.Deserialize<List<GalleryImageDTO>>(galleryJson);
                if (imgList != null && imgList.Count > 0)
                {
                    _projectDAL.ClearGalleryImages(CurrentProjectID);
                    int sort = 0;
                    foreach (var imgDto in imgList)
                    {
                        string savedPath = null;
                        if (!string.IsNullOrEmpty(imgDto.data))
                            savedPath = SaveBase64Image(imgDto.data, imgDto.name, folder, "gal_" + sort);
                        else if (!string.IsNullOrEmpty(imgDto.path))
                            savedPath = imgDto.path;

                        if (!string.IsNullOrEmpty(savedPath))
                        {
                            _projectDAL.SaveGalleryImage(new ProjectGalleryImage
                            {
                                ProjectID = CurrentProjectID,
                                ImagePath = savedPath,
                                IsCover = imgDto.isCover,
                                SortOrder = sort++,
                                UploadedBy = CurrentUser
                            });
                        }
                    }
                }
            }

            // Documents
            UploadDoc(fuRERA, 1, folder); UploadDoc(fuLandDeed, 2, folder);
            UploadDoc(fuLayoutPlan, 3, folder); UploadDoc(fuBuildingSanc, 4, folder);
            UploadDoc(fuEnvNOC, 5, folder); UploadDoc(fuFireNOC, 6, folder);
            UploadDoc(fuRoadClearance, 7, folder); UploadDoc(fuSocietyReg, 8, folder);
            UploadDoc(fuBrochure, 9, folder); UploadDoc(fuFloorPlans, 10, folder);
            UploadDoc(fuMasterPlan, 11, folder); UploadDoc(fuCircular, 12, folder);
            UploadDoc(fuPriceList, 13, folder); UploadDoc(fuSpecSheet, 14, folder);

            LastSavedStep = Math.Max(LastSavedStep, 4);

            // ▼ Step 5 (Review) pe bhejo — sab data wahan dikhega
            hdnCurrentStep.Value = "5";

            // ▼ Documents badge data refresh
            var docList = _projectDAL.GetDocuments(CurrentProjectID);
            if (docList != null && docList.Count > 0)
            {
                var jsDoc = new JavaScriptSerializer();
                var dList = new List<object>();
                foreach (var d in docList)
                    dList.Add(new { docTypeID = d.DocTypeID, fileName = d.FileName });
                hdnDocsJSON.Value = jsDoc.Serialize(dList);
            }

            ShowToast("Step 4 saved!", "success");
            ScriptManager.RegisterStartupScript(this, GetType(), "s4ok",
                string.Format("lastSavedStep={0}; onServerSaveSuccess(4);", LastSavedStep), true);
        }
        catch (Exception ex) { ShowToast("Error: " + ex.Message, "error"); }
    }

    private string SaveBase64Image(string base64Data, string originalName, string folder, string prefix)
    {
        try
        {
            string base64 = base64Data;
            if (base64Data.Contains(","))
                base64 = base64Data.Split(',')[1];

            byte[] bytes = Convert.FromBase64String(base64);
            string fileName = prefix + "_" + DateTime.Now.Ticks + ".jpg";
            string filePath = Path.Combine(folder, fileName);

            // Gallery images: max 1200px, 75% quality — koi bhi size ho compress hogi
            using (var ms = new MemoryStream(bytes))
            {
                CompressAndSaveImage(ms, filePath, 1200, 75);
            }
            return "~/Uploads/Projects/" + CurrentProjectID + "/" + fileName;
        }
        catch { return null; }
    }

    // ─────────────────────────────────────────────
    //  CORE COMPRESSION ENGINE
    //  - Image ko maxWidth se chhota karta hai (aspect ratio maintain)
    //  - JPEG quality se compress karta hai
    //  - Koi bhi format (PNG/WEBP/BMP) → JPEG output
    //  - File already chhhoti ho toh resize nahi hoti (sirf compress)
    // ─────────────────────────────────────────────
    private void CompressAndSaveImage(Stream inputStream, string outputPath, int maxWidth, int jpegQuality)
    {
        using (var original = System.Drawing.Image.FromStream(inputStream, true, true))
        {
            int srcW = original.Width;
            int srcH = original.Height;

            // Target dimensions calculate karo
            int tgtW = srcW;
            int tgtH = srcH;
            if (srcW > maxWidth)
            {
                tgtW = maxWidth;
                tgtH = (int)Math.Round((double)srcH * maxWidth / srcW);
            }

            // Bitmap banao — high quality resize
            using (var bmp = new Bitmap(tgtW, tgtH, PixelFormat.Format24bppRgb))
            {
                bmp.SetResolution(72, 72);   // web ke liye 72 DPI kaafi hai
                using (var g = Graphics.FromImage(bmp))
                {
                    g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    g.SmoothingMode = SmoothingMode.HighQuality;
                    g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    g.CompositingQuality = CompositingQuality.HighQuality;
                    // White background (PNG transparency ke liye)
                    g.Clear(Color.White);
                    g.DrawImage(original, new Rectangle(0, 0, tgtW, tgtH),
                                         new Rectangle(0, 0, srcW, srcH),
                                         GraphicsUnit.Pixel);
                }

                // JPEG encoder params
                var encoder = GetJpegEncoder();
                var encParams = new EncoderParameters(1);
                encParams.Param[0] = new EncoderParameter(Encoder.Quality, (long)jpegQuality);
                bmp.Save(outputPath, encoder, encParams);
            }
        }
    }

    private static ImageCodecInfo _jpegEncoder;
    private static ImageCodecInfo GetJpegEncoder()
    {
        if (_jpegEncoder == null)
            _jpegEncoder = ImageCodecInfo.GetImageEncoders()
                           .First(c => c.FormatID == ImageFormat.Jpeg.Guid);
        return _jpegEncoder;
    }

    public class GalleryImageDTO
    {
        public string name { get; set; }
        public bool isCover { get; set; }
        public string data { get; set; }
        public string path { get; set; }
    }

    // ─────────────────────────────────────────────
    //  PUBLISH
    // ─────────────────────────────────────────────

    protected void btnPublish_Click(object sender, EventArgs e)
    {
        if (CurrentProjectID == 0) { ShowToast("Pehle saare steps complete karo.", "error"); return; }

        string mode = hdnPublishMode.Value;
        if (string.IsNullOrEmpty(mode)) mode = "draft";

        try
        {
            // ── Step 1 ──
            if (!string.IsNullOrWhiteSpace(txtProjectName.Text) && ValidateStep1Silent())
                _projectDAL.SaveProject(BuildStep1Model(), CurrentUser);

            // ── Step 2 ──
            if (!string.IsNullOrWhiteSpace(txtTotalUnits.Text))
            {
                _projectDAL.SaveConfiguration(BuildStep2Model(), CurrentUser);
                if (!string.IsNullOrEmpty(hdnBlocksJSON.Value))
                    SaveBlocksFromJSON(hdnBlocksJSON.Value);
                if (!string.IsNullOrEmpty(hdnUnitTypesJSON.Value))
                    SaveUnitTypesFromJSON(hdnUnitTypesJSON.Value);
                List<int> bankIDs = ParseIDs(hdnBankIDs.Value);
                if (bankIDs.Count > 0)
                    _projectDAL.SaveBankLinks(CurrentProjectID, bankIDs, CurrentUser);
            }

            // ── Step 3 ──
            List<int> amenityIDs = ParseIDs(hdnAmenityIDs.Value);
            if (amenityIDs.Count > 0)
                _projectDAL.SaveAmenities(CurrentProjectID, amenityIDs, CurrentUser);
            _projectDAL.SaveSpecifications(BuildStep3Model(), CurrentUser);

            // ── Step 4 — Media + Documents ──
            //string folder = Server.MapPath("~/Uploads/Projects/" + CurrentProjectID + "/");
            //if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);

            //ProjectModel pm = new ProjectModel { ProjectID = CurrentProjectID };
            if (fuCoverImage.HasFile || fuProjectLogo.HasFile || !string.IsNullOrWhiteSpace(txtVideoURL.Text) || !string.IsNullOrWhiteSpace(txtVirtualTour.Text))
            {
                string folder = Server.MapPath("~/Uploads/Projects/" + CurrentProjectID + "/");
                if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);
                ProjectModel pm = new ProjectModel { ProjectID = CurrentProjectID };
                if (fuCoverImage.HasFile) pm.CoverImagePath = SaveFile(fuCoverImage.PostedFile, folder, "cover");
                if (fuProjectLogo.HasFile) pm.ProjectLogoBadge = SaveFile(fuProjectLogo.PostedFile, folder, "logo");
                pm.WalkthroughVideoURL = txtVideoURL.Text.Trim();
                pm.VirtualTourURL = txtVirtualTour.Text.Trim();
                _projectDAL.SaveMedia(pm, CurrentUser);
                UploadDoc(fuRERA, 1, folder); UploadDoc(fuLandDeed, 2, folder);
                UploadDoc(fuLayoutPlan, 3, folder); UploadDoc(fuBuildingSanc, 4, folder);
                UploadDoc(fuEnvNOC, 5, folder); UploadDoc(fuFireNOC, 6, folder);
                UploadDoc(fuRoadClearance, 7, folder); UploadDoc(fuSocietyReg, 8, folder);
                UploadDoc(fuBrochure, 9, folder); UploadDoc(fuFloorPlans, 10, folder);
                UploadDoc(fuMasterPlan, 11, folder); UploadDoc(fuCircular, 12, folder);
                UploadDoc(fuPriceList, 13, folder); UploadDoc(fuSpecSheet, 14, folder);
            }
            //if (fuCoverImage.HasFile)
            //    pm.CoverImagePath = SaveFile(fuCoverImage.PostedFile, folder, "cover");
            //if (fuProjectLogo.HasFile)
            //    pm.ProjectLogoBadge = SaveFile(fuProjectLogo.PostedFile, folder, "logo");
            //pm.WalkthroughVideoURL = txtVideoURL.Text.Trim();
            //pm.VirtualTourURL = txtVirtualTour.Text.Trim();
            //_projectDAL.SaveMedia(pm, CurrentUser);

            //// ✅ FIX: Gallery base64 save — Publish mein pehle missing tha
            //string galleryJson = hdnNewGalleryBase64.Value;
            //if (!string.IsNullOrEmpty(galleryJson) && galleryJson != "[]")
            //{
            //    var js = new JavaScriptSerializer();
            //    js.MaxJsonLength = int.MaxValue;
            //    var imgList = js.Deserialize<List<GalleryImageDTO>>(galleryJson);
            //    if (imgList != null && imgList.Count > 0)
            //    {
            //        _projectDAL.ClearGalleryImages(CurrentProjectID);
            //        int sort = 0;
            //        foreach (var imgDto in imgList)
            //        {
            //            string savedPath = null;
            //            if (!string.IsNullOrEmpty(imgDto.data))
            //                savedPath = SaveBase64Image(imgDto.data, imgDto.name, folder, "gal_" + sort);
            //            else if (!string.IsNullOrEmpty(imgDto.path))
            //                savedPath = imgDto.path;

            //            if (!string.IsNullOrEmpty(savedPath))
            //            {
            //                _projectDAL.SaveGalleryImage(new ProjectGalleryImage
            //                {
            //                    ProjectID = CurrentProjectID,
            //                    ImagePath = savedPath,
            //                    IsCover = imgDto.isCover,
            //                    SortOrder = sort++,
            //                    UploadedBy = CurrentUser
            //                });
            //            }
            //        }
            //    }
            //}

            //// Documents
            //UploadDoc(fuRERA, 1, folder); UploadDoc(fuLandDeed, 2, folder);
            //UploadDoc(fuLayoutPlan, 3, folder); UploadDoc(fuBuildingSanc, 4, folder);
            //UploadDoc(fuEnvNOC, 5, folder); UploadDoc(fuFireNOC, 6, folder);
            //UploadDoc(fuRoadClearance, 7, folder); UploadDoc(fuSocietyReg, 8, folder);
            //UploadDoc(fuBrochure, 9, folder); UploadDoc(fuFloorPlans, 10, folder);
            //UploadDoc(fuMasterPlan, 11, folder); UploadDoc(fuCircular, 12, folder);
            //UploadDoc(fuPriceList, 13, folder); UploadDoc(fuSpecSheet, 14, folder);

            // ── Publish ──
            _projectDAL.PublishProject(CurrentProjectID, mode, null, CurrentUser);

            string projName = txtProjectName.Text.Trim();
            string projCode = txtProjectCode.Text.Trim();
            if (string.IsNullOrEmpty(projCode)) projCode = hdnProjectCode.Value;

            // Session reset
            CurrentProjectID = 0;
            LastSavedStep = 0;
            hdnCurrentStep.Value = "1";

            // Labels
            string modeLabel = mode == "active" ? "Published" :
                               mode == "upcoming" ? "Scheduled" : "Draft Saved";
            string modeIcon = mode == "active" ? "fa-rocket" :
                               mode == "upcoming" ? "fa-calendar-check" : "fa-file-pen";
            string modeColor = mode == "active" ? "#16A34A" :
                               mode == "upcoming" ? "#1D4ED8" : "#92400E";
            string modeMsg = mode == "active"
                ? "Project ab customers aur agents ke liye live hai."
                : (mode == "upcoming"
                    ? "Project scheduled hai — launch date pe live hoga."
                    : "Draft save ho gaya hai.");

            ScriptManager.RegisterStartupScript(this, GetType(), "publishOK",
                string.Format("showPublishSuccess('{0}','{1}','{2}','{3}','{4}','{5}');",
                    projName.Replace("'", "\\'"),
                    projCode.Replace("'", "\\'"),
                    modeLabel, modeIcon, modeColor,
                    modeMsg.Replace("'", "\\'")), true);
            //ScriptManager.RegisterStartupScript(this, GetType(), "publishOK",
            //    string.Format(
            //        "setTimeout(function(){{showPublishSuccess('{0}','{1}','{2}','{3}','{4}','{5}');}}, 200);",
            //        projName.Replace("'", "\\'"),
            //        projCode.Replace("'", "\\'"),
            //        modeLabel,
            //        modeIcon,
            //        modeColor,
            //        modeMsg.Replace("'", "\\'")),
            //    true);
        }
        catch (Exception ex)
        {
            ShowToast("Publish Error: " + ex.Message, "error");
        }
    }
    //protected void btnPublish_Click(object sender, EventArgs e)
    //{
    //    if (CurrentProjectID == 0) { ShowToast("Pehle saare steps complete karo.", "error"); return; }

    //    string mode = hdnPublishMode.Value;
    //    if (string.IsNullOrEmpty(mode)) mode = "draft";

    //    try
    //    {
    //        if (!string.IsNullOrWhiteSpace(txtProjectName.Text) && ValidateStep1Silent())
    //            _projectDAL.SaveProject(BuildStep1Model(), CurrentUser);

    //        if (!string.IsNullOrWhiteSpace(txtTotalUnits.Text))
    //        {
    //            _projectDAL.SaveConfiguration(BuildStep2Model(), CurrentUser);
    //            if (!string.IsNullOrEmpty(hdnBlocksJSON.Value)) SaveBlocksFromJSON(hdnBlocksJSON.Value);
    //            if (!string.IsNullOrEmpty(hdnUnitTypesJSON.Value)) SaveUnitTypesFromJSON(hdnUnitTypesJSON.Value);
    //            List<int> bankIDs = ParseIDs(hdnBankIDs.Value);
    //            if (bankIDs.Count > 0) _projectDAL.SaveBankLinks(CurrentProjectID, bankIDs, CurrentUser);
    //        }

    //        List<int> amenityIDs = ParseIDs(hdnAmenityIDs.Value);
    //        if (amenityIDs.Count > 0) _projectDAL.SaveAmenities(CurrentProjectID, amenityIDs, CurrentUser);
    //        _projectDAL.SaveSpecifications(BuildStep3Model(), CurrentUser);

    //        if (fuCoverImage.HasFile || fuProjectLogo.HasFile ||
    //            !string.IsNullOrWhiteSpace(txtVideoURL.Text) ||
    //            !string.IsNullOrWhiteSpace(txtVirtualTour.Text))
    //        {
    //            string folder = Server.MapPath("~/Uploads/Projects/" + CurrentProjectID + "/");
    //            if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);
    //            ProjectModel pm = new ProjectModel { ProjectID = CurrentProjectID };
    //            if (fuCoverImage.HasFile) pm.CoverImagePath = SaveFile(fuCoverImage.PostedFile, folder, "cover");
    //            if (fuProjectLogo.HasFile) pm.ProjectLogoBadge = SaveFile(fuProjectLogo.PostedFile, folder, "logo");
    //            pm.WalkthroughVideoURL = txtVideoURL.Text.Trim();
    //            pm.VirtualTourURL = txtVirtualTour.Text.Trim();
    //            _projectDAL.SaveMedia(pm, CurrentUser);
    //            UploadDoc(fuRERA, 1, folder); UploadDoc(fuLandDeed, 2, folder);
    //            UploadDoc(fuLayoutPlan, 3, folder); UploadDoc(fuBuildingSanc, 4, folder);
    //            UploadDoc(fuEnvNOC, 5, folder); UploadDoc(fuFireNOC, 6, folder);
    //            UploadDoc(fuRoadClearance, 7, folder); UploadDoc(fuSocietyReg, 8, folder);
    //            UploadDoc(fuBrochure, 9, folder); UploadDoc(fuFloorPlans, 10, folder);
    //            UploadDoc(fuMasterPlan, 11, folder); UploadDoc(fuCircular, 12, folder);
    //            UploadDoc(fuPriceList, 13, folder); UploadDoc(fuSpecSheet, 14, folder);
    //        }

    //        _projectDAL.PublishProject(CurrentProjectID, mode, null, CurrentUser);

    //        string projName = txtProjectName.Text.Trim();
    //        string projCode = txtProjectCode.Text.Trim();
    //        if (string.IsNullOrEmpty(projCode)) projCode = hdnProjectCode.Value;

    //        CurrentProjectID = 0;
    //        LastSavedStep = 0;
    //        hdnCurrentStep.Value = "1";

    //        string modeLabel = mode == "active" ? "Published" :
    //                           mode == "upcoming" ? "Scheduled" : "Draft Saved";
    //        string modeIcon = mode == "active" ? "fa-rocket" :
    //                           mode == "upcoming" ? "fa-calendar-check" : "fa-file-pen";
    //        string modeColor = mode == "active" ? "#16A34A" :
    //                           mode == "upcoming" ? "#1D4ED8" : "#92400E";
    //        string modeMsg = mode == "active"
    //            ? "Project ab customers aur agents ke liye live hai."
    //            : (mode == "upcoming"
    //                ? "Project scheduled hai — launch date pe live hoga."
    //                : "Draft save ho gaya hai.");

    //        ScriptManager.RegisterStartupScript(this, GetType(), "publishOK",
    //            string.Format("showPublishSuccess('{0}','{1}','{2}','{3}','{4}','{5}');",
    //                projName.Replace("'", "\\'"),
    //                projCode.Replace("'", "\\'"),
    //                modeLabel, modeIcon, modeColor,
    //                modeMsg.Replace("'", "\\'")), true);
    //    }
    //    catch (Exception ex) { ShowToast("Error: " + ex.Message, "error"); }
    //}

    private bool ValidateStep1Silent()
    {
        return !string.IsNullOrWhiteSpace(txtProjectName.Text);
    }

    protected void btnSaveDraft_Click(object sender, EventArgs e)
    {
        if (CurrentProjectID == 0 && !string.IsNullOrWhiteSpace(txtProjectName.Text))
            btnSaveStep1_Click(sender, e);
        else
            ShowToast("Draft saved!", "info");
    }

    // ─────────────────────────────────────────────
    //  MODEL BUILDERS
    // ─────────────────────────────────────────────
    private ProjectModel BuildStep1Model()
    {
        var p = new ProjectModel();
        p.ProjectID = CurrentProjectID;
        p.ProjectName = txtProjectName.Text.Trim();

        // ← Hidden field se lena — ReadOnly textbox postback pe blank aata hai
        p.ProjectCode = !string.IsNullOrEmpty(hdnProjectCode.Value)
                            ? hdnProjectCode.Value.Trim()
                            : txtProjectCode.Text.Trim();

        p.DeveloperName = txtDeveloperName.Text.Trim();

        int projTypeID = 0;
        int.TryParse(ddlProjectType.SelectedValue, out projTypeID);
        p.ProjectTypeID = projTypeID;

        p.CategoryID = null;
        int catID = 0;
        if (int.TryParse(ddlCategory.SelectedValue, out catID) && catID > 0) p.CategoryID = catID;

        p.RERANumber = txtRERA.Text.Trim();
        p.ShortDescription = txtDescription.Text.Trim();
        p.KhasraPlotNo = txtKhasra.Text.Trim();
        p.FullAddress = txtAddress.Text.Trim();
        p.Landmark = txtLandmark.Text.Trim();
        p.City = txtCity.Text.Trim();
        p.District = txtDistrict.Text.Trim();

        int stateID = 0;
        int.TryParse(ddlState.SelectedValue, out stateID);
        p.StateID = stateID;

        p.PinCode = txtPinCode.Text.Trim();
        p.ZoneSector = txtZone.Text.Trim();

        // ← Hidden fields se lat/lng lena (ReadOnly textbox ka value nahi milta)
        p.Latitude = !string.IsNullOrEmpty(hdnLatitude.Value) ? ToDecimal(hdnLatitude.Value) : ToDecimal(txtLatitude.Text);
        p.Longitude = !string.IsNullOrEmpty(hdnLongitude.Value) ? ToDecimal(hdnLongitude.Value) : ToDecimal(txtLongitude.Text);

        p.GoogleMapsLink = txtGoogleMaps.Text.Trim();
        p.LaunchDate = ToDate(txtLaunchDate.Text);
        p.ConstructionStart = ToDate(txtConstructionStart.Text);

        DateTime possDate;
        p.PossessionDate = DateTime.TryParse(txtPossessionDate.Text, out possDate)
                                ? possDate : DateTime.MinValue;

        p.BookingOpenDate = ToDate(txtBookingOpenDate.Text);

        int statusID = 0;
        int.TryParse(ddlStatus.SelectedValue, out statusID);
        p.StatusID = statusID;

        p.ApprovalAuthority = txtApprovalAuthority.Text.Trim();

        int branchID = 0;
        int.TryParse(ddlBranch.SelectedValue, out branchID);
        p.BranchID = branchID;

        p.ProjectManager = txtProjectManager.Text.Trim();
        p.SalesHead = txtSalesHead.Text.Trim();
        p.SiteContactPhone = txtSitePhone.Text.Trim();
        p.SiteOfficeAddress = txtSiteAddress.Text.Trim();
        p.SiteOfficeTimings = txtSiteTimings.Text.Trim();
        return p;
    }

    private ProjectModel BuildStep2Model()
    {
        var p = new ProjectModel();
        p.ProjectID = CurrentProjectID;
        p.TotalLandAreaSqYd = ToDecimal(txtLandArea.Text);
        p.TotalBuiltUpSqFt = ToDecimal(txtBuiltUp.Text);
        p.FARApproved = ToDecimal(txtFAR.Text);
        p.TotalFloors = ToInt(txtTotalFloors.Text);
        p.UnitsPerFloor = ToInt(txtUnitsPerFloor.Text);
        p.TotalUnits = ToInt(txtTotalUnits.Text) ?? 0;
        p.OpenGreenAreaPct = ToDecimal(txtGreenArea.Text);
        p.ParkingType = ddlParkingType.SelectedValue;
        p.NumberOfBlocks = ToInt(txtNumBlocks.Text);
        p.BSPRatePerSqFt = ToDecimal(txtBSP.Text);
        p.PLCAmount = ToDecimal(txtPLC.Text);
        p.IFMSAmount = ToDecimal(txtIFMS.Text);
        p.ClubMembershipAmt = ToDecimal(txtClubMembership.Text);
        p.PowerBackupAmt = ToDecimal(txtPowerBackup.Text);
        p.MaintenanceDeposit = ToDecimal(txtMaintDeposit.Text);

        int planID = 0;
        p.PaymentPlanTypeID = int.TryParse(ddlPaymentPlan.SelectedValue, out planID) && planID != 0
                                ? (int?)planID : null;

        p.BookingAmount = ToDecimal(txtBookingAmount.Text);
        p.OnAgreementPct = ToDecimal(txtOnAgreement.Text);
        p.OnPossessionPct = ToDecimal(txtOnPossession.Text);
        p.NumberOfInstallments = ToInt(txtInstallments.Text);
        p.GSTRatePct = ToDecimal(txtGST.Text);
        p.CommissionL1Pct = ToDecimal(txtCommL1.Text);
        p.CommissionL2Pct = ToDecimal(txtCommL2.Text);
        p.CommissionL3Pct = ToDecimal(txtCommL3.Text);
        p.BrokerageCommPct = ToDecimal(txtBrokerage.Text);
        p.CommissionPayout = ddlCommPayout.SelectedValue;
        p.TDSOnCommPct = ToDecimal(txtTDS.Text);
        return p;
    }

    private ProjectModel BuildStep3Model()
    {
        var p = new ProjectModel();
        p.ProjectID = CurrentProjectID;
        p.FlooringType = ddlFlooring.SelectedValue;
        p.KitchenType = ddlKitchen.SelectedValue;
        p.BathroomFixtures = ddlBathroom.SelectedValue;
        p.WindowType = ddlWindowType.SelectedValue;
        p.SpecialFeatures = txtSpecialFeatures.Text.Trim();
        p.IsOnlineBooking = chkOnlineBooking.Checked;
        p.IsShowOnWebsite = chkShowWebsite.Checked;
        p.IsEMICalculator = chkEMICalc.Checked;
        p.IsAgentReferral = chkAgentReferral.Checked;
        p.IsHoldUnitAllowed = chkHoldUnit.Checked;
        p.IsVastuCompliant = chkVastu.Checked;
        return p;
    }

    // ─────────────────────────────────────────────
    //  HELPERS
    // ─────────────────────────────────────────────
    public class BlockJsonDTO
    {
        public string BlockName { get; set; }
        public int Floors { get; set; }
        public int UPF { get; set; }
        public string Category { get; set; }
        public List<BhkJsonDTO> BhkTypes { get; set; }
    }

    public class BhkJsonDTO
    {
        public int typeID { get; set; }
        public int count { get; set; }
    }

    private void SaveBlocksFromJSON(string json)
    {
        if (string.IsNullOrWhiteSpace(json) || json == "[]") return;
        try
        {
            var js = new JavaScriptSerializer();
            js.MaxJsonLength = int.MaxValue;
            var parsed = js.Deserialize<List<BlockJsonDTO>>(json);
            if (parsed == null || parsed.Count == 0) return;

            var blocks = new List<ProjectBlockModel>();
            foreach (var b in parsed)
            {
                var block = new ProjectBlockModel
                {
                    BlockName = b.BlockName ?? "Block",
                    NumberOfFloors = b.Floors,
                    UnitsPerFloor = b.UPF,
                    BlockCategory = b.Category ?? "Standard",
                    BhkTypes = new List<BhkTypeModel>()
                };
                if (b.BhkTypes != null)
                {
                    foreach (var t in b.BhkTypes)
                        if (t.count > 0)
                            block.BhkTypes.Add(new BhkTypeModel
                            {
                                TypeID = t.typeID,
                                UnitCount = t.count
                            });
                }
                blocks.Add(block);
            }
            _projectDAL.SaveBlocks(CurrentProjectID, blocks, CurrentUser);
        }
        catch (Exception ex)
        {
            ShowToast("Blocks save error: " + ex.Message, "error");
        }
    }

    //private void SaveBlocksFromJSON(string json)
    //{
    //    var blocks = new List<ProjectBlockModel>();
    //    json = json.Trim().TrimStart('[').TrimEnd(']');
    //    foreach (string item in json.Split(new string[] { "},{" }, StringSplitOptions.RemoveEmptyEntries))
    //    {
    //        string clean = item.Replace("{", "").Replace("}", "").Replace("\"", "");
    //        var dict = new Dictionary<string, string>();
    //        foreach (string pair in clean.Split(','))
    //        { string[] kv = pair.Split(':'); if (kv.Length == 2) dict[kv[0].Trim()] = kv[1].Trim(); }
    //        blocks.Add(new ProjectBlockModel
    //        {
    //            BlockName = dict.ContainsKey("BlockName") ? dict["BlockName"] : "Block",
    //            NumberOfFloors = dict.ContainsKey("Floors") ? ToInt(dict["Floors"]) : null,
    //            UnitsPerFloor = dict.ContainsKey("UPF") ? ToInt(dict["UPF"]) : null,
    //            BlockCategory = dict.ContainsKey("Category") ? dict["Category"] : "Standard"
    //        });
    //    }
    //    if (blocks.Count > 0) _projectDAL.SaveBlocks(CurrentProjectID, blocks, CurrentUser);
    //}

    private void SaveUnitTypesFromJSON(string json)
    {
        var units = new List<ProjectUnitTypeModel>();
        json = json.Trim().TrimStart('[').TrimEnd(']');
        foreach (string item in json.Split(new string[] { "},{" }, StringSplitOptions.RemoveEmptyEntries))
        {
            string clean = item.Replace("{", "").Replace("}", "").Replace("\"", "");
            var dict = new Dictionary<string, string>();
            foreach (string pair in clean.Split(','))
            { string[] kv = pair.Split(':'); if (kv.Length == 2) dict[kv[0].Trim()] = kv[1].Trim(); }
            units.Add(new ProjectUnitTypeModel
            {
                UnitTypeID = dict.ContainsKey("UnitTypeID") ? (ToInt(dict["UnitTypeID"]) ?? 0) : 0,
                SuperAreaSqFt = dict.ContainsKey("Super") ? (ToDecimal(dict["Super"]) ?? 0) : 0,
                CarpetAreaSqFt = dict.ContainsKey("Carpet") ? ToDecimal(dict["Carpet"]) : null,
                NumberOfUnits = dict.ContainsKey("Count") ? (ToInt(dict["Count"]) ?? 0) : 0,
                BSPPerSqFt = dict.ContainsKey("BSP") ? ToDecimal(dict["BSP"]) : null,
                PLCAmount = dict.ContainsKey("PLC") ? ToDecimal(dict["PLC"]) : null
            });
        }
        if (units.Count > 0) _projectDAL.SaveUnitTypes(CurrentProjectID, units, CurrentUser);
    }

    // ─────────────────────────────────────────────
    //  IMAGE COMPRESSION SETTINGS
    //  Gallery  : max 1200px wide, JPEG 75% quality
    //  Cover    : max 1600px wide, JPEG 80% quality
    //  Logo     : max  600px wide, JPEG 85% quality
    //  Documents: as-is (no compression — PDF/etc.)
    // ─────────────────────────────────────────────
    private static readonly string[] _imgExts =
        { ".jpg", ".jpeg", ".png", ".webp", ".gif", ".bmp" };

    private string SaveFile(HttpPostedFile file, string folder, string prefix)
    {
        string ext = Path.GetExtension(file.FileName).ToLower();
        string fn = prefix + "_" + DateTime.Now.Ticks + ".jpg";
        string outPath = Path.Combine(folder, fn);

        // Images compress karke save karo
        if (_imgExts.Contains(ext))
        {
            int maxW = prefix.StartsWith("cover") ? 1600 : 600;  // cover=1600, logo=600
            int quality = prefix.StartsWith("cover") ? 80 : 85;
            CompressAndSaveImage(file.InputStream, outPath, maxW, quality);
        }
        else
        {
            // Document files (PDF etc.) — as-is save karo
            fn = prefix + "_" + DateTime.Now.Ticks + ext;
            outPath = Path.Combine(folder, fn);
            file.SaveAs(outPath);
        }
        return "~/Uploads/Projects/" + CurrentProjectID + "/" + fn;
    }

    private void UploadDoc(FileUpload fu, int docTypeID, string folder)
    {
        if (!fu.HasFile) return;
        _projectDAL.SaveDocument(new ProjectDocumentModel
        {
            ProjectID = CurrentProjectID,
            DocTypeID = docTypeID,
            FileName = fu.FileName,
            FilePath = SaveFile(fu.PostedFile, folder, "doc" + docTypeID),
            FileSize = fu.PostedFile.ContentLength,
            MimeType = fu.PostedFile.ContentType,
            UploadedBy = CurrentUser
        });
    }

    private decimal? ToDecimal(string s) { decimal d; return decimal.TryParse(s == null ? "" : s.Trim(), out d) ? d : (decimal?)null; }
    private int? ToInt(string s) { int i; return int.TryParse(s == null ? "" : s.Trim(), out i) ? i : (int?)null; }
    private DateTime? ToDate(string s) { DateTime d; return DateTime.TryParse(s == null ? "" : s.Trim(), out d) ? d : (DateTime?)null; }

    private bool IsBackPending()
    {
        string goBack = "";
        foreach (string key in Request.Form.AllKeys)
        {
            if (key != null && key.Contains("hdnGoBackToStep")) { goBack = Request.Form[key]; break; }
        }
        int targetStep = 0;
        int.TryParse(goBack, out targetStep);
        return targetStep > 0;
    }

    private void NavigateBack()
    {
        string goBack = "";
        foreach (string key in Request.Form.AllKeys)
        {
            if (key != null && key.Contains("hdnGoBackToStep")) { goBack = Request.Form[key]; break; }
        }
        int targetStep = 0;
        if (!int.TryParse(goBack, out targetStep) || targetStep <= 0)
            targetStep = Math.Max(1, LastSavedStep);

        if (CurrentProjectID > 0)
        {
            BindAllDropdowns();
            LoadProjectIntoForm(CurrentProjectID);
        }

        // ▼ Server step set karo — JS window.load pe is step pe land karega
        hdnCurrentStep.Value = targetStep.ToString();

        ScriptManager.RegisterStartupScript(this, GetType(), "navback_" + DateTime.Now.Ticks,
            string.Format(
                "lastSavedStep={0}; currentProjectID={1};",
                LastSavedStep, CurrentProjectID), true);
    }

    private List<int> ParseIDs(string csv)
    {
        var list = new List<int>();
        if (string.IsNullOrEmpty(csv)) return list;
        foreach (string part in csv.Split(','))
        { int id; if (int.TryParse(part.Trim(), out id) && id > 0) list.Add(id); }
        return list;
    }

    private void ShowToast(string msg, string type)
    {
        msg = msg.Replace("'", "\\'");
        ScriptManager.RegisterStartupScript(this, GetType(), "toast_" + DateTime.Now.Ticks,
            string.Format("showToast('{0}','{1}');", msg, type), true);
    }

    protected void BtnBackTDashboard_Click(object sender, EventArgs e)
    {
        Response.Redirect("Dashboard.aspx");
    }
}


