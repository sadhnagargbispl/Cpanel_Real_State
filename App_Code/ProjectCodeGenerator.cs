using System;
using System.Data.SqlClient;

// App_Code folder — No namespace

public static class ProjectCodeGenerator
{
    // Returns: 2001, 2002, 2003, 2004 ...
    public static string Generate(string projectName)
    {
        return GetNextSequence().ToString();
    }

    public static string GenerateUnique(string projectName, System.Func<string, bool> existsCheck)
    {
        string code = GetNextSequence().ToString();
        // Agar exist kare toh +1 karte raho
        int num;
        int.TryParse(code, out num);
        while (existsCheck(num.ToString()))
            num++;
        return num.ToString();
    }

    // DB se last ProjectCode fetch karke +1 karo
    // Agar koi project nahi hai toh 2001 se shuru
    private static int GetNextSequence()
    {
        try
        {
            using (var con = DBHelper.GetConnection())
            using (var cmd = new SqlCommand(
                @"SELECT TOP 1 ProjectCode
                  FROM dbo.Projects
                  WHERE IsDeleted = 0
                  ORDER BY ProjectID DESC", con))
            {
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                {
                    int lastNum;
                    if (int.TryParse(result.ToString(), out lastNum))
                        return lastNum;
                }
            }
        }
        catch { }

        return 2001; // pehli baar
    }
}