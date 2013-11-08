using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class MemberOnly_PaymentMethodManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;

            //GridView.DataKeyNames 
            UserName.Text = userName;

            //GetCreditCardInformationForGridView(connectionString, userName);

        }
    }


    protected void insertUserName_Load(object sender, EventArgs e)
    {
        ((TextBox)(sender as Control)).Text = User.Identity.Name.Trim();
    }
    protected void dvCreditCard_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        gvCreditCard.DataBind();
    }
    protected void editYearDropDownList_Load(object sender, EventArgs e)
    {
        // Populate the YearDropDownList from current year to plus 10 years.
        for (int year = DateTime.Now.Year; year <= DateTime.Now.Year + 10; year++)
        {
            string Year = year.ToString().Trim();
            ((DropDownList)(sender as Control)).Items.Add(Year);
        }

        string userName = User.Identity.Name;
        string connectionString = "AsiaWebShopDBConnectionString";
        GridViewRow row = gvCreditCard.SelectedRow;
        string creditCardNumber = ((Label)row.FindControl("cardNumber")).Text.Trim();
        //Response.Write("<script>alert('" + creditCardNumber + "')</script>");

        string TYPE = "";
        string MONTH = "";
        string YEAR = "";
        string querySelect = "SELECT [type], [expiryMonth], [expiryYear] FROM [CreditCard] WHERE ([userName] = N'" + userName + "' AND [number] = '" + creditCardNumber + "')";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(querySelect, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    TYPE = reader["type"].ToString().Trim();
                    MONTH = reader["expiryMonth"].ToString().Trim();
                    YEAR = reader["expiryYear"].ToString().Trim();
                }
            }
        }

        ((DropDownList)(sender as Control)).Text = YEAR;
    }
    protected void editCardTypeDropDownList_Load(object sender, EventArgs e)
    {
        string userName = User.Identity.Name;
        string connectionString = "AsiaWebShopDBConnectionString";
        GridViewRow row = gvCreditCard.SelectedRow;
        string creditCardNumber = ((Label)row.FindControl("cardNumber")).Text.Trim();
        //Response.Write("<script>alert('" + creditCardNumber + "')</script>");

        string TYPE = "";
        string MONTH = "";
        string YEAR = "";
        string querySelect = "SELECT [type], [expiryMonth], [expiryYear] FROM [CreditCard] WHERE ([userName] = N'" + userName + "' AND [number] = '" + creditCardNumber + "')";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(querySelect, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    TYPE = reader["type"].ToString().Trim();
                    MONTH = reader["expiryMonth"].ToString().Trim();
                    YEAR = reader["expiryYear"].ToString().Trim();
                }
            }
        }

        ((DropDownList)(sender as Control)).Text = TYPE;
    }
    protected void editMonthDropDownList_Load(object sender, EventArgs e)
    {
        string userName = User.Identity.Name;
        string connectionString = "AsiaWebShopDBConnectionString";
        GridViewRow row = gvCreditCard.SelectedRow;
        string creditCardNumber = ((Label)row.FindControl("cardNumber")).Text.Trim();
        //Response.Write("<script>alert('" + creditCardNumber + "')</script>");

        string TYPE = "";
        string MONTH = "";
        string YEAR = "";
        string querySelect = "SELECT [type], [expiryMonth], [expiryYear] FROM [CreditCard] WHERE ([userName] = N'" + userName + "' AND [number] = '" + creditCardNumber + "')";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(querySelect, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    TYPE = reader["type"].ToString().Trim();
                    MONTH = reader["expiryMonth"].ToString().Trim();
                    YEAR = reader["expiryYear"].ToString().Trim();
                }
            }
        }

        ((DropDownList)(sender as Control)).Text = MONTH;
    }
    protected void cvEditCardType_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = true;

        TextBox txtEditCardType = (TextBox)dvCreditCard.FindControl("EditCardType");

        string P1 = "American Express";
        string P2 = "Diners Club";
        string P3 = "Discover";
        string P4 = "MasterCard";
        string P5 = "Visa";

        if (!(txtEditCardType.Text.Trim().Equals(P1, StringComparison.Ordinal) ||
             txtEditCardType.Text.Trim().Equals(P2, StringComparison.Ordinal) ||
             txtEditCardType.Text.Trim().Equals(P3, StringComparison.Ordinal) ||
             txtEditCardType.Text.Trim().Equals(P4, StringComparison.Ordinal) ||
             txtEditCardType.Text.Trim().Equals(P5, StringComparison.Ordinal)))
        {
            args.IsValid = false;
        }
    }
    protected void cvInsertCardType_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = true;

        TextBox txtInsertCardType = (TextBox)dvCreditCard.FindControl("InsertCardType");

        string P1 = "American Express";
        string P2 = "Diners Club";
        string P3 = "Discover";
        string P4 = "MasterCard";
        string P5 = "Visa";

        if (!(txtInsertCardType.Text.Trim().Equals(P1, StringComparison.Ordinal) ||
             txtInsertCardType.Text.Trim().Equals(P2, StringComparison.Ordinal) ||
             txtInsertCardType.Text.Trim().Equals(P3, StringComparison.Ordinal) ||
             txtInsertCardType.Text.Trim().Equals(P4, StringComparison.Ordinal) ||
             txtInsertCardType.Text.Trim().Equals(P5, StringComparison.Ordinal)))
        {
            args.IsValid = false;
        }
    }
    protected void cvEditExpiryMonth_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = true;

        TextBox txtEditExpiryMonth = (TextBox)dvCreditCard.FindControl("EditExpiryMonth");

        string M01 = "01";
        string M02 = "02";
        string M03 = "03";
        string M04 = "04";
        string M05 = "05";
        string M06 = "06";
        string M07 = "07";
        string M08 = "08";
        string M09 = "09";
        string M10 = "10";
        string M11 = "11";
        string M12 = "12";

        if (!(txtEditExpiryMonth.Text.Trim().Equals(M01, StringComparison.Ordinal) ||
             txtEditExpiryMonth.Text.Trim().Equals(M02, StringComparison.Ordinal) ||
             txtEditExpiryMonth.Text.Trim().Equals(M03, StringComparison.Ordinal) ||
             txtEditExpiryMonth.Text.Trim().Equals(M04, StringComparison.Ordinal) ||
             txtEditExpiryMonth.Text.Trim().Equals(M05, StringComparison.Ordinal) ||
             txtEditExpiryMonth.Text.Trim().Equals(M06, StringComparison.Ordinal) ||
             txtEditExpiryMonth.Text.Trim().Equals(M07, StringComparison.Ordinal) ||
             txtEditExpiryMonth.Text.Trim().Equals(M08, StringComparison.Ordinal) ||
             txtEditExpiryMonth.Text.Trim().Equals(M09, StringComparison.Ordinal) ||
             txtEditExpiryMonth.Text.Trim().Equals(M10, StringComparison.Ordinal) ||
             txtEditExpiryMonth.Text.Trim().Equals(M11, StringComparison.Ordinal) ||
             txtEditExpiryMonth.Text.Trim().Equals(M12, StringComparison.Ordinal)))
        {
            args.IsValid = false;
        }
    }
    protected void cvInsertExpiryMonth_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = true;

        TextBox txtInsertExpiryMonth = (TextBox)dvCreditCard.FindControl("InsertExpiryMonth");

        string M01 = "01";
        string M02 = "02";
        string M03 = "03";
        string M04 = "04";
        string M05 = "05";
        string M06 = "06";
        string M07 = "07";
        string M08 = "08";
        string M09 = "09";
        string M10 = "10";
        string M11 = "11";
        string M12 = "12";

        if (!(txtInsertExpiryMonth.Text.Trim().Equals(M01, StringComparison.Ordinal) ||
             txtInsertExpiryMonth.Text.Trim().Equals(M02, StringComparison.Ordinal) ||
             txtInsertExpiryMonth.Text.Trim().Equals(M03, StringComparison.Ordinal) ||
             txtInsertExpiryMonth.Text.Trim().Equals(M04, StringComparison.Ordinal) ||
             txtInsertExpiryMonth.Text.Trim().Equals(M05, StringComparison.Ordinal) ||
             txtInsertExpiryMonth.Text.Trim().Equals(M06, StringComparison.Ordinal) ||
             txtInsertExpiryMonth.Text.Trim().Equals(M07, StringComparison.Ordinal) ||
             txtInsertExpiryMonth.Text.Trim().Equals(M08, StringComparison.Ordinal) ||
             txtInsertExpiryMonth.Text.Trim().Equals(M09, StringComparison.Ordinal) ||
             txtInsertExpiryMonth.Text.Trim().Equals(M10, StringComparison.Ordinal) ||
             txtInsertExpiryMonth.Text.Trim().Equals(M11, StringComparison.Ordinal) ||
             txtInsertExpiryMonth.Text.Trim().Equals(M12, StringComparison.Ordinal)))
        {
            args.IsValid = false;
        }
    }
    protected void cvEditExpiryYear_ServerValidate(object source, ServerValidateEventArgs args)
    {
        string M01 = "01";
        string M02 = "02";
        string M03 = "03";
        string M04 = "04";
        string M05 = "05";
        string M06 = "06";
        string M07 = "07";
        string M08 = "08";
        string M09 = "09";
        string M10 = "10";
        string M11 = "11";
        string M12 = "12";

        string Month = ((TextBox)dvCreditCard.FindControl("EditExpiryMonth")).Text.ToString().Trim();
        string Year = ((TextBox)dvCreditCard.FindControl("EditExpiryYear")).Text.ToString().Trim().TrimStart('0');

        if ((Month == M01 || Month == M02 || Month == M03 || Month == M04 || Month == M05 || Month == M06 || Month == M07 || Month == M08 || Month == M09 || Month == M10 || Month == M11 || Month == M12) //&& 
            )
        {
            args.IsValid = true;

            Int16 month = Convert.ToInt16(Month.TrimStart('0'));
            Int16 year = Convert.ToInt16(Year);
            if ((month < DateTime.Now.Month) & (year <= DateTime.Now.Year))
            {
                args.IsValid = false;
            }
        }
        else
        {
            args.IsValid = false;
        }
        
    }
    protected void cvInsertExpiryYear_ServerValidate(object source, ServerValidateEventArgs args)
    {
        string M01 = "01";
        string M02 = "02";
        string M03 = "03";
        string M04 = "04";
        string M05 = "05";
        string M06 = "06";
        string M07 = "07";
        string M08 = "08";
        string M09 = "09";
        string M10 = "10";
        string M11 = "11";
        string M12 = "12";

        string Month = ((TextBox)dvCreditCard.FindControl("InsertExpiryMonth")).Text.ToString().Trim();
        string Year = ((TextBox)dvCreditCard.FindControl("InsertExpiryYear")).Text.ToString().Trim().TrimStart('0');
        //Response.Write("<script>alert('" + Month.ToString() + "')</script>");
        //Response.Write("<script>alert('" + Year.ToString() + "')</script>");

        if ((Month == M01 || Month == M02 || Month == M03 || Month == M04 || Month == M05 || Month == M06 || Month == M07 || Month == M08 || Month == M09 || Month == M10 || Month == M11 || Month == M12) //&& 
            )
        {
            args.IsValid = true;

            Int16 month = Convert.ToInt16(Month.TrimStart('0'));
            Int16 year = Convert.ToInt16(Year);
            if ((month < DateTime.Now.Month) & (year <= DateTime.Now.Year))
            {
                args.IsValid = false;
            }
        }
        else
        {
            args.IsValid = false;
        }
    }
    protected void InsertUserName_Load(object sender, EventArgs e)
    {
        ((TextBox)(sender as Control)).Text = User.Identity.Name.Trim();
        ((TextBox)(sender as Control)).ReadOnly = true;
    }
    protected void dvCreditCard_ItemInserted1(object sender, DetailsViewInsertedEventArgs e)
    {
        gvCreditCard.DataBind();
    }
    protected void dvCreditCard_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        gvCreditCard.DataBind();
    }
    protected void RemoveButton_Click(object sender, EventArgs e)
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
            Boolean currentDefault = ((CheckBox)gridViewRow.FindControl("default")).Checked;
            string currentNumber = ((Label)gridViewRow.FindControl("cardNumber")).Text.Trim();

            string queryDelete = "DELETE FROM [CreditCard] WHERE ([userName] = N'" + userName + "' AND [number] = '" + currentNumber + "')";
            //Response.Write("<script>alert('" + currentNumber + "')</script>");
            if (!currentDefault)
            {
                lblMessage.Visible = false;
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "The selected card is your default card. After deletion, your default card will be the first one appearing in your credit card list different from your original default card";


                string firstValidInGridViewNumber = "";
                for (int i = 0; i < MaxRows; i++)
                {
                    if (((Label)gvCreditCard.Rows[i].FindControl("cardNumber")).Text.Trim() != currentNumber)
                    {
                        firstValidInGridViewNumber = ((Label)gvCreditCard.Rows[i].FindControl("cardNumber")).Text.Trim();
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
            /*
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
            */
            //Data rebind
            gvCreditCard.DataBind();
            /*
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
            */
            //Response.Write("<script>alert('exit delete button')</script>");
        }
        else
        {
            lblMessage.Visible = true;
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Text = "You cannot delete the only credit card in your credit card list";
        }
    }
    protected void EditCreditCardDefault_CheckedChanged(object sender, EventArgs e)
    {
        Page.Validate();

        if (Page.IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;

            Int32 count = 0;
            //check if the item has already added into the shopping cart
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [CreditCard] WHERE ([userName] = N'" + userName + "')", connection))
            {
                command.Connection.Open();
                count = (Int32)command.ExecuteScalar();
                command.Connection.Close();
            }

            if (count <= 1)
            {
                //if the edited credit card changes from default to non default, error message.
                if (((CheckBox)(sender as Control)).Checked == false)
                {
                    ((CheckBox)(sender as Control)).Checked = true;
                    ((CheckBox)(sender as Control)).Enabled = false;
                    lblMessage2.ForeColor = System.Drawing.Color.Red;
                    lblMessage2.Text = "This is your only credit card in your credit card list. You have to have this credit card as the default credit card.";
                }
            }
            else
            {
                //if the edited credit card changes from nondefault to default, then the initial default card becomes nondefault
                if (((CheckBox)(sender as Control)).Checked == true)
                {
                    //find the initial default number for later update
                    string currentCardNumber = ((TextBox)dvCreditCard.FindControl("EditUserName")).Text.Trim();
                    string initialDefaultNumber = "";

                    string querySelect = "SELECT [number] FROM [CreditCard] WHERE ([userName] = N'" + userName + "' AND [creditCardDefault] = '" + Convert.ToString(true) + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(querySelect, connection))
                    {
                        command.Connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                initialDefaultNumber = reader.GetString(0);
                            }
                        }

                        reader.Close();
                        command.Connection.Close();
                    }

                    //Set the edited card to be default
                    string queryUpdate1 = "UPDATE [CreditCard] SET [creditCardDefault] = @creditCardDefault WHERE ([userName] = N'" + userName + "' AND [number] = '" + currentCardNumber + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate1, connection))
                    {
                        command.Connection.Open();
                        command.Parameters.AddWithValue("@creditCardDefault", true);
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }

                    //Set the initial default to be nondefault
                    string queryUpdate2 = "UPDATE [CreditCard] SET [creditCardDefault] = @creditCardDefault WHERE ([userName] = N'" + userName + "' AND [number] = '" + initialDefaultNumber + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate2, connection))
                    {
                        command.Connection.Open();
                        command.Parameters.AddWithValue("@creditCardDefault", false);
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }

                    gvCreditCard.DataBind();

                    lblMessage2.ForeColor = System.Drawing.Color.Green;
                    lblMessage2.Text = "Your default credit card has changed.";
                }
                //else the edited credit card changes from default to nondefault, then this card is set to the default
                else
                {
                    string currentCardNumber = ((TextBox)dvCreditCard.FindControl("EditUserName")).Text.Trim();
                    string changedDefaultNumber = "";

                    string querySelect = "SELECT [number] FROM [CreditCard] WHERE ([userName] = N'" + userName + "' AND [creditCardDefault] = '" + Convert.ToString(false) + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(querySelect, connection))
                    {
                        command.Connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                changedDefaultNumber = reader.GetString(0); break;
                            }
                        }

                        reader.Close();
                        command.Connection.Close();
                    }

                    //Set the edited card to be default
                    string queryUpdate1 = "UPDATE [CreditCard] SET [creditCardDefault] = @creditCardDefault WHERE ([userName] = N'" + userName + "' AND [number] = '" + changedDefaultNumber + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate1, connection))
                    {
                        command.Connection.Open();
                        command.Parameters.AddWithValue("@creditCardDefault", true);
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }

                    //Set the initial default to be nondefault
                    string queryUpdate2 = "UPDATE [CreditCard] SET [creditCardDefault] = @creditCardDefault WHERE ([userName] = N'" + userName + "' AND [number] = '" + currentCardNumber + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate2, connection))
                    {
                        command.Connection.Open();
                        command.Parameters.AddWithValue("@creditCardDefault", false);
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }

                    gvCreditCard.DataBind();

                    lblMessage2.ForeColor = System.Drawing.Color.Green;
                    lblMessage2.Text = "Your default credit card has changed.";
                }
            }
        }
        else
        {
            ((CheckBox)(sender as Control)).Checked = false;
        }
    }
    protected void dvCreditCard_Load(object sender, EventArgs e)
    {
        lblMessage.Visible = false;
    }
    protected void InsertCreditCardDefault_CheckedChanged(object sender, EventArgs e)
    {
        Page.Validate();

        if (Page.IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;

            Int32 count = 0;
            //check if the item has already added into the shopping cart
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [CreditCard] WHERE ([userName] = N'" + userName + "')", connection))
            {
                command.Connection.Open();
                count = (Int32)command.ExecuteScalar();
                command.Connection.Close();
            }

            if (count <= 1)
            {
                //if the edited credit card changes from default to non default, error message.
                if (((CheckBox)(sender as Control)).Checked == false)
                {
                    ((CheckBox)(sender as Control)).Checked = true;
                    ((CheckBox)(sender as Control)).Enabled = false;
                    lblMessage2.ForeColor = System.Drawing.Color.Red;
                    lblMessage2.Text = "This is your only credit card in your credit card list. You have to have this credit card as the default credit card.";
                }
            }
            else
            {
                //if the edited credit card changes from nondefault to default, then the initial default card becomes nondefault
                if (((CheckBox)(sender as Control)).Checked == true)
                {
                    //find the initial default number for later update
                    string currentCardNumber = ((TextBox)dvCreditCard.FindControl("InsertUserName")).Text.Trim();
                    string initialDefaultNumber = "";

                    string querySelect = "SELECT [number] FROM [CreditCard] WHERE ([userName] = N'" + userName + "' AND [creditCardDefault] = '" + Convert.ToString(true) + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(querySelect, connection))
                    {
                        command.Connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                initialDefaultNumber = reader.GetString(0);
                            }
                        }

                        reader.Close();
                        command.Connection.Close();
                    }

                    //Set the edited card to be default
                    string queryUpdate1 = "UPDATE [CreditCard] SET [creditCardDefault] = @creditCardDefault WHERE ([userName] = N'" + userName + "' AND [number] = '" + currentCardNumber + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate1, connection))
                    {
                        command.Connection.Open();
                        command.Parameters.AddWithValue("@creditCardDefault", true);
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }

                    //Set the initial default to be nondefault
                    string queryUpdate2 = "UPDATE [CreditCard] SET [creditCardDefault] = @creditCardDefault WHERE ([userName] = N'" + userName + "' AND [number] = '" + initialDefaultNumber + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate2, connection))
                    {
                        command.Connection.Open();
                        command.Parameters.AddWithValue("@creditCardDefault", false);
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }

                    gvCreditCard.DataBind();

                    lblMessage2.ForeColor = System.Drawing.Color.Green;
                    lblMessage2.Text = "Your default credit card has changed.";
                }
                //else the edited credit card changes from default to nondefault, then this card is set to the default
                else
                {
                    string currentCardNumber = ((TextBox)dvCreditCard.FindControl("EditUserName")).Text.Trim();
                    string changedDefaultNumber = "";

                    string querySelect = "SELECT [number] FROM [CreditCard] WHERE ([userName] = N'" + userName + "' AND [creditCardDefault] = '" + Convert.ToString(false) + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(querySelect, connection))
                    {
                        command.Connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                changedDefaultNumber = reader.GetString(0); break;
                            }
                        }

                        reader.Close();
                        command.Connection.Close();
                    }

                    //Set the edited card to be default
                    string queryUpdate1 = "UPDATE [CreditCard] SET [creditCardDefault] = @creditCardDefault WHERE ([userName] = N'" + userName + "' AND [number] = '" + changedDefaultNumber + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate1, connection))
                    {
                        command.Connection.Open();
                        command.Parameters.AddWithValue("@creditCardDefault", true);
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }

                    //Set the initial default to be nondefault
                    string queryUpdate2 = "UPDATE [CreditCard] SET [creditCardDefault] = @creditCardDefault WHERE ([userName] = N'" + userName + "' AND [number] = '" + currentCardNumber + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate2, connection))
                    {
                        command.Connection.Open();
                        command.Parameters.AddWithValue("@creditCardDefault", false);
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }

                    gvCreditCard.DataBind();

                    lblMessage2.ForeColor = System.Drawing.Color.Green;
                    lblMessage2.Text = "Your default credit card has changed.";
                }
            }
        }
        else
        {
            ((CheckBox)(sender as Control)).Checked = false;
        }
    }
    protected void cvEditCardNumber_ServerValidate(object source, ServerValidateEventArgs args)
    {
        GridViewRow row = gvCreditCard.SelectedRow;

        string currentCreditCardNumber = ((TextBox)dvCreditCard.FindControl("EditCardNumber")).Text.Trim();
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;

        Int32 count = 0;
        Int32 MaxRows = gvCreditCard.Rows.Count;

        for (int i = 0; i < MaxRows; i++)
        {
            if (gvCreditCard.Rows[i] != row) //not the selected row
            {
                if (((Label)gvCreditCard.Rows[i].FindControl("cardNumber")).Text.Trim() == currentCreditCardNumber)
                {
                    count++;
                }
            }
        }

        if (count == 0)
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }
    protected void cvInsertCardNumber_ServerValidate(object source, ServerValidateEventArgs args)
    {
        string currentCreditCardNumber = ((TextBox)dvCreditCard.FindControl("InsertCardNumber")).Text.Trim();
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;

        Int32 count = 0;
        //check if there is only one credit card in user's credit card list
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [CreditCard] WHERE ([userName] = N'" + userName + "' AND [number] = '" + currentCreditCardNumber + "')", connection))
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
}