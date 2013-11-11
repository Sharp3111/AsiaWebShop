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


public partial class MemberOnly_EditMemberInformation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            /*
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
            // Populate the YearDropDownList from current year to plus 10 years.
            YearDropDownList.Items.Add(new ListItem("Year", "0"));
            for (int year = DateTime.Now.Year; year <= DateTime.Now.Year + 10; year++)
            {
                YearDropDownList.Items.Add(year.ToString());
            }
            */
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;
            GetMemberData(connectionString, userName);
            GetMemberAddress(connectionString, userName);
            GetMemberCreditCard(connectionString, userName);
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
        string query = "SELECT [building], [floor], [flatSuite], [blockTower], [streetAddress], [district] FROM [Address] WHERE ([userName] =N'" + userName + "' AND [nickname] = 'Home')";

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
                    Building.Text = reader["building"].ToString().Trim();
                    Floor.Text = reader["floor"].ToString().Trim();
                    FlatSuite.Text = reader["flatSuite"].ToString().Trim();
                    BlockTower.Text = reader["blockTower"].ToString().Trim();
                    Street.Text = reader["streetAddress"].ToString().Trim();
                    District.Text = reader["district"].ToString().Trim();
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }

    private void GetMemberCreditCard(string connectionString, string userName)
    {
        //System.Diagnostics.Debug.WriteLine("Enter GetMemberCreditCard");
        // Define the SELECT query to get the member's credit card.
        string query = "SELECT [number], [type], [cardHolderName], [expiryMonth], [expiryYear] FROM [CreditCard] WHERE ([username] =N'" + userName + "')";

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
                    CardHolderName.Text = reader["cardHolderName"].ToString().Trim();
                    CardNumber.Text = reader["number"].ToString().Trim();
                    CardType.Text = reader["type"].ToString().Trim();
                    Month.Text = reader["expiryMonth"].ToString().Trim();

                   // System.Diagnostics.Debug.WriteLine("GetMemberCreditCard_MonthDropDownList.SelectedItem.Value:");
                   // System.Diagnostics.Debug.WriteLine(MonthDropDownList.SelectedItem.Value);
                    Year.Text = reader["expiryYear"].ToString().Trim();
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
        //System.Diagnostics.Debug.WriteLine("Exit GetMemberCreditCard");
    }

    protected void UpdateMember(string connectionString, string userName, string email, string firstName, string lastName, string phoneNumber)
    {
        // Define the UPDATE query with parameters.
        string query = "UPDATE [Member] SET [email] = @Email, [firstName] = @FirstName, [lastName] = @LastName, [phoneNumber] = @PhoneNumber WHERE [userName] = @UserName";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@UserName", userName);
            command.Parameters.AddWithValue("@Email", email);
            command.Parameters.AddWithValue("@FirstName", firstName);
            command.Parameters.AddWithValue("@LastName", lastName);
            command.Parameters.AddWithValue("@PhoneNumber", phoneNumber);

            // Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    protected void UpdateAddress(string connectionString, string userName, string building, string floor, string flatSuite, string blockTower, string streetAddress, string district)
    {
        // Define the UPDATE query with parameters.
        string query = "UPDATE [Address] SET [building] = @Building, [floor] = @Floor, [flatSuite] = @FlatSuite, [BlockTower] = @BlockTower, [streetAddress] = @StreetAddress, [district] = @District WHERE [userName] =@UserName AND [nickname]='Home'";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@UserName", userName);
            command.Parameters.AddWithValue("@Building", building);
            command.Parameters.AddWithValue("@Floor", floor);
            command.Parameters.AddWithValue("@FlatSuite", flatSuite);
            command.Parameters.AddWithValue("@BlockTower", blockTower);
            command.Parameters.AddWithValue("@StreetAddress", streetAddress);
            command.Parameters.AddWithValue("@District", district);

            // Open the connection, execute the UPDATE query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    protected void UpdateCreditCard(string connectionString, string userName, string number, string type, string cardHolderName, string expiryMonth, string expiryYear)
    {
        // Define the UPDATE query with parameters.
        string query = "UPDATE CreditCard SET number = @Number, type = @Type, cardHolderName = @CardHolderName, expiryMonth = @ExpiryMonth, expiryYear = @ExpiryYear WHERE userName = @UserName";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@Username", userName);
            command.Parameters.AddWithValue("@Number", number);
            command.Parameters.AddWithValue("@Type", type);
            command.Parameters.AddWithValue("@CardHolderName", cardHolderName);
            command.Parameters.AddWithValue("@ExpiryMonth", expiryMonth);

            //System.Diagnostics.Debug.WriteLine("UpdateCreditCard_MonthDropDownList.SelectedItem.Value:");
            //System.Diagnostics.Debug.WriteLine(MonthDropDownList.SelectedItem.Value);

            command.Parameters.AddWithValue("@ExpiryYear", expiryYear);

            // Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    /*
    protected void cvExpiryDate_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if ((MonthDropDownList.SelectedValue.Trim() != "00") & (YearDropDownList.SelectedValue.Trim() != "0"))
        {
            Int16 month = Convert.ToInt16(MonthDropDownList.SelectedValue.Trim());
            Int16 year = Convert.ToInt16(YearDropDownList.SelectedValue.Trim());
            if ((DateTime.Now.Month > month) & (DateTime.Now.Year >= year))
            {
                args.IsValid = false;
            }  
        }
    }
    */

    protected void Update_Click(object sender, EventArgs e)
    {
        Page.Validate("RegisterUserValidationGroup");
        if (Page.IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;

            // After the registration information is validated, update the member data in the database.
            UpdateMember(connectionString,
                UserName.Text.Trim(),
                Email.Text.Trim(),
                FirstName.Text.Trim(),
                LastName.Text.Trim(),
                PhoneNumber.Text.Trim());
            /*
            // After the registration information is validated, update the address data in the database.
            UpdateAddress(connectionString,
                UserName.Text.Trim(),
                Building.Text.Trim(),
                Floor.Text.Trim(),
                FlatSuite.Text.Trim(),
                BlockTower.Text.Trim(),
                Street.Text.Trim(),
                DistrictDropDownList.SelectedItem.Text.Trim());
            
            // After the registration information is validated, update the credit card data in the database.
            UpdateCreditCard(connectionString,
                UserName.Text.Trim(),
                CardNumber.Text.Trim(),
                CardTypeDropDownList.SelectedItem.Text.Trim(),
                CardHolderName.Text.Trim(),
                MonthDropDownList.SelectedItem.Text.Trim(),
                YearDropDownList.SelectedItem.Text.Trim());
            */
            FormsAuthentication.SetAuthCookie(UserName.Text, false /* createPersistentCookie */);

            string continueUrl = "~/MemberOnly/ViewMemberInformation.aspx";
            if (String.IsNullOrEmpty(continueUrl))
            {
                continueUrl = "~/";
            }
            Response.Redirect(continueUrl, false);
        }
    }
}
