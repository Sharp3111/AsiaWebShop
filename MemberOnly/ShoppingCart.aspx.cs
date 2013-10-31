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
            //create connectionString
            string connectionString = "AsiaWebShopDBConnectionString";
            //create userName for current session
            string userName = User.Identity.Name;
            //count number of rows in GridView
            int maxRowIndex = gvShoppingCart.Rows.Count;

            //Check whether there is any item to be displayed in ShoppingCart DB for the current user by counting userName record
            string checkQuery = "SELECT [userName] FROM [ShoppingCart] WHERE [userName] = '" + userName + "'";
            Int32 count = 0;     
            //check if the item has already added into the shopping cart
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [ShoppingCart] WHERE ([userName] = N'" + userName + "')", connection))
            {
                command.Connection.Open();                
                count = (Int32)command.ExecuteScalar();
                command.Connection.Close();
            }


            //If there are records in the current user's shopping cart
            if (count != 0)
            {
                //Display "The following items have been added to your shopping cart"
                lblMessage.Text = "The following items have been added to your shopping cart. Please click this to continue to shop around: ";

                //Populate the GridView on the webpage ShoppingCart.aspx
                GetItemInformation(connectionString, userName);
                AccumulateTotalPrice(connectionString, userName);
            }
            //if there is no record in ShoppingCartDB
            else 
            {
                lblMessage.Text = "You do not have any item in shopping cart. Please click this to go shopping: ";
                if (lblMessage.ForeColor != System.Drawing.Color.Red)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    lblMessage.ForeColor = new System.Drawing.Color();
                }
            }            
        }
    }

    private void AccumulateTotalPrice(string connectionString, string userName)
    {
        //Check whether there is any item to be displayed in ShoppingCart DB for the current user
        string checkQuery = "SELECT [userName] FROM [ShoppingCart] WHERE [userName] = '" + userName + "'";
        Int32 count = 0;
        //check if the item has already added into the shopping cart
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [ShoppingCart] WHERE ([userName] = '" + userName + "')", connection))
        {
            command.Connection.Open();          
            count = (Int32)command.ExecuteScalar();
            command.Connection.Close();
        }


        //If there are records in the current user's shopping cart, proceed to accumulate total price
        if (count != 0)
        {
            //Accumulate total price
            decimal Price = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand("SELECT [ShoppingCart].[quantity], [Item].[discountPrice] FROM [Item] JOIN [ShoppingCart] ON [Item].[upc] = [ShoppingCart].[upc] WHERE ([ShoppingCart].[userName] = '" + userName + "')", connection))
            {
                command.Connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                // Check if a result was returned.
                if (reader.HasRows)
                {
                    // Iterate through the table to get the retrieved values.
                    while (reader.Read())
                    {
                        // Assign the data values to itemUPC
                        int quantity = Convert.ToInt32(reader["quantity"].ToString().Trim());
                        decimal unitPurchasePrice = Convert.ToDecimal(reader["discountPrice"].ToString().Trim());

                        Price += quantity * unitPurchasePrice;
                    }
                }

                // Close the connection and the DataReader.
                command.Connection.Close();
                reader.Close();
            }
            TotalPriceLabel.Text = Price.ToString();
        }
        //if there is no record in ShoppingCartDB
        else
        {
            TotalPriceLabel.Text = "- -";
        }
    }

    private void GetItemInformation(string connectionString, string userName)
    {
        string queryPopulate = "SELECT [Item].[upc], [Item].[name], [Item].[discountPrice], [Item].[quantityAvailable], ([Item].[discountPrice] * [ShoppingCart].[quantity]) AS TotalPriceOfEachItem FROM [Item] JOIN [ShoppingCart] ON [Item].[upc] = [ShoppingCart].[upc] WHERE [ShoppingCart].[userName] = '" + userName + "'";

        // Execute the SQL statement; order the result by item name.
        SqlDataSource1.SelectCommand = queryPopulate;
        SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        gvShoppingCart.DataBind();


        //Populate the amendable quantity textboxes in GridView
        int i = 0;
        {
            //SELECT quantity FROM ShoppingCart query
            string querySelect = "SELECT [quantity] FROM [ShoppingCart] WHERE [userName] = '" + userName + "'";

            int intQuantity = 0;
            // Create the connection and the SQL command.
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(querySelect, connection))
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
    protected void cvQuantity_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (IsValid)
        {
            //create connectionString
            string connectionString = "AsiaWebShopDBConnectionString";
            //create userName for current session
            string userName = User.Identity.Name;

            GridViewRow gridViewRow = (GridViewRow)(source as Control).Parent.Parent;
            Int32 Row_index = gridViewRow.RowIndex;
            TextBox tbQuantity = (TextBox)gvShoppingCart.Rows[Row_index].FindControl("QuantityTextBox");
            Label lbMax = (Label)gvShoppingCart.Rows[Row_index].FindControl("QuantityAvailableLabel");
            string itemName = ((Label)gvShoppingCart.Rows[Row_index].FindControl("NameLabel")).Text;
            Label lbUPC = (Label)gvShoppingCart.Rows[Row_index].FindControl("lbUPC");
            string itemUPC = lbUPC.Text;

            //Get the initial quantity in database for later comparison
            Int32 initialQuantity = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand("SELECT [quantity] FROM [ShoppingCart] WHERE ([userName] = '" + userName + "' AND [upc] = '" + itemUPC + "')", connection))
            {
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                // Check if a result was returned.
                if (reader.HasRows)
                {
                    // Iterate through the table to get the retrieved values.
                    while (reader.Read())
                    {
                        // Assign the data values to initialQuantity
                        initialQuantity = Convert.ToInt32(reader["quantity"].ToString().Trim());
                        //Response.Write("<script>alert('" + reader["quantity"].ToString().Trim() + "')</script>");
                        //Response.Write("<script>alert('" + (Convert.ToInt32(tbQuantity.Text) - initialQuantity).ToString().Trim() + "')</script>");
                    }
                }
            }

            if (Convert.ToInt32(tbQuantity.Text) - initialQuantity > Convert.ToInt32(lbMax.Text))
                args.IsValid = false;
        }
    }
    protected void Next_Click(object sender, EventArgs e)
    {
        //create connectionString
        string connectionString = "AsiaWebShopDBConnectionString";
        //create userName for current session
        string userName = User.Identity.Name;

        //Check whether there is any item to be displayed in ShoppingCart DB for the current user
        string checkQuery = "SELECT [userName] FROM [ShoppingCart] WHERE [userName] = '" + userName + "'";
        Int32 count = 0;
        //check if the item has already added into the shopping cart
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [ShoppingCart] WHERE ([userName] = N'" + userName + "')", connection))
        {
            command.Connection.Open();
            count = (Int32)command.ExecuteScalar();
            command.Connection.Close();
        }

        if (IsValid && count != 0)
        {
            UpdateItemInformationInDB(connectionString, userName);
            Response.Redirect("~/MemberOnly/DeliveryInformation.aspx");
        }
        else if (IsValid && count == 0)
        {
            lblMessage.Text = "Your shopping cart is currently empty. You have to have at least one item in your shopping cart in order to proceed. Please shop around: ";
        }
    }

    private void UpdateItemInformationInDB(string connectionString, string userName)
    {
        Int32 MaxIndex = gvShoppingCart.Rows.Count;
        for(int i = 1; i < MaxIndex; i++)
        {
            //get textBoxQuantity
            TextBox tbQuantity = (TextBox)gvShoppingCart.Rows[i].FindControl("QuantityTextBox");
            Int32 textBoxQuantity = Convert.ToInt32(tbQuantity.Text);

            //get labelQuantityAvailable
            Label lbMax = (Label)gvShoppingCart.Rows[i].FindControl("QuantityAvailableLabel");
            Int32 labelQuantityAvailable = Convert.ToInt32(lbMax.Text);

                //get itemUPC
                Label lbUPC = (Label)gvShoppingCart.Rows[i].FindControl("lbUPC");
                string itemUPC = lbUPC.Text;   

                //get initialShoppingCartQuantity in ShoppingCart DB
                Int32 initialShoppingCartQuantity = 0;
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand("SELECT [quantity] FROM [ShoppingCart] WHERE ([userName] = '" + userName + "' AND [upc] = '" + itemUPC +"')", connection))
                {
                    command.Connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    // Check if a result was returned.
                    if (reader.HasRows)
                    {   // Assign the data values to itemUPC
                        while (reader.Read())
                        {
                            initialShoppingCartQuantity = reader.GetInt32(0); //Response.Write("<script>alert('" + initialShoppingCartQuantity.ToString().Trim() + "'</script>");
                        }                                           
                    }

                    // Close the connection and the DataReader.
                    command.Connection.Close();
                    reader.Close();
                }


                //get initialItemQuantity in Item DB
                Int32 initialItemQuantity = 0;
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand("SELECT [quantityAvailable] FROM [Item] WHERE ([upc] = '" + itemUPC + "')", connection))
                {
                    command.Connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    // Check if a result was returned.
                    if (reader.HasRows)
                    {   // Assign the data values to itemUPC
                        while (reader.Read())
                        {
                            initialItemQuantity = reader.GetInt32(0); 
                        }  
                    }

                    // Close the connection and the DataReader.
                    command.Connection.Close();
                    reader.Close();
                }

                Int32 difference = textBoxQuantity - initialShoppingCartQuantity;

            //update Item DB
            string queryUpdateItem = "UPDATE [Item] SET [quantityAvailable] = @QuantityAvailable WHERE ([upc] = '" + itemUPC + "')";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(queryUpdateItem, connection))
            {
                //Define the UPDATE query parameters with corresponding values
                command.Parameters.AddWithValue("@QuantityAvailable", (initialItemQuantity - difference).ToString());

                // Open the connection, execute the UPDATE query and close the connection.
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }

            //update ShoppingCart DB
            string queryUpdateShoppingCart = "UPDATE [ShoppingCart] SET [quantity] = @Quantity WHERE ([userName] = '" + userName + "' AND [upc] = '" + itemUPC + "')";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(queryUpdateShoppingCart, connection))
            {
                //Define the UPDATE query parameters with corresponding values
                command.Parameters.AddWithValue("@Quantity", (initialShoppingCartQuantity + difference).ToString());

                // Open the connection, execute the UPDATE query and close the connection.
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }        
    }

    protected void deleteButton_Click(object sender, EventArgs e)
    {
        GridViewRow gridViewRow = (GridViewRow)(sender as Control).Parent.Parent;
        Int32 Row_index = gridViewRow.RowIndex;

        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;
        string itemName = ((Label)gvShoppingCart.Rows[Row_index].FindControl("NameLabel")).Text;
        //get upc of this item
        string itemUPC = "";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT [upc] FROM [Item] WHERE ([name] = '" + itemName + "')", connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            // Check if a result was returned.
            if (reader.HasRows)
            {
                // Iterate through the table to get the retrieved values.
                while (reader.Read())
                {
                    // Assign the data values to itemUPC
                    itemUPC = reader["upc"].ToString().Trim();                    
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }

        //get quantity for later use of updating quantityAvailable in Item
        TextBox quantity_textbox = (TextBox)gvShoppingCart.Rows[Row_index].FindControl("QuantityTextBox");
        Int32 quantity = Convert.ToInt32(quantity_textbox.Text.Trim());

        //delete the item in ShoppingCart DB
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("DELETE FROM [ShoppingCart] WHERE ([upc] = '" + itemUPC + "' AND [userName] = '" + userName + "')", connection))
        {
            connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }

        //get the current quantityAvailable in Item BD
        Int32 currentQuantityAvailable = 0;        
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT [quantityAvailable] FROM [Item] WHERE ([upc] = '" + itemUPC + "')", connection))
        {
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            // Check if a result was returned.
            if (reader.HasRows)
            {
                // Iterate through the table to get the retrieved values.
                while (reader.Read())
                {
                    // Assign the data values to itemUPC
                    currentQuantityAvailable = reader.GetInt32(0);
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }

        //get the updated currentQuantityAvailable
        currentQuantityAvailable += quantity;
        //update quantityAvailable in Item DB with quantity and currentQuantityAvailable
        string query = "UPDATE [Item] SET [quantityAvailable] = @QuantityAvailable WHERE ([upc] = '" + itemUPC + "')";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        {
            SqlCommand command = new SqlCommand(query, connection);
            {
                //Define the UPDATE query parameters with corresponding values
                command.Parameters.AddWithValue("@QuantityAvailable", currentQuantityAvailable.ToString());

                // Open the connection, execute the INSERT query and close the connection.
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }            
        }
        //Response.Write("<script>alert('Hehe')</script>");
        GetItemInformation(connectionString, userName);
        //Response.Write("<script>alert('Haha')</script>");
        AccumulateTotalPrice(connectionString, userName);
    }
    
    
    protected void QuantityTextBox_TextChanged(object sender, EventArgs e)
    {
        Page.Validate("ShoppingCartValidation");
        //Response.Write("<script>alert('Hehe')</script>");
        if(Page.IsValid)
        {
            
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;
            GetItemInformation(connectionString, userName);
            AccumulateTotalPrice(connectionString, userName);
            //UpdateItemInformationInDB(connectionString, userName);
        }
        //Response.Write("<script>alert('Hehe')</script>");
    }
}