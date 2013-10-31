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
            
            //Check whether there is any item to be displayed in ShoppingCart DB for the current user
            string checkQuery = "SELECT [userName] FROM [ShoppingCart] WHERE [userName] = '" + userName + "'";
            Int32 count = 0;     
            //check if the item has already added into the shopping cart
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [ShoppingCart] WHERE ([userName] = N'" + userName + "')", connection);
                count = (Int32)command.ExecuteScalar();
                connection.Close();
            }

            //If there is no record in the current user's shopping cart
            if (count != 0)
            {
                //Display "The following items have been added to your shopping cart"
                lblMessage.Text = "The following items have been added to your shopping cart. Please click this to continue to shop around: ";

                //Populate the GridView on the webpage ShoppingCart.aspx
                GetItemInformation(connectionString, userName);

                //Populate the amendable quantity textboxes in GridView
                int i = 0;
                {
                    //SELECT quantity FROM ShoppingCart query
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
        GridViewRow gridViewRow = (GridViewRow)(source as Control).Parent.Parent;
        Int32 Row_index = gridViewRow.RowIndex;
        TextBox tbQuantity = (TextBox)gvShoppingCart.Rows[Row_index].FindControl("QuantityTextBox");
        Label lbMax = (Label)gvShoppingCart.Rows[Row_index].FindControl("MaxQuantityAvailableLabel");
        //Response.Write("<script>alert('" + Convert.ToInt32(tbQuantity.Text) + "   " + Convert.ToInt32(lbMax.Text) + "')</script>");
        if (Convert.ToInt64(tbQuantity.Text) > Convert.ToInt64(lbMax.Text)) 
            args.IsValid = false;
    }
    protected void Next_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            Response.Redirect("~/MemberOnly/DeliveryInformation.aspx");
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
        using (SqlCommand command = new SqlCommand("SELECT [upc] FROM [Item] WHERE ([name] = N'" + itemName + "')", connection))
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
        using (SqlCommand command = new SqlCommand("DELETE FROM [ShoppingCart] WHERE ([upc] = N'" + itemUPC + "' AND [userName] = N'" + userName + "')", connection))
        {
            connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }

        //get the current quantityAvailable in Item BD
        Int32 currentQuantityAvailable = 0;        
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT [quantityAvailable] FROM [Item] WHERE ([upc] = N'" + itemUPC + "')", connection))
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
        string query = "UPDATE [Item] SET [quantityAvailable] = @QuantityAvailable WHERE ([upc] = N'" + itemUPC + "')";
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
    }
}