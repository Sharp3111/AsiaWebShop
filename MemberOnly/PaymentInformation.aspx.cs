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
            PopulateCheckBoxSelect(connectionString, userName);            
        }
    }

    private void PopulateCheckBoxSelect(string connectionString, string userName)
    {        
        Int32 MaxRow = gvCreditCard.Rows.Count;
        for (int i = 0; i < MaxRow; i++)
        {
            Boolean currentDefault = ((CheckBox)gvCreditCard.Rows[i].FindControl("checkBoxDefault")).Checked;
            ((CheckBox)gvCreditCard.Rows[i].FindControl("checkBoxSelect")).Checked = currentDefault;
        }
    }

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


 /*
    protected void btContinue_Click(object sender, EventArgs e)
    { Response.Write("<script>alert('enter btContinue_Click button')</script>");
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;
            string cardNumberSelected = ""; 

            Int32 MaxRows = gvCreditCard.Rows.Count;

            for (int i = 0; i < MaxRows; i++)
            {
                if (((CheckBox)gvCreditCard.Rows[i].FindControl("checkBoxSelect")).Checked == true)
                {
                    cardNumberSelected = ((Label)gvCreditCard.Rows[i].FindControl("numberLabel")).Text.Trim();
                    break;
                }
            }

            Response.Write("<script>alert('" + cardNumberSelected + "')</script>");

                // After the information is added, add the credit card data in the order record database.
                updateCreditCardInOrderRecord(connectionString,
                userName.Trim(),
                cardNumberSelected);
                
                //OnlyOneCardMessgae.Text = "Your selection has been made. Please proceed to the next step.";
                //OnlyOneCardMessgae.Visible = true;
                //btNextStep.Visible = true;
                //btSelectThisCard.Visible = false;
            

           

            //FormsAuthentication.SetAuthCookie(userName.Trim(), false /* createPersistentCookie );*/

            /*string continueUrl = "~/MemberOnly/FinalConfirmation.aspx";
            if (String.IsNullOrEmpty(continueUrl))
            {
                continueUrl = "~/";
            }
            Response.Redirect(continueUrl, false);
    }
    */

    protected void cvCardNumber_ServerValidate(object source, ServerValidateEventArgs args)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;

        string currentNumber = CardNumber.Text.Trim();

        Int32 count = 0;
        //check if the item has already added into the shopping cart
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [CreditCard] WHERE ([number] = '" + currentNumber + "' AND [userName] = '" + userName + "')", connection))
        {
            command.Connection.Open();
            count = (Int32)command.ExecuteScalar();
            command.Connection.Close();
        }

        if (count != 0)
        {
            args.IsValid = false;
        }
        else
        {
            args.IsValid = true;
        }
    }
    protected void deleteButton_Click(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;
        Int32 MaxRows = gvCreditCard.Rows.Count;

        Int32 count = 0;
        //check if there is only one credit card in user's credit card list
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [CreditCard] WHERE ([userName] = N'" + userName + "')", connection))
        {
            command.Connection.Open();
            count = (Int32)command.ExecuteScalar();
            command.Connection.Close();
        }

        if (count > 1)
        {
            //Response.Write("<script>alert('enter delete button')</script>");
            GridViewRow gridViewRow = (GridViewRow)(sender as Control).Parent.Parent;
            Boolean currentDefault = ((CheckBox)gridViewRow.FindControl("checkBoxDefault")).Checked;
            string currentNumber = ((Label)gridViewRow.FindControl("numberLabel")).Text.Trim();

            string queryDelete = "DELETE FROM [CreditCard] WHERE ([userName] = N'" + userName + "' AND [number] = '" + currentNumber + "')";
            //Response.Write("<script>alert('" + currentNumber + "')</script>");
            if (!currentDefault)
            {
                defaultCardMessage.Visible = false;
            }
            else
            {
                defaultCardMessage.Visible = true;
                defaultCardMessage.Text = "The selected card is your default card. After deletion, your default card will be the first one appearing in your credit card list";


                string firstValidInGridViewNumber = "";
                for (int i = 0; i < MaxRows; i++)
                {
                    if (((Label)gvCreditCard.Rows[i].FindControl("numberLabel")).Text.Trim() != currentNumber)
                    {
                        firstValidInGridViewNumber = ((Label)gvCreditCard.Rows[i].FindControl("numberLabel")).Text.Trim();
                        break;
                    }
                }

                string queryUpdate = "UPDATE [CreditCard] SET creditCardDefault = @CreditCardDefault WHERE ([userName] = N'" + userName + "' AND [number] = '" + firstValidInGridViewNumber + "')";

                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand(queryUpdate, connection))
                {
                    command.Parameters.AddWithValue("@CreditCardDefault", true);
                    command.Connection.Open();
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                }
            }

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(queryDelete, connection))
            {
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }

            string selectedCardNumber = "";
            //Remember checkBoxSelect
            for (int i = 0; i < MaxRows; i++)
            {
                if (((CheckBox)gvCreditCard.Rows[i].FindControl("checkBoxSelect")).Checked)
                {
                    selectedCardNumber = ((Label)gvCreditCard.Rows[i].FindControl("numberLabel")).Text.Trim();
                    break;
                }
            }

            //Data rebind
            gvCreditCard.DataBind();
            MaxRows = gvCreditCard.Rows.Count;

            Boolean stillExist = false;
            //Populate checkBoxSelect
            for (int i = 0; i < MaxRows; i++)
            {
                if (((Label)gvCreditCard.Rows[i].FindControl("numberLabel")).Text == selectedCardNumber)
                {
                    stillExist = true;
                    ((CheckBox)gvCreditCard.Rows[i].FindControl("checkBoxSelect")).Checked = true;
                    break;
                }
            }

            //First-time population unsuccessful
            if (!stillExist)
            {
                PopulateCheckBoxSelect(connectionString, userName);
            }

            //Response.Write("<script>alert('exit delete button')</script>");
        }
        else
        {
            defaultCardMessage.Visible = true;
            defaultCardMessage.ForeColor = System.Drawing.Color.Red;
            defaultCardMessage.Text = "You cannot delete the only credit card in your credit card list";
        }
    }
    protected void checkBoxSelect_CheckedChanged(object sender, EventArgs e)
    {
        GridViewRow gridViewRow = (GridViewRow)(sender as Control).Parent.Parent;
        //Boolean currentCheck = ((CheckBox)gridViewRow.FindControl("checkBoxSelect")).Checked;
        string currentNumber = ((Label)gridViewRow.FindControl("numberLabel")).Text.Trim();
        //Response.Write("<script>alert('" + currentNumber + "')</script>");

        Int32 MaxRows = gvCreditCard.Rows.Count;
        for (int i = 0; i < MaxRows; i++)
        {
            if (((Label)gvCreditCard.Rows[i].FindControl("numberLabel")).Text != currentNumber)
            {
                //make all others false
                ((CheckBox)gvCreditCard.Rows[i].FindControl("checkBoxSelect")).Checked = false;
            }
            else
            {
                //make the checked true
                ((CheckBox)gvCreditCard.Rows[i].FindControl("checkBoxSelect")).Checked = true;

                //Response.Write("<script>alert('" + Convert.ToString(((CheckBox)gridViewRow.FindControl("checkBoxSelect")).Checked) + "')</script>");
            }
        }
    }
    protected void btNextStep_Click(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;
        string cardNumberSelected = "";

        Int32 MaxRows = gvCreditCard.Rows.Count;

        for (int i = 0; i < MaxRows; i++)
        {
            if (((CheckBox)gvCreditCard.Rows[i].FindControl("checkBoxSelect")).Checked == true)
            {
                cardNumberSelected = ((Label)gvCreditCard.Rows[i].FindControl("numberLabel")).Text.Trim();
                break;
            }
        }

        //Response.Write("<script>alert('" + cardNumberSelected + "')</script>");

        // After the information is added, add the credit card data in the order record database.
        updateCreditCardInOrderRecord(connectionString,
        userName.Trim(),
        cardNumberSelected);

        //OnlyOneCardMessgae.Text = "Your selection has been made. Please proceed to the next step.";
        //OnlyOneCardMessgae.Visible = true;
        //btNextStep.Visible = true;
        //btSelectThisCard.Visible = false;




        //FormsAuthentication.SetAuthCookie(userName.Trim(), false /* createPersistentCookie */);

        /*string continueUrl = "~/MemberOnly/FinalConfirmation.aspx";
        if (String.IsNullOrEmpty(continueUrl))
        {
            continueUrl = "~/";
        }
        Response.Redirect(continueUrl, false);*/
        Response.Redirect("~/MemberOnly/FinalConfirmation.aspx");
    }
}