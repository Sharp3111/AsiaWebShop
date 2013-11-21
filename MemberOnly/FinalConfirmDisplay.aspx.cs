using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class MemberOnly_FinalConfirmDisplay : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        userName.Text = User.Identity.Name;

        string connectionString = "AsiaWebShopDBConnectionString";
        string SQLCmd = "SELECT [email],[confirmationNumber] FROM [OrderRecord] WHERE [userName] = '" + User.Identity.Name + "' AND isConfirmed = 'False'";

        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(SQLCmd, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    email.Text = (reader["email"].ToString().Trim());
                    confirmationCode.Text = (reader["confirmationNumber"].ToString().Trim());
                }
            }
            command.Connection.Close();
            reader.Close();
        }


        string query = "UPDATE OrderRecord SET isConfirmed = 'True', orderDateTime = CURRENT_TIMESTAMP WHERE (isConfirmed = 'False' AND userName = '" + User.Identity.Name + "')";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }

    }
}