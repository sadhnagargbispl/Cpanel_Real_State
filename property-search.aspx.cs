using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class property_search : System.Web.UI.Page
{
    string type = "";
    string size = "";
    string location = "";
    string budget = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string encoded = Request.QueryString["q"];

            if (!string.IsNullOrEmpty(encoded))
            {
                string decoded = System.Text.Encoding.UTF8.GetString(
                    Convert.FromBase64String(encoded)
                );

                var query = System.Web.HttpUtility.ParseQueryString(decoded);

                location = query["location"];
                type = query["type"];
                budget = query["budget"];
                size = query["size"];
            }

            BindAllDropdowns();
        }
    }
    public List<ProjectType> GetProjectTypes()
    {
        var list = new List<ProjectType>();

        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT ProjectTypeID, TypeCode, TypeName FROM dbo.MstProjectTypes WHERE IsActive=1 ORDER BY TypeName", con))
        {
            con.Open();

            using (var dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    list.Add(new ProjectType
                    {
                        ProjectTypeID = Convert.ToInt32(dr["ProjectTypeID"]),
                        TypeCode = dr["TypeCode"].ToString(),
                        TypeName = dr["TypeName"].ToString()
                    });
                }
            }
        }

        return list;
    }
    public List<UnitTypeMaster> GetUnitTypes()
    {
        var list = new List<UnitTypeMaster>();

        using (var con = DBHelper.GetConnection())
        using (var cmd = new SqlCommand(
            "SELECT UnitTypeID, UnitTypeName FROM dbo.MstUnitTypes ORDER BY UnitTypeID", con))
        {
            con.Open();

            using (var dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    list.Add(new UnitTypeMaster
                    {
                        UnitTypeID = Convert.ToInt32(dr["UnitTypeID"]),
                        UnitTypeName = dr["UnitTypeName"].ToString()
                    });
                }
            }
        }

        return list;
    }
    private void BindAllDropdowns()
    {
        ddlProjectType.DataSource = GetProjectTypes();

        ddlProjectType.DataTextField = "TypeName";
        ddlProjectType.DataValueField = "ProjectTypeID";
        ddlProjectType.DataBind();

        ddlProjectType.Items.Insert(0, new ListItem("-- Select Type --", "0"));


        ddlPlotSize.DataSource = GetUnitTypes();

        ddlPlotSize.DataTextField = "UnitTypeName";
        ddlPlotSize.DataValueField = "UnitTypeID";
        ddlPlotSize.DataBind();

        ddlPlotSize.Items.Insert(0, new ListItem("-- Select Size --", "0"));


        // restore selected values after binding
        if (!string.IsNullOrEmpty(type))
            ddlProjectType.SelectedValue = type;

        if (!string.IsNullOrEmpty(size))
            ddlPlotSize.SelectedValue = size;
    }
    //public List<ProjectType> GetProjectTypes(string type)
    //{
    //    var list = new List<ProjectType>();

    //    using (var con = DBHelper.GetConnection())
    //    using (var cmd = new SqlCommand(
    //        "SELECT ProjectTypeID, TypeCode, TypeName FROM dbo.MstProjectTypes WHERE IsActive=1 AND ProjectTypeID = @type ORDER BY TypeName", con))
    //    {
    //        cmd.Parameters.AddWithValue("@type", type);

    //        con.Open();

    //        using (var dr = cmd.ExecuteReader())
    //        {
    //            while (dr.Read())
    //            {
    //                list.Add(new ProjectType
    //                {
    //                    ProjectTypeID = Convert.ToInt32(dr["ProjectTypeID"]),
    //                    TypeCode = dr["TypeCode"].ToString(),
    //                    TypeName = dr["TypeName"].ToString()
    //                });
    //            }
    //        }
    //    }

    //    return list;
    //}
    //private void BindAllDropdowns()
    //{
    //    ddlProjectType.DataSource = GetProjectTypes(type);

    //    ddlProjectType.DataTextField = "TypeName";
    //    ddlProjectType.DataValueField = "ProjectTypeID";
    //    ddlProjectType.DataBind();
    //    ddlProjectType.Items.Insert(0, new ListItem("-- Select Type --", "0"));

    //    ddlPlotSize.DataSource = GetUnitTypes(size);

    //    ddlPlotSize.DataTextField = "UnitTypeName";
    //    ddlPlotSize.DataValueField = "UnitTypeID";
    //    ddlPlotSize.DataBind();

    //    ddlPlotSize.Items.Insert(0, new ListItem("-- Select Size --", "0"));


    //    // restore selected values after binding
    //    if (!string.IsNullOrEmpty(type))
    //        ddlProjectType.SelectedValue = type;

    //    if (!string.IsNullOrEmpty(size))
    //        ddlPlotSize.SelectedValue = size;
    //}
    //public List<UnitTypeMaster> GetUnitTypes(string size)
    //{
    //    var list = new List<UnitTypeMaster>();

    //    using (var con = DBHelper.GetConnection())
    //    using (var cmd = new SqlCommand(
    //        "SELECT UnitTypeID, UnitTypeName FROM dbo.MstUnitTypes WHERE UnitTypeID = @type ORDER BY UnitTypeID", con))
    //    {
    //        cmd.Parameters.AddWithValue("@type", size);

    //        con.Open();

    //        using (var dr = cmd.ExecuteReader())
    //        {
    //            while (dr.Read())
    //            {
    //                list.Add(new UnitTypeMaster
    //                {
    //                    UnitTypeID = Convert.ToInt32(dr["UnitTypeID"]),
    //                    UnitTypeName = dr["UnitTypeName"].ToString()
    //                });
    //            }
    //        }
    //    }
    //    //var list = new List<UnitTypeMaster>();
    //    //using (var con = DBHelper.GetConnection())
    //    //using (var cmd = new SqlCommand(
    //    //    "SELECT UnitTypeID, UnitTypeName FROM dbo.MstUnitTypes ORDER BY UnitTypeID", con))
    //    //{
    //    //    con.Open();
    //    //    using (var dr = cmd.ExecuteReader())
    //    //        while (dr.Read())
    //    //            list.Add(new UnitTypeMaster
    //    //            {
    //    //                UnitTypeID = Convert.ToInt32(dr["UnitTypeID"]),
    //    //                UnitTypeName = dr["UnitTypeName"].ToString()
    //    //            });
    //    //}
    //    return list;
    //}
}