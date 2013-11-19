using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;


public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";

        Int32 count = 0;
        //check if the item has already added into the shopping cart
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Recommendation]", connection))
        {
            command.Connection.Open();
            count = (Int32)command.ExecuteScalar();
            command.Connection.Close();
        }

        if (count == 0)
        {
            NumberLabel.Text = "Unavailable";
        }
        else
        {
            NumberLabel.Text = "Top " + count.ToString().Trim();
        }
    }
}