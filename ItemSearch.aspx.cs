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
public partial class _Default : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string catagory = Request.QueryString["category"];
            switch (catagory)
            {
                case "Appliances":
                    categoryDropDownList.SelectedIndex = 1;
                    btnSearch_Click(sender, e);
                    break;
                case "BabyandChildren":
                    categoryDropDownList.SelectedIndex = 2;
                    btnSearch_Click(sender, e);
                    break;
                case "ComputersandElectronics":
                    categoryDropDownList.SelectedIndex = 3;
                    btnSearch_Click(sender, e);
                    break;
                case "JewelryandWatches":
                    categoryDropDownList.SelectedIndex = 4;
                    btnSearch_Click(sender, e);
                    break;
                case "Luggage":
                    categoryDropDownList.SelectedIndex = 5;
                    btnSearch_Click(sender, e);
                    break;
                case "Men":
                    categoryDropDownList.SelectedIndex = 6;
                    btnSearch_Click(sender, e);
                    break;
                case "ToysandGames":
                    categoryDropDownList.SelectedIndex = 7;
                    btnSearch_Click(sender, e);
                    break;
                case "Women":
                    categoryDropDownList.SelectedIndex = 8;
                    btnSearch_Click(sender, e);
                    break;
            }
        }
        ValidationSummary1.Enabled = false;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        // Get the search string and the category from the search page.
        string itemSearchCondition = "";
        string searchString = txtSearchString.Text.Trim();
        string category = categoryDropDownList.SelectedValue.Trim();

        // Construct the basic SELECT statement for searching; only visible items should be displayed.
        string SQLCmd = "SELECT [upc], [name], [picture], [normalPrice], [discountPrice], [quantityAvailable] FROM [Item] WHERE (([visible] = 'true')";

        // Hide and clear the search result message.
        lblSearchResultMessage.Visible = false;
        lblSearchResultMessage.Text = "";

        // If a search string is specified, but no radio button is selected, ignore the search string.
        if (searchString != "" & !cbItemName.Checked & !cbItemDescription.Checked)
        {
            searchString = "";
            lblSearchResultMessage.Text = " (Name or Description not selected.)";
        }

        // If no search string is specified, but a category is specified, modify the
        // SELECT statement to search only in the specified category.
        if (searchString == "")
        {
            if (category != "All Categories")
            {
                SQLCmd = SQLCmd + " AND ([category] = N'" + category + "')";
            }
        }
        // If a search string is specified, then modify the SELECT statement to retrieve
        // matching items either in all categories or in a specified category. 
        else
        {
            // Determine whether to search in name only, description only or both name
            // and description based on whether only one or both checkboxes are checked.
            if (cbItemName.Checked & !cbItemDescription.Checked)
            {
                // Search in name only.
                itemSearchCondition = " AND ([name] LIKE N'%" + searchString + "%')";
            }
            if (!cbItemName.Checked & cbItemDescription.Checked)
            {
                // Search in description only.
                itemSearchCondition = " AND ([description] LIKE N'%" + searchString + "%')";
            }
            if (cbItemName.Checked & cbItemDescription.Checked)
            // Search in both name and description.
            {
                itemSearchCondition = " AND (([name] LIKE N'%" + searchString + "%') OR ([description] LIKE N'%" + searchString + "%'))";
            }
            if (category == "All Categories")
            {
                SQLCmd = SQLCmd + itemSearchCondition;
            }
            else
            {
                SQLCmd = SQLCmd + itemSearchCondition + " AND ([category] = N'" + category + "')";
            }
        }

        // Execute the SQL statement; order the result by item name.
        AsiaWebShopDBSqlDataSource.SelectCommand = SQLCmd + ") ORDER BY [name]";
        AsiaWebShopDBSqlDataSource.Select(DataSourceSelectArguments.Empty);

        // Bind the search result to the GridView control.
        gvItemSearchResult.DataBind();

        // Display a no result message if nothing was retrieved from the database.
        if (gvItemSearchResult.Rows.Count == 0)
        {
            lblSearchResultMessage.Text = "No records match your query." + lblSearchResultMessage.Text;
            lblSearchResultMessage.Visible = true;
        }
        else
        {
            lblSearchResultMessage.Text = "The following records match your query." + lblSearchResultMessage.Text;
            lblSearchResultMessage.Visible = true;
        }

        for (int i = 0; i < gvItemSearchResult.Rows.Count; i++)
        {
            ((TextBox)gvItemSearchResult.Rows[i].FindControl("tbQuantity")).ValidationGroup = "QuantityValidationGroup" + i;
            ((RegularExpressionValidator)gvItemSearchResult.Rows[i].FindControl("revQuantity")).ValidationGroup = "QuantityValidationGroup" + i;
            ((CustomValidator)gvItemSearchResult.Rows[i].FindControl("cvQuantity")).ValidationGroup = "QuantityValidationGroup" + i;
            ((Button)gvItemSearchResult.Rows[i].FindControl("btn_ShoppingCart")).ValidationGroup = "QuantityValidationGroup" + i;
        }
        //ValidationSummary1.Enabled = true;

    }

    protected void btn_ShoppingCart_Click(object sender, EventArgs e)
    {
        GridViewRow gridViewRow = (GridViewRow)(sender as Control).Parent.Parent;
        Int32 Row_index = gridViewRow.RowIndex;
        ValidationSummary1.Enabled = true;
        ValidationSummary1.ValidationGroup = "QuantityValidationGroup" +Row_index;
        //Response.Write("<script>alert('" + Row_index + "  " + ((Button)(sender as Control)).ValidationGroup + "')</script>");
        //check if the user has logined
        if (IsValid)
        {
            if (User.Identity.Name != "")
            {
                string connectionString = "AsiaWebShopDBConnectionString";
                string userName = User.Identity.Name;
                string upc = gvItemSearchResult.DataKeys[Row_index][0].ToString().Trim();
                TextBox quantity_textbox = (TextBox)gvItemSearchResult.Rows[Row_index].FindControl("tbQuantity");
                Int32 quantity = Convert.ToInt32(quantity_textbox.Text.Trim());
                Int32 count;

                //check if the item has already added into the shopping cart
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
                {

                    connection.Open();
                    SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [ShoppingCart] WHERE ([upc] = N'" + upc + "' AND [userName] = N'" + userName + "')", connection);
                    count = (Int32)command.ExecuteScalar();
                    connection.Close();
                }

                //if the item is not in the shopping cart, then add it into shopping cart
                if (count == 0)
                {
                    string SQLCmd = "INSERT INTO [ShoppingCart] " +
                        "VALUES (@UserName, @Upc, @Quantity, CURRENT_TIMESTAMP )";

                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(SQLCmd, connection))
                    {
                        // Define the INSERT query parameters and their values.
                        command.Parameters.AddWithValue("@UserName", userName);
                        command.Parameters.AddWithValue("@Upc", upc);
                        command.Parameters.AddWithValue("@Quantity", quantity);

                        // Open the connection, execute the INSERT query and close the connection.
                        command.Connection.Open();
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }
                }
                //if the item is already in the shopping cart, change the quantity of it    
                else
                {
                    //read the quantity in the database
                    {
                        string query = "SELECT [quantity] FROM [ShoppingCart] WHERE ([upc] = N'" + upc + "' AND [userName] = N'" + userName + "')";

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
                                    quantity += reader.GetInt32(0);
                                }
                            }

                            // Close the connection and the DataReader.
                            command.Connection.Close();
                            reader.Close();
                        }
                    }
                    //update the quantity to database
                    {
                        // Define the UPDATE query with parameters.
                        string query = "UPDATE [ShoppingCart] SET [quantity] = @quantity, [addDateTime] = CURRENT_TIMESTAMP WHERE ([userName] = @UserName AND [upc] = @Upc ) ";

                        // Create the connection and the SQL command.
                        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            // Define the UPDATE query parameters and their values.
                            command.Parameters.AddWithValue("@UserName", userName);
                            command.Parameters.AddWithValue("@Upc", upc);
                            command.Parameters.AddWithValue("@Quantity", quantity);

                            // Open the connection, execute the INSERT query and close the connection.
                            command.Connection.Open();
                            command.ExecuteNonQuery();
                            command.Connection.Close();
                        }
                    }
                }


                //lblSearchResultMessage.Text="Successfully add to shopping cart";
                Response.Write("<script>alert('Successfully add to shopping cart')</script>");
            }
            else // if the user does not log, send a error message
            {
                Response.Write("<script>alert('Please Login')</script>");
            }
        }
    }
    protected void categoryDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void cvQuantity_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if(IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;
            GridViewRow gridViewRow = (GridViewRow)(source as Control).Parent.Parent;
            int Row_index = gridViewRow.RowIndex;
            string upc = gvItemSearchResult.DataKeys[Row_index][0].ToString().Trim();
            TextBox quantity_textbox = (TextBox)gvItemSearchResult.Rows[Row_index].FindControl("tbQuantity");
            Int32 quantity =Convert.ToInt32(quantity_textbox.Text.Trim());
            Int32 avaiableQuantity = 0;
        
            //read the quantity in the shopping cart database
                    
            string query = "SELECT [quantity] FROM [ShoppingCart] WHERE ([upc] = N'" + upc + "' AND [userName] = N'" + userName + "')";

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
                        quantity += reader.GetInt32(0);
                    }
                }

                // Close the connection and the DataReader.
                command.Connection.Close();
                reader.Close();
            }

            //read the available quantity in the item database

            query = "SELECT [quantityAvailable] FROM [Item] WHERE ([upc] = N'" + upc + "')";

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
                        avaiableQuantity = reader.GetInt32(0);
                    }
                }

                // Close the connection and the DataReader.
                command.Connection.Close();
                reader.Close();
            }

            if (quantity > avaiableQuantity)
                args.IsValid = false;
        }
   }
}