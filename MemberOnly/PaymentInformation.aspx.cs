using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;

public partial class MemberOnly_PaymentInformation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            gvCreditCard.DataBind();
            // Populate the YearDropDownList from current year to plus 10 years.
            YearDropDownList.Items.Add(new ListItem("Year", "0"));
            for (int year = DateTime.Now.Year; year <= DateTime.Now.Year + 10; year++)
            {
                YearDropDownList.Items.Add(year.ToString());
            }

            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;
            GetMemberData(connectionString, userName);

            // Hide and clear the edit result message.
            SelectOneCardOnlyMessage.Visible = false;
            SelectOneCardOnlyMessage.Text = "";
            SelectCardMessage.Visible = false;
            SelectCardMessage.Text = "";
            btNextStep.Visible = false;

            //GetMemberCreditCard(connectionString, userName);
        }
    }

    /*private void GetMemberCreditCard(string connectionString, string userName)
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
                    CardTypeDropDownList.Text = reader["type"].ToString().Trim();
                    MonthDropDownList.Text = reader["expiryMonth"].ToString().Trim();

                    // System.Diagnostics.Debug.WriteLine("GetMemberCreditCard_MonthDropDownList.SelectedItem.Value:");
                    // System.Diagnostics.Debug.WriteLine(MonthDropDownList.SelectedItem.Value);
                    YearDropDownList.Text = reader["expiryYear"].ToString().Trim();
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
        //System.Diagnostics.Debug.WriteLine("Exit GetMemberCreditCard");
    }*/

   private void GetMemberData(string connectionString, string userName)
    {
        // Define the SELECT query to get the member's personal data.
        string query = "SELECT [userName] FROM [Member] WHERE ([username] =N'" + userName + "')";

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
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }

    protected void AddCreditCard(string connectionString, string userName, string number, string type, string cardHolderName, string expiryMonth, string expiryYear)
    {
        // Define the INSERT query with parameters.
        string query = "INSERT INTO [CreditCard]([userName], [number], [type], [cardHolderName], [expiryMonth], [expiryYear])" +
                       "VALUES (@Username, @Number, @Type, @CardHolderName, @ExpiryMonth, @ExpiryYear)";
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

    protected void updateCreditCardInOrderRecord(string connectionString, string userName, string creditCardNumber)
    {
        // Define the INSERT query with parameters.
        string query = "UPDATE [OrderRecord] SET [creditCardNumber] = @CreditCardNumber WHERE [userName] = @UserName AND [isConfirmed] = @IsConfirmed";
        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@Username", userName);
            command.Parameters.AddWithValue("@CreditCardNumber", creditCardNumber);
            command.Parameters.AddWithValue("@IsConfirmed", false);
            /*command.Parameters.AddWithValue("@Type", type);
            command.Parameters.AddWithValue("@CardHolderName", cardHolderName);
            command.Parameters.AddWithValue("@ExpiryMonth", expiryMonth); */

            //System.Diagnostics.Debug.WriteLine("UpdateCreditCard_MonthDropDownList.SelectedItem.Value:");
            //System.Diagnostics.Debug.WriteLine(MonthDropDownList.SelectedItem.Value);

            //command.Parameters.AddWithValue("@ExpiryYear", expiryYear);

            // Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

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
    protected void btAddYourCard_Click(object sender, EventArgs e)
    {
        Page.Validate("RegisterUserValidationGroup");
        if (Page.IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;

         

            // After the information is added, add the credit card data in the credit card database.
            AddCreditCard(connectionString,
                userName.Trim(),
                CardNumber.Text.Trim(),
                CardTypeDropDownList.SelectedItem.Text.Trim(),
                CardHolderName.Text.Trim(),
                MonthDropDownList.SelectedItem.Text.Trim(),
                YearDropDownList.SelectedItem.Text.Trim());
            // After the information is added, add the credit card data in the order record database.
            updateCreditCardInOrderRecord(connectionString,
               userName.Trim(),
               CardNumber.Text.Trim());

            FormsAuthentication.SetAuthCookie(userName.Trim(), false /* createPersistentCookie */);

            string continueUrl = "~/MemberOnly/FinalConfirmation.aspx";
            if (String.IsNullOrEmpty(continueUrl))
            {
                continueUrl = "~/";
            }
            Response.Redirect(continueUrl, false);
        }
    }


   /* protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        int j = 0;
        foreach (GridViewRow row in this.gvCreditCard.Rows)
        {
            Control ctrl = row.FindControl("CheckBox1");
            if ((ctrl as CheckBox).Checked)
            {
                j++;
            }
            if (j > 1)
            {
                SelectOneCardOnlyMessage.Text = "Please select one credit card only.";
                SelectOneCardOnlyMessage.Visible = true;
                Response.Redirect(Request.RawUrl);
            }
        }
    }*/
    protected void btContinue_Click(object sender, EventArgs e)
    {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;
            string cardNumberSelected = "";
            CheckBox1_CheckedChanged2(sender, e);

            if (SelectOneCardOnlyMessage.Visible == false)
            {
                foreach (GridViewRow row in this.gvCreditCard.Rows)
                {
                    Control ctrl = row.FindControl("CheckBox1");
                    if ((ctrl as CheckBox).Checked)
                    {
                        TableCellCollection cell = row.Cells;
                        cardNumberSelected = cell[3].Text.Trim();
                        break;
                    }
                }

                // After the information is added, add the credit card data in the order record database.
                updateCreditCardInOrderRecord(connectionString,
                userName.Trim(),
                cardNumberSelected);
                
                SelectCardMessage.Text = "Your selection has been made. Please proceed to the next step.";
                SelectCardMessage.Visible = true;
                btNextStep.Visible = true;
                btSelectThisCard.Visible = false;
            }

           

            //FormsAuthentication.SetAuthCookie(userName.Trim(), false /* createPersistentCookie */);

            /*string continueUrl = "~/MemberOnly/FinalConfirmation.aspx";
            if (String.IsNullOrEmpty(continueUrl))
            {
                continueUrl = "~/";
            }
            Response.Redirect(continueUrl, false);*/
    }

    protected void CheckBox1_CheckedChanged2(object sender, EventArgs e)
    {
        int j = 0;
        foreach (GridViewRow row in this.gvCreditCard.Rows)
        {
            Control ctrl = row.FindControl("CheckBox1");
            if ((ctrl as CheckBox).Checked)
            {
                j++;
            }
            if (j > 1)
            {
                SelectOneCardOnlyMessage.Text = "Please select one credit card only.";
                SelectOneCardOnlyMessage.Visible = true;
                Response.Redirect(Request.RawUrl);
            }
        }
    }
}