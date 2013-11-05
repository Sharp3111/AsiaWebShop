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
            gvCreditCard.DataBind();
            gvCreditCard1.DataBind();
            // Populate the YearDropDownList from current year to plus 10 years.
            /*YearDropDownList.Items.Add(new ListItem("Year", "0"));
            for (int year = DateTime.Now.Year; year <= DateTime.Now.Year + 10; year++)
            {
                YearDropDownList.Items.Add(year.ToString());
            }*/

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

}