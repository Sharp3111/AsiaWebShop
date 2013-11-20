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
            // Populate the DistrictDropDownList.
            DistrictDropDownList.Items.Add("-- Select district --");
            DistrictDropDownList.Items.Add("Central and Western");
            DistrictDropDownList.Items.Add("Eastern");
            DistrictDropDownList.Items.Add("Islands");
            DistrictDropDownList.Items.Add("Kowloon City");
            DistrictDropDownList.Items.Add("Kwai Tsing");
            DistrictDropDownList.Items.Add("Kwun Tong");
            DistrictDropDownList.Items.Add("North");
            DistrictDropDownList.Items.Add("Sai Kung");
            DistrictDropDownList.Items.Add("Sha Tin");
            DistrictDropDownList.Items.Add("Sham Shui Po");
            DistrictDropDownList.Items.Add("Southern");
            DistrictDropDownList.Items.Add("Tai Po");
            DistrictDropDownList.Items.Add("Tsuen Wan");
            DistrictDropDownList.Items.Add("Tuen Mun");
            DistrictDropDownList.Items.Add("Wan Chai");
            DistrictDropDownList.Items.Add("Wong Tai Sin");
            DistrictDropDownList.Items.Add("Yau Tsim Mong");
            DistrictDropDownList.Items.Add("Yuen Long");

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
        string query = "SELECT [nickname] FROM [Address] WHERE ([userName] =N'" + userName + "')";

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
                    string addressItem = reader["nickname"].ToString().Trim();
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
        Page.Validate("RegisterUserValidationGroup");
        if (Page.IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string connectionString2 = "AsiaWebShopDBConnectionString2";
            string userName = User.Identity.Name;

            // Define the SELECT query to get the member's address.
            string query = "SELECT [userName], [upc], [quantity] FROM [ShoppingCart] WHERE ([userName] =N'" + userName + "')";

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
                        string upc = reader["upc"].ToString().Trim();
                        int quantity = Convert.ToInt32(reader["quantity"].ToString().Trim());

                        // Define the UPDATE query with parameters.
                        string query2 = "UPDATE [OrderRecord] SET [name] = @Name, [email] = @Email, [phoneNumber] = @PhoneNumber, [address] = @Address, [deliveryDate] = @DeliveryDate, [deliveryTime] = @DeliveryTime WHERE [userName] = @UserName AND [isConfirmed] = @IsConfirmed AND [upc] = @UPC";

                        // Create the connection and the SQL command.
                        using (SqlConnection connection2 = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString2].ConnectionString))
                        using (SqlCommand command2 = new SqlCommand(query2, connection2))
                        {
                            // Define the INSERT query parameters and their values.
                            command2.Parameters.AddWithValue("@UserName", userName);
                            command2.Parameters.AddWithValue("@Email", Email.Text.Trim());
                            command2.Parameters.AddWithValue("@Name", FirstName.Text.Trim() + " " + LastName.Text.Trim());
                            command2.Parameters.AddWithValue("@PhoneNumber", PhoneNumber.Text.Trim());
                            command2.Parameters.AddWithValue("@Address", Address.Text.Trim());
                            command2.Parameters.AddWithValue("@DeliveryDate", DeliveryDateDropDownList.SelectedItem.Text.Trim());
                            command2.Parameters.AddWithValue("@DeliveryTime", DeliveryTimeDropDownList.SelectedItem.Text.Trim());
                            command2.Parameters.AddWithValue("@IsConfirmed", false);
                            command2.Parameters.AddWithValue("@UPC", upc);

                            // Open the connection, execute the UPDATE query and close the connection.
                            command2.Connection.Open();
                            command2.ExecuteNonQuery();
                            command2.Connection.Close();
                        }
                    }
                }

                // Close the connection and the DataReader.
                command.Connection.Close();
                reader.Close();
            }

            FormsAuthentication.SetAuthCookie(UserName.Text, false /* createPersistentCookie */);

            string continueUrl = "~/MemberOnly/PaymentInformation.aspx";
            if (String.IsNullOrEmpty(continueUrl))
            {
                continueUrl = "~/";
            }
            Response.Redirect(continueUrl, false);
        }
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
    protected void AddressDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (AddressDropDownList.SelectedValue.Trim() != "0")
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;
            string nickname = AddressDropDownList.SelectedItem.Text.Trim();
            string query = "SELECT [building], [floor], [flatSuite], [blockTower], [streetAddress], [district] FROM [Address] WHERE ([userName] =N'" + userName + "' AND [nickname] = N'" + nickname + "')";
            
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
                        // Assign the data values to the web form label.
                        string addressItem = reader["building"].ToString().Trim() + " " +
                                            reader["floor"].ToString().Trim() + " " +
                                            reader["flatSuite"].ToString().Trim() + " " +
                                            reader["blockTower"].ToString().Trim() + ", " +
                                            reader["streetAddress"].ToString().Trim() + ", " +
                                            reader["district"].ToString().Trim();
                        Address.Text = addressItem;
                    }
                }
                command.Connection.Close();
                reader.Close();
            }
        }
    }

    protected void AddAddress(string connectionString, string userName, string number, string type, string cardHolderName, string expiryMonth, string expiryYear)
    {
    //    // Define the INSERT query with parameters.
    //    string query = "INSERT INTO [CreditCard]([userName], [number], [type], [cardHolderName], [expiryMonth], [expiryYear])" +
    //                   "VALUES (@Username, @Number, @Type, @CardHolderName, @ExpiryMonth, @ExpiryYear)";
    //    // Create the connection and the SQL command.
    //    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
    //    using (SqlCommand command = new SqlCommand(query, connection))
    //    {
    //        // Define the UPDATE query parameters and their values.
    //        command.Parameters.AddWithValue("@Username", userName);
    //        command.Parameters.AddWithValue("@Number", number);
    //        command.Parameters.AddWithValue("@Type", type);
    //        command.Parameters.AddWithValue("@CardHolderName", cardHolderName);
    //        command.Parameters.AddWithValue("@ExpiryMonth", expiryMonth);

    //        //System.Diagnostics.Debug.WriteLine("UpdateCreditCard_MonthDropDownList.SelectedItem.Value:");
    //        //System.Diagnostics.Debug.WriteLine(MonthDropDownList.SelectedItem.Value);

    //        command.Parameters.AddWithValue("@ExpiryYear", expiryYear);

    //        // Open the connection, execute the INSERT query and close the connection.
    //        command.Connection.Open();
    //        command.ExecuteNonQuery();
    //        command.Connection.Close();
    //    }
    }

    protected void updateAddressInOrderRecord(string connectionString, string userName, string creditCardNumber)
    {
    //    // Define the INSERT query with parameters.
    //    string query = "UPDATE [OrderRecord] SET [creditCardNumber] = @CreditCardNumber WHERE [userName] = @UserName AND [isConfirmed] = @IsConfirmed";
    //    // Create the connection and the SQL command.
    //    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
    //    using (SqlCommand command = new SqlCommand(query, connection))
    //    {
    //        // Define the UPDATE query parameters and their values.
    //        command.Parameters.AddWithValue("@Username", userName);
    //        command.Parameters.AddWithValue("@CreditCardNumber", creditCardNumber);
    //        command.Parameters.AddWithValue("@IsConfirmed", false);
    //        /*command.Parameters.AddWithValue("@Type", type);
    //        command.Parameters.AddWithValue("@CardHolderName", cardHolderName);
    //        command.Parameters.AddWithValue("@ExpiryMonth", expiryMonth); */

    //        //System.Diagnostics.Debug.WriteLine("UpdateCreditCard_MonthDropDownList.SelectedItem.Value:");
    //        //System.Diagnostics.Debug.WriteLine(MonthDropDownList.SelectedItem.Value);

    //        //command.Parameters.AddWithValue("@ExpiryYear", expiryYear);

    //        // Open the connection, execute the INSERT query and close the connection.
    //        command.Connection.Open();
    //        command.ExecuteNonQuery();
    //        command.Connection.Close();
    //    }
    }

    protected void btAddYourCard_Click(object sender, EventArgs e)
    {
    //    Page.Validate("RegisterUserValidationGroup");
    //    if (Page.IsValid)
    //    {
    //        string connectionString = "AsiaWebShopDBConnectionString";
    //        string userName = User.Identity.Name;

    //        // After the information is added, add the credit card data in the credit card database.
    //        AddAddress(connectionString,
    //            userName.Trim(),
    //            CardNumber.Text.Trim(),
    //            CardTypeDropDownList.SelectedItem.Text.Trim(),
    //            CardHolderName.Text.Trim(),
    //            MonthDropDownList.SelectedItem.Text.Trim(),
    //            YearDropDownList.SelectedItem.Text.Trim());
    //        // After the information is added, add the credit card data in the order record database.
    //        updateCreditCardInOrderRecord(connectionString,
    //           userName.Trim(),
    //           CardNumber.Text.Trim());

    //        FormsAuthentication.SetAuthCookie(userName.Trim(), false /* createPersistentCookie */);

    //        string continueUrl = "~/MemberOnly/FinalConfirmation.aspx";
    //        if (String.IsNullOrEmpty(continueUrl))
    //        {
    //            continueUrl = "~/";
    //        }
    //        Response.Redirect(continueUrl, false);
    //    }
    }
    protected void DistrictDropDownList0_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}