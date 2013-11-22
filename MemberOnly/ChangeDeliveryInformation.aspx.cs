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
using System.Text;
using System.Net.Mail;


public partial class MemberOnly_DeliveryInformation : System.Web.UI.Page
{
    public class emailAddress
    {
        public static string Email = "";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            String orderConfirmationNumber = Request.QueryString["confirmationNumber"];

            // Populate the DistrictDropDownList.
            // DistrictDropDownList.Items.Add("-- Select district --");
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
            DateDropdownList(connectionString, userName);

            // Populate DeliveryDateDropDownList
           
        }
    }

    private void DateDropdownList(string connectionString, string userName)
    {
        DateTime date= new DateTime();
        DateTime today = DateTime.Now.Date;
        String orderConfirmationNumber = Request.QueryString["confirmationNumber"];
        string query = "SELECT [orderDateTime]  FROM [OrderRecord] WHERE ([userName] =N'" + userName + "' AND [confirmationNumber] = N'" + orderConfirmationNumber + "')";

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
                    date = DateTime.Parse(reader["orderDateTime"].ToString().Trim());
                }
            }
            command.Connection.Close();
            reader.Close();
        }
        int datedifference = (today.Date - date.Date).Days;
        for (int i = 1; i <= 7 - datedifference; i++)
        {
            DeliveryDateDropDownList.Items.Add(today.AddDays(i).ToShortDateString().Trim());
        }
    }

    private void GetMemberData(string connectionString, string userName)
    {
        String orderConfirmationNumber = Request.QueryString["confirmationNumber"];
        // Define the SELECT query to get the member's personal data.
        string query = "SELECT [userName], [email], [name], [phoneNumber] FROM [OrderRecord] WHERE ([username] =N'" + userName + "' AND [confirmationNumber] = N'" + orderConfirmationNumber + "')";

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
                    email.Text = reader["email"].ToString().Trim();
                    emailAddress.Email = reader["email"].ToString().Trim();
                    Name.Text = reader["name"].ToString().Trim();
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
        Boolean flag = true;
        if (AddressDropDownList.SelectedValue == "0" && AddressDropDownList.Enabled == true)
            flag = false;

        if (Page.IsValid && flag == true)
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
                        string query2 = "UPDATE [OrderRecord] SET [name] = @Name,  [phoneNumber] = @PhoneNumber, [address] = @Address, [deliveryDate] = @DeliveryDate, [deliveryTime] = @DeliveryTime WHERE [userName] = @UserName AND [isConfirmed] = @IsConfirmed AND [upc] = @UPC";

                        // Create the connection and the SQL command.
                        using (SqlConnection connection2 = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString2].ConnectionString))
                        using (SqlCommand command2 = new SqlCommand(query2, connection2))
                        {
                            // Define the INSERT query parameters and their values.
                            command2.Parameters.AddWithValue("@UserName", userName);
                            command2.Parameters.AddWithValue("@Name", Name.Text.Trim());
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

                MailMessage mail = new MailMessage();

                // Create an instance of SmtpClient named emailServer and set the mail server to use as "smtp.cse.ust.hk".
                SmtpClient emailServer = new SmtpClient("smtp.cse.ust.hk");

                // Set the sender (From), receiver (To), subject and message body fields of the mail message.
                mail.From = new MailAddress("sharpert115@yeah.net", "Asia Web Shop t115 @Sharp");
                mail.To.Add(emailAddress.Email);
                mail.Subject = "Delivery Information Changed Notification";

                mail.Body = "Dear " + User.Identity.Name + ", your delivery information has been changed:\n\n"
             + "Confirmation #:\n" + Request.QueryString["confirmationNumber"] + '\n'
             + "Name:            " + Name.Text.Trim() + '\n'
             + "Email Address:   " + emailAddress.Email + '\n'
             + "Phone Number:    " + PhoneNumber.Text.Trim() + '\n'
             + "Address:         " + Address.Text.Trim() + '\n'
             + "Delivery Date:   " + DeliveryDateDropDownList.SelectedItem.Text.Trim() + '\n'
             + "Delivery Time:   " + DeliveryTimeDropDownList.SelectedItem.Text.Trim() + '\n'
             + '\n' + '\n'
             + "Note: this is a system generated email notification for your delivery information change"
             + ", please do not reply.";

                emailServer.Send(mail);

                Server.Transfer("ChangeDeliveryInformationDisplay.aspx");

            }

            FormsAuthentication.SetAuthCookie(UserName.Text, false /* createPersistentCookie */);

            string continueUrl = "~/MemberOnly/PaymentInformation.aspx";
            if (String.IsNullOrEmpty(continueUrl))
            {
                continueUrl = "~/";
            }
            Response.Redirect(continueUrl, false);
        }

        if (flag == false)
        {
            lblMessage1.ForeColor = System.Drawing.Color.Red;
            lblMessage1.Visible = true;
            lblMessage1.Text = "Please choose your address and click the Choose Your Address button to confirm your choice first.";
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

    protected void AddAddress(string connectionString, string userName, string buidling, string floor, string flatSuite, string blockTower, string streetAddress, string district, string nickname)
    {
        // Define the INSERT query with parameters.
        string query = "INSERT INTO [Address]([userName], [building], [floor], [flatSuite], [blockTower], [streetAddress], [district], [nickname])" +
                       "VALUES (@Username, @Building, @Floor, @FlatSuite, @BlockTower, @StreetAddress, @District, @Nickname)";
        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@Username", userName);
            command.Parameters.AddWithValue("@Building", buidling);
            command.Parameters.AddWithValue("@Floor", floor);
            command.Parameters.AddWithValue("@FlatSuite", flatSuite);
            command.Parameters.AddWithValue("@BlockTower", blockTower);
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

            command.Parameters.AddWithValue("@StreetAddress", streetAddress);
            command.Parameters.AddWithValue("@District", district);
            command.Parameters.AddWithValue("@Nickname", nickname);
    //        command.Parameters.AddWithValue("@ExpiryYear", expiryYear);

            //Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();                                  
            command.Connection.Close();
        }


        Address.Text = buidling.Trim() + " " + floor.Trim() + " " + flatSuite.Trim() + " " + blockTower.Trim() + ", " + streetAddress.Trim() + ", " + district.Trim();
        Address.Visible = true;
    }

    protected void updateAddressInOrderRecord(string connectionString, string userName)
    {
        //// Define the INSERT query with parameters.
        //string query1 = "SELECT [building], [floor], [flatSuite], [blockTower], [streetAddress], [district] FROM [Address] WHERE ([userName] =N'" + userName + "' AND [nickname] = N'" + nickname + "')";
        //using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        //using (SqlCommand command = new SqlCommand(query1, connection))
        //{
        //    // Open the connection.
        //    command.Connection.Open();
        //    // Execute the SELECT query and place the result in a DataReader.
        //    SqlDataReader reader = command.ExecuteReader();
        //    // Check if a result was returned.                 
        //    if (reader.HasRows)
        //    {
        //        // Iterate through the table to get the retrieved values.
        //        while (reader.Read())
        //        {
        //            // Assign the data values to the web form label.
        //            string addressItem = reader["building"].ToString().Trim() + " " +
        //                                reader["floor"].ToString().Trim() + " " +
        //                                reader["flatSuite"].ToString().Trim() + " " +
        //                                reader["blockTower"].ToString().Trim() + ", " +
        //                                reader["streetAddress"].ToString().Trim() + ", " +
        //                                reader["district"].ToString().Trim();
        //            Address.Text = addressItem;
        //        }
        //    }
        //    command.Connection.Close();
        //    reader.Close();
        //}
        string query2 = "UPDATE [OrderRecord] SET [address] = @Address WHERE [userName] = @UserName AND [isConfirmed] = @IsConfirmed";
        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query2, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@Username", userName);
            command.Parameters.AddWithValue("@Address", Address.Text);
            command.Parameters.AddWithValue("@IsConfirmed", false);
            /*command.Parameters.AddWithValue("@Type", type);
            command.Parameters.AddWithValue("@CardHolderName", cardHolderName);
            command.Parameters.AddWithValue("@ExpiryMonth", expiryMonth); */
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

            // Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    protected void btnAddYourAddress_Click(object sender, EventArgs e)
    {
        Page.Validate("AddAddressValidationGroup");
        if (Page.IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;

            // After the information is added, add the credit card data in the credit card database.
            AddAddress(connectionString,
                userName.Trim(),
                Building.Text.Trim(),
                Floor.Text.Trim(),
                FlatSuite.Text.Trim(),
                BlockTower.Text.Trim(),
                Street.Text.Trim(),
                DistrictDropDownList.SelectedItem.Text.Trim(),
                Nickname.Text.Trim());

            // After the information is added, add the credit card data in the order record database.
            updateAddressInOrderRecord(connectionString,
               userName.Trim());

            //FormsAuthentication.SetAuthCookie(userName.Trim(), false /* createPersistentCookie */);

            //string continueUrl = "~/MemberOnly/FinalConfirmation.aspx";
            //if (String.IsNullOrEmpty(continueUrl))
            //{
            //    continueUrl = "~/";
            //}
            //Response.Redirect(continueUrl, false);
            lblMessage.Visible = true;
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Text = "You successfully added a new delivery address. Next please specify delivery time.";
            //AddressDropDownList.Visible = false;
            AddressDropDownList.Enabled = false;
            //lblSelectAddress.Visible = false;
            //lblDeliveryAddress.Visible = false;
 
            //btnChooseAddress.Visible = false;
            btnChooseAddress.Enabled = false;

            lblFinalAddress.Visible = true;
            Address.Visible = true;
        }
    }
    protected void cvInsertNickname_ServerValidate(object source, ServerValidateEventArgs args)
    {
        string userName = User.Identity.Name;
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {
            // Get the value of the new UPC from the DetailsView control.
            string txtInsertNickname = Nickname.Text.Trim();
            

            // Count how many existing records have the student id value.
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Address] WHERE ([userName] = '" + userName + "' AND [nickname] = N'" + txtInsertNickname + "')", connection);
            Int32 count = (Int32)command.ExecuteScalar();
            connection.Close();

            // If the count is not zero the UPC already exists, so cancel the insert.
            if (count != 0)
            {
                args.IsValid = false;
            }
        }
    }
    protected void DistrictDropDownList0_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btnChooseAddress_Click(object sender, EventArgs e)
    {
        Page.Validate("ChooseAddressValidationGroup");
        if (Page.IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;

            updateAddressInOrderRecord(connectionString,
            userName.Trim());

            lblMessage0.Visible = true;
            lblMessage0.ForeColor = System.Drawing.Color.Red;
            lblMessage0.Text = "You successfully chose this delivery address. Next please specify delivery time.";


            //lblAddAddress.Visible = false;
            //lblEnterAddrInfo.Visible = false;

            //lblBuilding.Visible = false;
            //Building.Visible = false;
            Building.Enabled = false;

            //lblFloor.Visible = false;
            //Floor.Visible = false;
            Floor.Enabled = false;

            //lblFlatSuite.Visible = false;
            //FlatSuite.Visible = false;
            FlatSuite.Enabled = false;

            //lblBlockTower.Visible = false;
            //BlockTower.Visible = false;
            BlockTower.Enabled = false;

            //lblStreet.Visible = false;
            //Street.Visible = false;
            Street.Enabled = false;

            //lblDistrict.Visible = false;
            //DistrictDropDownList.Visible = false;
            DistrictDropDownList.Enabled = false;

            //lblNickname.Visible = false;
            //Nickname.Visible = false;
            Nickname.Enabled = false;

            //btnAddYourAddress.Visible = false;
            btnAddYourAddress.Enabled = false;

            lblFinalAddress.Visible = true;
            Address.Visible = true;
           
        }
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
}