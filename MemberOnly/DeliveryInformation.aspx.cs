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


public partial class MemberOnly_DeliveryInformation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;
            GetMemberData(connectionString, userName);
            GetMemberAddress(connectionString, userName);

            // Populate DeliveryDateDropDownList
            DateTime today = DateTime.Now.Date;
            for (int i = 1; i <= 7; i++)
            {
                DeliveryDateDropDownList.Items.Add(today.AddDays(i).ToShortDateString().Trim());
            }
        }
    }
    private void GetMemberData(string connectionString, string userName)
    {
        // Define the SELECT query to get the member's personal data.
        string query = "SELECT [userName], [email], [firstName], [lastName], [phoneNumber] FROM [Member] WHERE ([username] =N'" + userName + "')";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Open the connection.
            command.Connection.Open();
            // Execute the SELECT query and place the result in a DataReader.
            SqlDataReader reader = command.ExecuteReader();
            // Check if a result was returned.
            if (reader.HasRows)
            {
                // Iterate through the table to get the retrieved values.
                while (reader.Read())
                {
                    // Assign the data values to the web form label and textboxes.
                    UserName.Text = reader["userName"].ToString().Trim();
                    Email.Text = reader["email"].ToString().Trim();
                    FirstName.Text = reader["firstName"].ToString().Trim();
                    LastName.Text = reader["lastName"].ToString().Trim();
                    PhoneNumber.Text = reader["phoneNumber"].ToString().Trim();
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }
    private void GetMemberAddress(string connectionString, string userName)
    {
        // Define the SELECT query to get the member's address.
        string query = "SELECT [nickname], [building], [floor], [flatSuite], [blockTower], [streetAddress], [district] FROM [Address] WHERE ([userName] =N'" + userName + "')";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Open the connection.
            command.Connection.Open();
            // Execute the SELECT query and place the result in a DataReader.
            SqlDataReader reader = command.ExecuteReader();
            // Check if a result was returned.
            if (reader.HasRows)
            {
                // Iterate through the table to get the retrieved values.
                while (reader.Read())
                {
                    // Assign the data values to the web form labels.
                    string addressItem = reader["nickname"].ToString().Trim() + ": " +
                                        reader["building"].ToString().Trim() + " " +
                                        reader["floor"].ToString().Trim() + " " +
                                        reader["flatSuite"].ToString().Trim() + " " +
                                        reader["blockTower"].ToString().Trim() + ", " +
                                        reader["streetAddress"].ToString().Trim() + ", " +
                                        reader["district"].ToString().Trim();
                    AddressDropDownList.Items.Add(addressItem);
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }
    protected void ContinueButton_Click(object sender, EventArgs e)
    {
        //Page.Validate("RegisterUserValidationGroup");
        //if (Page.IsValid)
        //{
        //    string connectionString = "AsiaWebShopDBConnectionString";
        //    string userName = User.Identity.Name;

        //    // Define the SELECT query to get the member's address.
        //    string query = "SELECT [userName], [upc], [quantity] FROM [ShoppingCart] WHERE ([userName] =N'" + userName + "')";

        //    // Create the connection and the SQL command.
        //    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        //    using (SqlCommand command = new SqlCommand(query, connection))
        //    {
        //        // Open the connection.
        //        command.Connection.Open();
        //        // Execute the SELECT query and place the result in a DataReader.
        //        SqlDataReader reader = command.ExecuteReader();
        //        // Check if a result was returned.
        //        if (reader.HasRows)
        //        {
        //            // Iterate through the table to get the retrieved values.
        //            while (reader.Read())
        //            {
        //                // Assign the data values to the web form labels.
        //                string upc = reader["upc"].ToString().Trim();
        //                int quantity = Convert.ToInt32(reader["quantity"].ToString().Trim());

        //                // Define the INSERT query with parameters.
        //                string query2 = "INSERT INTO [OrderRecord]([userName], [name], [email], [phoneNumber], [upc], [unitPrice], [quantity], [building], [floor], [flatSuite], " +
        //                                "[blockTower], [streetAddress], [district], [creditCardNumber], [deliveryDate], [deliveryTime], [confirmationNumber], [isConfirmed]) " +
        //                                "VALUES (@UserName, @Email, @FirstName, @LastName, @PhoneNumber, @RenewalDate)";

        //                // Create the connection and the SQL command.
        //                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        //                using (SqlCommand command = new SqlCommand(query, connection))
        //                {
        //                    // Define the INSERT query parameters and their values.
        //                    command.Parameters.AddWithValue("@UserName", userName);
        //                    command.Parameters.AddWithValue("@Email", email);
        //                    command.Parameters.AddWithValue("@FirstName", firstName);
        //                    command.Parameters.AddWithValue("@LastName", lastName);
        //                    command.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
        //                    command.Parameters.AddWithValue("@RenewalDate", renewalDate);

        //                    // Open the connection, execute the INSERT query and close the connection.
        //                    command.Connection.Open();
        //                    command.ExecuteNonQuery();
        //                    command.Connection.Close();
        //                }
        //            }
        //        }

        //        // Close the connection and the DataReader.
        //        command.Connection.Close();
        //        reader.Close();
        //    }

        //    FormsAuthentication.SetAuthCookie(UserName.Text, false /* createPersistentCookie */);

        //    string continueUrl = "~/MemberOnly/ViewMemberInformation.aspx";
        //    if (String.IsNullOrEmpty(continueUrl))
        //    {
        //        continueUrl = "~/";
        //    }
        //    Response.Redirect(continueUrl, false);
        //}
    }
    protected void cvDeliveryTime_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if ((DeliveryDateDropDownList.SelectedValue.Trim() != "0") & (DeliveryTimeDropDownList.SelectedValue.Trim() != "0"))
        {
            string tomorrow = DateTime.Now.Date.AddDays(1).ToShortDateString().Trim();
            int hour = DateTime.Now.Hour;
            if (DeliveryDateDropDownList.SelectedItem.Text.Trim() == tomorrow)
            {
                if (hour >= 9)
                {
                    if (Convert.ToInt32(DeliveryTimeDropDownList.SelectedValue.Trim()) <= 9)
                    {
                        args.IsValid = false;
                    }
                }
                if (hour >= 12)
                {
                    if (Convert.ToInt32(DeliveryTimeDropDownList.SelectedValue.Trim()) <= 12)
                    {
                        args.IsValid = false;
                    }
                }
                if (hour >= 15)
                {
                    if (Convert.ToInt32(DeliveryTimeDropDownList.SelectedValue.Trim()) <= 15)
                    {
                        args.IsValid = false;
                    }
                }
                if (hour >= 18)
                {
                    if (Convert.ToInt32(DeliveryTimeDropDownList.SelectedValue.Trim()) <= 18)
                    {
                        args.IsValid = false;
                    }
                }
            }
        }
    }
}