using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Security;

public partial class AdminOnly_MemberLoginManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void Execute_Click(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        EnableMemberLogin(connectionString);
        DisableMemberLogin(connectionString);
    }

    private void EnableMemberLogin(string connectionString)
    {        
        // Get the search string
        string searchEnableUser = enableUser.Text.Trim();

        if (searchEnableUser != "")
        {
            MembershipUser user = Membership.GetUser(searchEnableUser);
            if (user != null)
            {
                if(Roles.IsUserInRole(enableUser.Text.Trim(),"Admin")) {
                    lblEnableMemberLoginMessage.Text = "You cannot activate an admin!";
                }
                else{
                user.IsApproved = true;
                Membership.UpdateUser(user);
                lblEnableMemberLoginMessage.Text = "Member with user name: " + searchEnableUser + " is activated. ";
                }
            }

            else
            {
                lblEnableMemberLoginMessage.Text = "No such member exists. ";
            }
        }
        else
        {
            lblEnableMemberLoginMessage.Text = "";
        }
        
        
        /*
        // Construct the basic SELECT statement for searching.
        string enableQuery = "SELECT [userName], [active] FROM [Member] WHERE ([userName] = " + searchEnableUser + ")";
        // Define the UPDATE query with parameters.
        string updateQuery = "UPDATE [Member] SET [active] = True WHERE [userName] = " + searchEnableUser;

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand commandSearch = new SqlCommand(enableQuery, connection))
        {
            // Open the connection.
            commandSearch.Connection.Open();
            // Execute the SELECT query and place the result in a DataReader.
            SqlDataReader reader = commandSearch.ExecuteReader();
            // Check if a result was returned.
            if (reader.HasRows)
            {
                using (SqlCommand commandUpdate = new SqlCommand(updateQuery, connection))
                {
                    commandUpdate.Connection.Open();
                    commandUpdate.ExecuteNonQuery();
                    commandUpdate.Connection.Close();
                }
                lblEnableMemberLoginMessage.Text = "Member with user name: " + searchEnableUser + " is activated."
            }
            else
            {
                lblEnableMemberLoginMessage.Text = "No such member exists. ";
            }
            commandSearch.Connection.Close();
            reader.Close();
         */        
    }

    private void DisableMemberLogin(string connectionString)
    {
        // Get the search string
        string searchDisableUser = disableUser.Text.Trim();

        if (searchDisableUser != "")
        {
            MembershipUser user = Membership.GetUser(searchDisableUser);
            if (user != null)
            {
                if (Roles.IsUserInRole(enableUser.Text.Trim(), "Admin"))
                {
                    lblDisableMemberLoginMessage.Text = "You cannot deactivate an admin!";
                }
                else
                {
                    user.IsApproved = false;
                    Membership.UpdateUser(user);
                    lblDisableMemberLoginMessage.Text = "Member with user name: " + searchDisableUser + " is deactivated. ";
                }
            }
            else
            {
                lblDisableMemberLoginMessage.Text = "No such member exists. ";
            }
        }
        else
        {
            lblDisableMemberLoginMessage.Text = "";
        }

        /*
        // Get the search string
        string searchDisableUser = enableUser.Text.Trim();
        // Construct the basic SELECT statement for searching.
        string enableQuery = "SELECT [userName], [active] FROM [Member] WHERE ([userName] = " + searchEnableUser + ")";
        // Define the UPDATE query with parameters.
        string updateQuery = "UPDATE [Member] SET [active] = True WHERE [userName] = " + searchEnableUser;

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand commandSearch = new SqlCommand(enableQuery, connection))
        {
            // Open the connection.
            commandSearch.Connection.Open();
            // Execute the SELECT query and place the result in a DataReader.
            SqlDataReader reader = commandSearch.ExecuteReader();
            // Check if a result was returned.
            if (reader.HasRows)
            {
                using (SqlCommand commandUpdate = new SqlCommand(updateQuery, connection))
                {
                    commandUpdate.Connection.Open();
                    commandUpdate.ExecuteNonQuery();
                    commandUpdate.Connection.Close();
                }
                lblEnableMemberLoginMessage.Text = "Member with user name: " + searchDisableUser + " is activated."
            }
            else
            {
                lblEnableMemberLoginMessage.Text = "No such member exists. ";
            }
            commandSearch.Connection.Close();
            reader.Close();
        }
         * */
    }
         
}