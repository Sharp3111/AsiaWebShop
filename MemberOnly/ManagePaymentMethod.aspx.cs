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

    protected void NewLink_Click(object sender, EventArgs e)
    {
        // Populate the YearDropDownList from current year to plus 10 years.
        for (int year = DateTime.Now.Year; year <= DateTime.Now.Year + 10; year++)
        {
            string Year = year.ToString().Trim();
            ((DropDownList)dvCreditCard.FindControl("insertYearDropDownList")).Items.Add(Year);
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
}