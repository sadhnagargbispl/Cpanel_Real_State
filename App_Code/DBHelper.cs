using System.Configuration;
using System.Data.SqlClient;

// App_Code folder - No namespace

public static class DBHelper
{
    // Web.config mein yeh add karo:
    // <connectionStrings>
    //   <add name="AdarshDB"
    //        connectionString="Server=.\SQLEXPRESS;Database=AdarshRealtors;Integrated Security=True;"
    //        providerName="System.Data.SqlClient"/>
    // </connectionStrings>

    public static SqlConnection GetConnection()
    {
        string connStr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        return new SqlConnection(connStr);
    }
}
