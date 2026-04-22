using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ComplainSolution : System.Web.UI.Page
{
    private DAL ObjDal = new DAL();
    private DataTable dt;
    private string str = "";
    private string query;
    private string constr1 = ConfigurationManager.ConnectionStrings["constr1"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Status"] != null && Session["Status"].ToString() == "OK")
            {
                // Session valid
            }
            else
            {
                Response.Redirect("logout.aspx");
            }

            if (Session["Status"].ToString() != "OK")
            {
                Response.Redirect("logout.aspx");
            }

            if (!Page.IsPostBack)
            {
                Session["DtFillDetail"] = null;
                FillDetail();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                "alert('" + ex.Message.Replace("'", "\\'") + "')", true);
        }
    }

    private void FillDetail()
    {
        try
        {
            DataSet ds = new DataSet();

            if (Session["DtFillDetail"] == null)
            {
                query  = ObjDal.Isostart;
                query += "Select M.IDNo,M.CID,Cast(M.CID as varchar) as VCId,M.MemName,";
                query += "ISNULL(Replace(CONVERT(varchar,M.RecTimeStamp,106),' ','-'),'') as CDate,";
                query += "M.CType,M.Complaint,";
                query += "ISNULL(S.Solution,'') as Solution,";
                query += "ISNULL(Replace(CONVERT(varchar,S.RecTimeStamp,106),' ','-'),'') as SDate FROM";
                query += " (Select b.MemFirstName +' '+ b.MemLastName as MemName,";
                query += " a.* FROM " + ObjDal.dBName + "..M_ComplaintMaster as a,";
                query += ObjDal.dBName + "..M_MemberMaster as b WHERE a.IDNo=b.IDNo";
                query += " AND a.IDNo='" + Session["IDNo"] + "') as M";
                query += " LEFT JOIN " + ObjDal.dBName + "..M_SolutionMaster as S ON M.CID=S.CID";
                query += " WHERE 1=1 ORDER BY M.RecTimeStamp DESC" + ObjDal.IsoEnd;

                ds = SqlHelper.ExecuteDataset(constr1, CommandType.Text, query);
                Session["DtFillDetail"] = ds;
            }
            else
            {
                ds = (DataSet)Session["DtFillDetail"];
            }

            dt = ds.Tables[0];
            Session["DirectData1"] = dt;

            // ── KPI Counts ─────────────────────────────────────
            int total   = dt.Rows.Count;
            int replied = 0;
            int pending = 0;

            foreach (DataRow dr in dt.Rows)
            {
                if (dr["Solution"].ToString().Trim() != "")
                    replied++;
                else
                    pending++;
            }

            SpnTotal.InnerText   = total.ToString();
            SpnReplied.InnerText = replied.ToString();
            SpnPending.InnerText = pending.ToString();
            // ───────────────────────────────────────────────────

            RptDirects.DataSource = dt;
            RptDirects.DataBind();
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    protected void RptDirects_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            FillDetail();
            RptDirects.PageIndex = e.NewPageIndex;
            RptDirects.DataBind();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                "alert('" + ex.Message.Replace("'", "\\'") + "')", true);
        }
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        try { }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage",
                "alert('" + ex.Message.Replace("'", "\\'") + "')", true);
        }
    }

    protected void Page_Unload(object sender, EventArgs e)
    {
        try { }
        catch (Exception ex)
        {
            // Unload mein ScriptManager kaam nahi karta
        }
    }
}
