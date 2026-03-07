using AjaxControlToolkit.HtmlEditor.ToolbarButtons;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ProfilePage : System.Web.UI.Page
{
    double _dblAvailLeg = 0;
    private clsGeneral dbGeneral = new clsGeneral();
    private cls_DataAccess dbConnect;
    private SqlCommand cmd = new SqlCommand();
    private SqlDataReader dRead;
    private string strQuery, strCaptcha;
    DataTable tmpTable = new DataTable();
    // AccClass.MyAccClass.NewClass QryCls = new AccClass.MyAccClass.NewClass();
    int minSpnsrNoLen, minScrtchLen;
    double Upln, dblSpons, dblTehsil, dblDistrict, dblIdNo;
    DateTime CurrDt;
    string[] montharray = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
                        "Aug", "Sep", "Oct", "Nov", "Dec" };
    int LastInsertID = 0;
    string scrname;
    DAL Obj;
    clsGeneral objGen = new clsGeneral();
    private string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;
    private string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] == null || Session["Status"].ToString() != "OK")
            {
                Response.Redirect("Logout.aspx");
            }

            if (!Page.IsPostBack)
            {
                Fill_State();
                FillDetail();
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") +
                          Environment.NewLine;

            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private void Fill_State()
    {
        try
        {
            Obj = new DAL();
            DataTable dtMaster = new DataTable();

            string str = Obj.Isostart + "Select StateCode, StateName from " + Obj.dBName + "..M_StateDivMaster Where ActiveStatus = 'Y' And RowStatus = 'Y' Order by StateName" + Obj.IsoEnd;
            dtMaster = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];
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
    private string ConvertDateToString(string Month)
    {
        try
        {
            switch (Month)
            {
                case "1":
                    return "JAN";
                case "2":
                    return "FEB";
                case "3":
                    return "Mar";
                case "4":
                    return "Apr";
                case "5":
                    return "May";
                case "6":
                    return "Jun";
                case "7":
                    return "Jul";
                case "8":
                    return "Aug";
                case "9":
                    return "Sep";
                case "10":
                    return "Oct";
                case "11":
                    return "Nov";
                case "12":
                    return "Dec";
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff")
                          + Environment.NewLine;

            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }

        return string.Empty;
    }
    private void FindSession()
    {
        try
        {
            // cmd object
            cmd = new SqlCommand(
               Obj.Isostart + "Select Top 1 SessID, ToDate, FrmDate from " + Obj.dBName + "..M_SessnMaster order by SessID desc" + Obj.IsoEnd,
                dbConnect.cnnObject);

            dRead = cmd.ExecuteReader();

            if (dRead.Read())
            {
                Session["SessID"] = dRead["SessID"];

                // If needed in future:
                // Session["ToDate"] = Convert.ToDateTime(dRead["ToDate"]).ToString("dd-MMM-yyyy");
                // Session["FrmDate"] = Convert.ToDateTime(dRead["FrmDate"]).ToString("dd-MMM-yyyy");
                // Session["CurrDate"] = DateTime.Now.ToString("dd-MMM-yyyy");
            }
            else
            {
                return; // EXIT SUB equivalent
            }

            dRead.Close();
            cmd.Cancel();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff")
                          + Environment.NewLine;

            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private string ClearInject(string StrObj)
    {
        try
        {
            StrObj = StrObj.Replace(";", "")
                           .Replace("'", "")
                           .Replace("=", "");

            return StrObj.Trim();
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff")
                          + Environment.NewLine;

            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }

        return string.Empty;
    }
    private void UpdateDb()
    {
        try
        {
            //if (Session["Sessncheck"].ToString().ToUpper() !=
            //    ("OK" + Crypto.Decrypt(hdnSessn.Value).ToString().ToUpper()))
            //{
            //    ScriptManager.RegisterStartupScript(
            //        this,
            //        this.GetType(),
            //        "Key",
            //        "alert('Session expire, Please Re-Login.!!');location.replace('logout.aspx');",
            //        true
            //    );
            //    return;
            //}

            Obj = new DAL();

            string strQry, strFld, strFldVal;
            DateTime strDOB;
            string Remark = "";
            string MembName = "";
            string Password = "";
            string TransactionPassword = "";

            try
            {
                string str = "";
                DataTable Dt1 = new DataTable();

                try
                {
                    strDOB = Convert.ToDateTime(TxtDobDate.Text);
                }
                catch
                {
                    strDOB = DateTime.Now;
                }

                if (ddlPostSate.SelectedValue == "0")
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        this.GetType(),
                        "Key",
                        "alert('Please select state!!');",
                        true
                    );
                    return;
                }

                txtPhNo.Text = (txtPhNo.Text == "" ? "0" : txtPhNo.Text);

                string MemNameInput = txtFrstNm.Text.Trim();

                str = Obj.Isostart + "select * from " + Obj.dBName + "..M_MemberMaster where Formno = '" + Session["Formno"] + "'" + Obj.IsoEnd;
                Dt1 = SqlHelper.ExecuteDataset(constr1, CommandType.Text, str).Tables[0];

                if (Dt1.Rows.Count > 0)
                {
                    MembName = Dt1.Rows[0]["MemFirstName"] + " " + Dt1.Rows[0]["MemLastName"];
                    Password = Dt1.Rows[0]["Passw"].ToString();
                    TransactionPassword = Dt1.Rows[0]["EPassw"].ToString();

                    // Change Logs
                    if (ClearInject(Dt1.Rows[0]["MemfirstName"].ToString()) != ClearInject(MemNameInput))
                    {
                        Remark += "MemberName Changed From " + ClearInject(Dt1.Rows[0]["MemfirstName"].ToString()) +
                                  " to " + ClearInject(MemNameInput) + ",";
                    }

                    if (Convert.ToDateTime(Dt1.Rows[0]["MemDob"]) != strDOB)
                    {
                        Remark += "Dob Changed From " + ClearInject(Dt1.Rows[0]["MemDob"].ToString()) +
                                  " to " + strDOB + ",";
                    }

                    if (ClearInject(Dt1.Rows[0]["PhN1"].ToString()) != ClearInject(txtPhNo.Text))
                    {
                        Remark += " PhoneNo Changed From " + ClearInject(Dt1.Rows[0]["PhN1"].ToString()) +
                                  " to " + ClearInject(txtPhNo.Text) + ",";
                    }

                    if (ClearInject(Dt1.Rows[0]["Mobl"].ToString()) != ClearInject(txtMobileNo.Text))
                    {
                        Remark += " MobileNo Changed From " + ClearInject(Dt1.Rows[0]["Mobl"].ToString()) +
                                  " to " + ClearInject(txtMobileNo.Text.Trim()) + ",";
                    }

                    if (ClearInject(Dt1.Rows[0]["Email"].ToString()) != ClearInject(txtEMailId.Text))
                    {
                        Remark += " Email Changed From " + ClearInject(Dt1.Rows[0]["Email"].ToString()) +
                                  " to " + ClearInject(txtEMailId.Text) + ",";
                    }

                    if (ClearInject(Dt1.Rows[0]["NomineeName"].ToString()) != ClearInject(txtNominee.Text))
                    {
                        Remark += " NomineeName Changed From " + ClearInject(Dt1.Rows[0]["NomineeName"].ToString()) +
                                  " to " + ClearInject(txtNominee.Text) + ",";
                    }

                    if (ClearInject(Dt1.Rows[0]["Relation"].ToString()) != ClearInject(txtRelation.Text))
                    {
                        Remark += " Relation Changed From " + ClearInject(Dt1.Rows[0]["Relation"].ToString()) +
                                  " to " + ClearInject(txtRelation.Text) + ",";
                    }

                    if (ClearInject(Dt1.Rows[0]["Address1"].ToString()) != ClearInject(TxtPostalAddress.Text))
                    {
                        Remark += " PostalAddress Changed From " + ClearInject(Dt1.Rows[0]["Address1"].ToString()) +
                                  " to " + ClearInject(TxtPostalAddress.Text) + ",";
                    }

                    if (ClearInject(Dt1.Rows[0]["PinCode"].ToString()) != ClearInject(TxtPostPincode.Text))
                    {
                        Remark += " PinCode Changed From " + ClearInject(Dt1.Rows[0]["PinCode"].ToString()) +
                                  " to " + ClearInject(TxtPostPincode.Text) + ",";
                    }

                    if (ClearInject(Dt1.Rows[0]["District"].ToString()) != ClearInject(TxtPostDistrict.Text))
                    {
                        Remark += " District Changed From " + ClearInject(Dt1.Rows[0]["District"].ToString()) +
                                  " to " + ClearInject(TxtPostDistrict.Text) + ",";
                    }

                    if (ClearInject(Dt1.Rows[0]["City"].ToString()) != ClearInject(TxtPostCity.Text))
                    {
                        Remark += " City Changed From " + ClearInject(Dt1.Rows[0]["City"].ToString()) +
                                  " to " + ClearInject(TxtPostCity.Text) + ",";
                    }

                    if (Dt1.Rows[0]["Statecode"].ToString() != ddlPostSate.SelectedItem.Text.ToString())
                    {
                        Remark += " State Changed From " + Dt1.Rows[0]["Statecode"] +
                                  " to " + ddlPostSate.SelectedItem.Text + ",";
                    }
                }

                strQry = "Update M_MemberMaster Set MemfirstName='" +
                             ClearInject(txtFrstNm.Text.ToUpper()) + "',Prefix='" +
                             ddlPreFix.SelectedValue + "',MemFName='" +
                             ClearInject(txtFNm.Text.ToUpper()) + "',MemDOB='" +
                             strDOB.ToString("dd-MMM-yyyy") + "',PhN1='" +
                             ClearInject(txtPhNo.Text) + "',Mobl='" +
                             ClearInject(txtMobileNo.Text) + "',EMail='" +
                             ClearInject(txtEMailId.Text) + "',NomineeName='" +
                             ClearInject(txtNominee.Text.ToUpper()) + "',Relation='" +
                             ClearInject(txtRelation.Text.ToUpper()) +
                             "',DeliveryAddress='" + TxtPostalAddress.Text.ToUpper() +
                             "',Address1='" + TxtPostalAddress.Text.ToUpper() +
                             "',pincode='" + TxtPostPincode.Text.ToUpper() +
                             "',District='" + TxtPostDistrict.Text.ToUpper() +
                             "',City='" + TxtPostCity.Text.ToUpper() + "',StateCode='" + ddlPostSate.SelectedValue +
                             "' Where FormNo=" + Session["FormNo"];
                // Insert History
                string Qry = " insert into UserHistory(UserId,UserName,PageName,Activity,ModifiedFlds,RecTimeStamp,MemberId)Values " +
                       "(0,'" + Session["MemName"] + "','Profile','Profile Update','" +
                       Remark + "',Getdate(),'" + Session["FormNo"] + "') ";

                Qry += strQry;

                int i = Obj.SaveData(Qry);

                if (i != 0)
                    scrname = "<SCRIPT>alert('Profile Successfully Updated');</SCRIPT>";
                else
                    scrname = "<SCRIPT>alert('Try Again Later.');</SCRIPT>";

                this.RegisterStartupScript("MyAlert", scrname);

                FillDetail();
                return;
            }
            catch (Exception e)
            {
                scrname = "<SCRIPT>alert('" + e.Message + "');</SCRIPT>";
                this.RegisterStartupScript("MyAlert", scrname);
                dbGeneral.myMsgBx(e.Message);
                return;
            }
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") + Environment.NewLine;
            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    private void FillDetail()
    {
        try
        {
            string idverified = "";
            Obj = new DAL();
            string sql = Obj.Isostart + "exec sp_MemDtl ' and mMst.Formno=''" + Session["Formno"] + "''' " + Obj.IsoEnd;
            DataTable dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql).Tables[0];

            if (dt.Rows.Count > 0)
            {
                txtReferalId.Text = dt.Rows[0]["RefIDNo"] == DBNull.Value ? "" : dt.Rows[0]["RefIDNo"].ToString();
                TxtReferalNm.Text = dt.Rows[0]["RefName"].ToString();

                TxtUplinerid.Text = dt.Rows[0]["UpLnIDNo"] == DBNull.Value ? "" : dt.Rows[0]["UpLnIDNo"].ToString();
                TxtUplinerName.Text = dt.Rows[0]["UpLnName"].ToString();

                txtFrstNm.Text = dt.Rows[0]["MemName"].ToString();
                txtFNm.Text = dt.Rows[0]["MemFname"].ToString();

                TxtDobDate.Text = Convert.ToDateTime(dt.Rows[0]["MemDob"]).ToString("dd-MMM-yyyy");

                hdnSessn.Value = Crypto.Encrypt(dt.Rows[0]["idno"].ToString());

                txtPhNo.Text = dt.Rows[0]["PhN1"].ToString();
                txtMobileNo.Text = dt.Rows[0]["Mobl"].ToString();
                txtEMailId.Text = dt.Rows[0]["EMail"].ToString();
                txtNominee.Text = dt.Rows[0]["NomineeName"].ToString();
                txtRelation.Text = dt.Rows[0]["Relation"].ToString();

                TxtPostalAddress.Text = dt.Rows[0]["Address1"].ToString();
                TxtPostPincode.Text = dt.Rows[0]["Pincode"].ToString();
                ddlPostSate.SelectedValue = dt.Rows[0]["StateCode"].ToString();

                TxtPostDistrict.Text = dt.Rows[0]["District"] == DBNull.Value ? "" : dt.Rows[0]["District"].ToString();
                TxtPostDistrict.Enabled = string.IsNullOrEmpty(TxtPostDistrict.Text);

                TxtPostCity.Text = dt.Rows[0]["City"] == DBNull.Value ? "" : dt.Rows[0]["City"].ToString();
                TxtPostCity.Enabled = string.IsNullOrEmpty(TxtPostCity.Text);

                if (string.IsNullOrEmpty(dt.Rows[0]["Address1"].ToString()))
                {
                    TxtPostalAddress.Enabled = true;
                }
                else
                {
                    TxtPostalAddress.Enabled = false;
                }

                if (dt.Rows[0]["StateCode"] == DBNull.Value || ddlPostSate.SelectedValue == "0")
                {
                    ddlPostSate.Enabled = true;
                }
                else
                {
                    ddlPostSate.Enabled = false;
                }

                TxtPostPincode.Enabled = string.IsNullOrEmpty(TxtPostPincode.Text);
                txtFNm.Enabled = string.IsNullOrEmpty(txtFNm.Text);

                if (TxtDobDate.Text == "01-Jan-1900" || TxtDobDate.Text == "01-Jan-1940")
                {
                    TxtDobDate.Text = "";
                    TxtDobDate.Enabled = true;
                }
                else
                {
                    TxtDobDate.Enabled = false;
                }

                if (string.IsNullOrEmpty(dt.Rows[0]["PhN1"].ToString()))
                {
                    txtPhNo.Enabled = true;
                }
                else
                {
                    txtPhNo.Enabled = false;
                }

                txtEMailId.Enabled = string.IsNullOrEmpty(txtEMailId.Text);
                txtNominee.Enabled = string.IsNullOrEmpty(txtNominee.Text);
                txtRelation.Enabled = string.IsNullOrEmpty(txtRelation.Text);

                CmbType.Enabled = string.IsNullOrEmpty(CmbType.SelectedValue);

                ddlPreFix.Text = dt.Rows[0]["Prefix"].ToString();
                if (dt.Rows[0]["Prefix"] == DBNull.Value)
                {
                    ddlPreFix.Text = "";
                    ddlPreFix.Enabled = true;
                }
                else
                {
                    ddlPreFix.Enabled = false;
                }

                if (txtPhNo.Text == "0")
                {
                    txtPhNo.Enabled = true;
                }
                else
                {
                    txtPhNo.Enabled = false;
                }

                if (txtMobileNo.Text == "0")
                {
                    txtMobileNo.Enabled = true;
                }
                else
                {
                    txtMobileNo.Enabled = false;
                }

                // -------- BUTTON LOGIC --------

                if (!string.IsNullOrEmpty(txtFrstNm.Text) &&
                    !string.IsNullOrEmpty(txtMobileNo.Text) && 
                    !string.IsNullOrEmpty(txtPhNo.Text) &&
                    !string.IsNullOrEmpty(TxtPostalAddress.Text))
                {
                    CmdSave.Visible = false; // detail filled hai
                }
                else
                {
                    CmdSave.Visible = true;  // detail empty hai
                }
            }
            else
            {
                CmdSave.Visible = true;
            }
            //string sql = Obj.Isostart + "exec sp_MemDtl ' and mMst.Formno=''" + Session["Formno"] + "''' " + Obj.IsoEnd;
            //DataTable dt = SqlHelper.ExecuteDataset(constr1, CommandType.Text, sql).Tables[0];
            //if (dt.Rows.Count > 0)
            //{
            //    //Divcardno.Visible = false;

            //    txtReferalId.Text = dt.Rows[0]["RefIDNo"] == DBNull.Value ? "" : dt.Rows[0]["RefIDNo"].ToString();
            //    TxtReferalNm.Text = dt.Rows[0]["RefName"].ToString();

            //    TxtUplinerid.Text = dt.Rows[0]["UpLnIDNo"] == DBNull.Value ? "" : dt.Rows[0]["UpLnIDNo"].ToString();
            //    TxtUplinerName.Text = dt.Rows[0]["UpLnName"].ToString();

            //    txtFrstNm.Text = dt.Rows[0]["MemName"].ToString();
            //    //lblPosition.Text = (dt.Rows[0]["LegNo"].ToString() == "1") ? "Left" : "Right";

            //    txtFNm.Text = dt.Rows[0]["MemFname"].ToString();
            //    TxtDobDate.Text = Convert.ToDateTime(dt.Rows[0]["MemDob"]).ToString("dd-MMM-yyyy");

            //    hdnSessn.Value = Crypto.Encrypt(dt.Rows[0]["idno"].ToString());

            //    txtPhNo.Text = dt.Rows[0]["PhN1"].ToString();
            //    txtMobileNo.Text = dt.Rows[0]["Mobl"].ToString();
            //    txtEMailId.Text = dt.Rows[0]["EMail"].ToString();
            //    txtNominee.Text = dt.Rows[0]["NomineeName"].ToString();
            //    txtRelation.Text = dt.Rows[0]["Relation"].ToString();

            //    TxtPostalAddress.Text = dt.Rows[0]["Address1"].ToString();

            //    TxtPostPincode.Text = dt.Rows[0]["Pincode"].ToString();
            //    ddlPostSate.SelectedValue = dt.Rows[0]["StateCode"].ToString();

            //    TxtPostDistrict.Text = dt.Rows[0]["District"] == DBNull.Value ? "" : dt.Rows[0]["District"].ToString();
            //    TxtPostDistrict.Enabled = string.IsNullOrEmpty(TxtPostDistrict.Text);

            //    TxtPostCity.Text = dt.Rows[0]["City"] == DBNull.Value ? "" : dt.Rows[0]["City"].ToString();
            //    TxtPostCity.Enabled = string.IsNullOrEmpty(TxtPostCity.Text);

            //    if (string.IsNullOrEmpty(dt.Rows[0]["Address1"].ToString()))
            //    {
            //        TxtPostalAddress.Text = "";
            //        TxtPostalAddress.Enabled = true;
            //    }
            //    else
            //    {
            //        TxtPostalAddress.Text = dt.Rows[0]["Address1"].ToString();
            //        TxtPostalAddress.Enabled = false;
            //    }

            //    if (dt.Rows[0]["StateCode"] == DBNull.Value || ddlPostSate.SelectedValue == "0")
            //    {
            //        ddlPostSate.Text = "";
            //        ddlPostSate.Enabled = true;
            //    }
            //    else
            //    {
            //        ddlPostSate.Text = dt.Rows[0]["StateCode"].ToString();
            //        ddlPostSate.Enabled = false;
            //    }

            //    TxtPostPincode.Enabled = string.IsNullOrEmpty(TxtPostPincode.Text);
            //    // Father Name
            //    txtFNm.Enabled = string.IsNullOrEmpty(txtFNm.Text);

            //    // DOB Enable/Disable
            //    if (TxtDobDate.Text == "01-Jan-1900" || TxtDobDate.Text == "01-Jan-1940")
            //    {
            //        TxtDobDate.Text = "";
            //        TxtDobDate.Enabled = true;
            //    }
            //    else
            //    {
            //        TxtDobDate.Text = Convert.ToDateTime(dt.Rows[0]["MemDob"]).ToString("dd-MMM-yyyy");
            //        TxtDobDate.Enabled = false;
            //    }

            //    // Phone
            //    if (string.IsNullOrEmpty(dt.Rows[0]["PhN1"].ToString()))
            //    {
            //        txtPhNo.Text = "";
            //        txtPhNo.Enabled = true;
            //    }
            //    else
            //    {
            //        txtPhNo.Text = dt.Rows[0]["PhN1"].ToString();
            //        txtPhNo.Enabled = false;
            //    }

            //    // Email
            //    txtEMailId.Enabled = string.IsNullOrEmpty(txtEMailId.Text);

            //    // Nominee
            //    txtNominee.Enabled = string.IsNullOrEmpty(txtNominee.Text);

            //    // Relation
            //    txtRelation.Enabled = string.IsNullOrEmpty(txtRelation.Text);

            //    // Type
            //    CmbType.Enabled = string.IsNullOrEmpty(CmbType.SelectedValue);

            //    // Prefix
            //    ddlPreFix.Text = dt.Rows[0]["Prefix"].ToString();
            //    if (dt.Rows[0]["Prefix"] == DBNull.Value)
            //    {
            //        ddlPreFix.Text = "";
            //        ddlPreFix.Enabled = true;
            //    }
            //    else
            //    {
            //        ddlPreFix.Enabled = false;
            //    }
            //    if (txtPhNo.Text == "0")
            //    {
            //        txtPhNo.Enabled = true;
            //    }
            //    else
            //    {
            //        txtPhNo.Enabled = false;
            //    }
            //    // Mobile
            //    if (txtMobileNo.Text == "0")
            //    {
            //        txtMobileNo.Enabled = true;
            //    }
            //    else
            //    {
            //        txtMobileNo.Enabled = false;
            //    }
            //}
        }
        catch (Exception ex)
        {
            string path = HttpContext.Current.Request.Url.AbsoluteUri;
            string text = path + ":  " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss:fff") +
                          Environment.NewLine;

            Obj.WriteToFile(text + ex.Message);
            Response.Write("Try later.");
        }
    }
    protected void CmdSave_Click(object sender, EventArgs e)
    {
        UpdateDb();
    }
    protected void CmdCancel_Click(object sender, EventArgs e)
    {

    }
}