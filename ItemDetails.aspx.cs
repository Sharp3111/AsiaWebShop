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

public partial class ItemDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btn_ShoppingCart_Click(object sender, EventArgs e)
    {
        //check if the user has logined
        if (IsValid)
        {
            if (User.Identity.Name != "")
            {
                string connectionString = "AsiaWebShopDBConnectionString";
                string userName = User.Identity.Name;
                string upc = dvItemDetails.DataKey[0].ToString().Trim();
                TextBox quantity_textbox = (TextBox)dvItemDetails.FindControl("tbQuantity");
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



                Response.Redirect("~/MemberOnly/ShoppingCart.aspx");
            }
            else // if the user does not log, send a error message
            {
                Response.Write("<script>alert('Please Login')</script>");
            }
        }
    }
    protected void cvQuantity_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;
            string upc = dvItemDetails.DataKey[0].ToString().Trim();
            TextBox quantity_textbox = (TextBox)dvItemDetails.FindControl("tbQuantity");
            Int32 quantity = Convert.ToInt32(quantity_textbox.Text.Trim());
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