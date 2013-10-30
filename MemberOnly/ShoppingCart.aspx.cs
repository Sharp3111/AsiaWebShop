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

public partial class MemberOnly_ShoppingCart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;
            int maxRowIndex = gvShoppingCart.Rows.Count;
            //Response.Write("<script>alert('"+gvShoppingCart.Rows[1].FindControl("QuantityDropDownList").ID+"')</script>");
            //((DropDownList)gvShoppingCart.Rows[1].FindControl("QuantityDropDownList")).Items.Add("test");

            GetItemInformation(connectionString, userName);

            //for (int i = 1; i < maxRowIndex-1; i++)
            int i = 0;
            {
                //((DropDownList)gvShoppingCart.Rows[i].FindControl("QuantityDropDownList")).Items.Add("test");
                string query = "SELECT [quantity] FROM [ShoppingCart] WHERE [userName] = '" + userName + "'";

                int intQuantity = 0;
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
                             intQuantity = reader.GetInt32(0);
                             ((TextBox)gvShoppingCart.Rows[i++].FindControl("QuantityTextBox")).Text = intQuantity.ToString();
                        }
                    }

                    // Close the connection and the DataReader.
                    command.Connection.Close();
                    reader.Close();
                }               

            }
            
        }
    }

    private void GetItemInformation(string connectionString, string userName)
    {
        string query = "SELECT [Item].[name], [Item].[discountPrice], [Item].[quantityAvailable], ([Item].[discountPrice] * [ShoppingCart].[quantity]) AS TotalPriceOfEachItem FROM [Item] JOIN [ShoppingCart] ON [Item].[upc] = [ShoppingCart].[upc] WHERE [ShoppingCart].[userName] = '" + userName + "'";

        // Execute the SQL statement; order the result by item name.
        SqlDataSource1.SelectCommand = query;
        SqlDataSource1.Select(DataSourceSelectArguments.Empty);

        gvShoppingCart.DataBind();
    }
    protected void cvQuantity_ServerValidate(object source, ServerValidateEventArgs args)
    {

    }
}