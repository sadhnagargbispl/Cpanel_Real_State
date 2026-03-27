using System;
using System.Data;
using System.Web;
using System.Web.UI;

public partial class Img : System.Web.UI.Page
{
    public string FormNo;
    clsGeneral objGen = new clsGeneral();

    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dt;
        DAL obj = new DAL();

        string type = Request["Type"];
        FormNo = Request["ID"];

        int idVal = 0;
        int.TryParse(Convert.ToString(Request["ID"]), out idVal);

        if (string.Equals(type, "ad", StringComparison.OrdinalIgnoreCase))
        {
            string sql = "select '" + Convert.ToString(Session["AdminWeb"]) + "/images/UploadImage/' + ImgPath as Img1Path from M_AdvertiseMaster where AdID='" + idVal.ToString() + "'";
            dt = obj.GetData(sql);
            if (dt.Rows.Count > 0)
                Image1.ImageUrl = dt.Rows[0]["Img1Path"].ToString();
        }
        else if (string.Equals(type, "Payment", StringComparison.OrdinalIgnoreCase))
        {
            string sql = "select Case when ScannedFile='' then ''  " +
                           " else 'images/UploadImage/'+'" + Session["compid"] + "/' + ScannedFile end as  ImagePath from WalletReq where ReqNo='" + idVal.ToString() + "'";
            dt = obj.GetData(sql);
            if (dt.Rows.Count > 0)
                Image1.ImageUrl = dt.Rows[0]["ImagePath"].ToString();
        }
    

        else if (string.Equals(type, "front", StringComparison.OrdinalIgnoreCase))
        {
            string sql = "select AddrProof as ImagePath from KycVerify where formno = '" + idVal.ToString() + "'";
            dt = obj.GetData(sql);
            if (dt.Rows.Count > 0)
                Image1.ImageUrl = dt.Rows[0]["ImagePath"].ToString();
        }
        else if (string.Equals(type, "back", StringComparison.OrdinalIgnoreCase))
        {
            string sql = "select BackAddressProof as ImagePath from KycVerify where formno = '" + idVal.ToString() + "'";
            dt = obj.GetData(sql);
            if (dt.Rows.Count > 0)
                Image1.ImageUrl = dt.Rows[0]["ImagePath"].ToString();
        }
        else if (string.Equals(type, "bank", StringComparison.OrdinalIgnoreCase))
        {
            string sql = "select BankProof as ImagePath from KycVerify where formno = '" + idVal.ToString() + "'";
            dt = obj.GetData(sql);
            if (dt.Rows.Count > 0)
                Image1.ImageUrl = dt.Rows[0]["ImagePath"].ToString();
        }
        else if (string.Equals(type, "pan", StringComparison.OrdinalIgnoreCase))
        {
            string sql = "select PanImg as ImagePath from KycVerify where formno = '" + idVal.ToString() + "'";
            dt = obj.GetData(sql);
            if (dt.Rows.Count > 0)
                Image1.ImageUrl = dt.Rows[0]["ImagePath"].ToString();
        }
        else if (type != null)
        {
            // intentionally left blank to mirror original VB branch
        }
        else
        {
            // Image1.ImageUrl = "ImgHandler.ashx?id=" + Request["ID"];
        }
    }
}
