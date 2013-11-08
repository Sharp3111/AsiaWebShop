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
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;

            //GridView.DataKeyNames 
            UserName.Text = userName;

            //GetCreditCardInformationForGridView(connectionString, userName);

        }
    }

    private void GetCreditCardInformationForGridView(string connectionString, string userName)
    {
        string querySelect = "SELECT * FROM [CreditCard] WHERE [userName] = N'" + userName + "'";

        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(querySelect, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            int i = 0;
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    ((Label)gvCreditCard.Rows[i].FindControl("cardNumber")).Text = reader["number"].ToString().Trim();               
                    ((Label)gvCreditCard.Rows[i].FindControl("cardType")).Text = reader["type"].ToString().Trim();
                    ((Label)gvCreditCard.Rows[i].FindControl("cardHolderName")).Text = reader["cardHolderName"].ToString().Trim();
                    ((Label)gvCreditCard.Rows[i].FindControl("expiryMonth")).Text = reader["expiryMonth"].ToString().Trim();
                    ((Label)gvCreditCard.Rows[i].FindControl("expiryYear")).Text = reader["expiryYear"].ToString().Trim();
                    ((CheckBox)gvCreditCard.Rows[i++].FindControl("default")).Checked = Convert.ToBoolean(reader["creditCardDefault"]);
                }
            }

        }
    }

  
    protected void EditLink_Click(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;

        //Manually populate Credit Card Type
        string querySelectType = "SELECT [type] FROM [CreditCard] WHERE ([userName] = N'" + userName + "' AND [number] = '" + ((Label)dvCreditCard.FindControl("cardNumber")).Text + "')";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(querySelectType, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    ((DropDownList)dvCreditCard.FindControl("editCardTypeDropDownList")).Text = reader.GetString(0);
                }
            }
        }


        //Manually populate Expiry Month


        //Manually populate Expiry Year
    }
    protected void insertYearDropDownList_Load(object sender, EventArgs e)
    {
        // Populate the YearDropDownList from current year to plus 10 years.
        for (int year = DateTime.Now.Year; year <= DateTime.Now.Year + 10; year++)
        {
            string Year = year.ToString().Trim();
            ((DropDownList)(sender as Control)).Items.Add(Year);
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
}