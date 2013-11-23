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

            //GridView.DataKeyNames 
            UserName.Text = userName;

            //count number of rows in GridView
            int maxRowIndex = gvShoppingCart.Rows.Count;

            //Check whether there is any item to be displayed in ShoppingCart DB for the current user by counting userName record
            //string checkQuery = "SELECT [userName] FROM [ShoppingCart] WHERE [userName] = '" + userName + "'";
            Int32 count = 0;     
            //check if the item has already added into the shopping cart
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [ShoppingCart] WHERE ([userName] = N'" + userName + "')", connection))
            {
                command.Connection.Open();                
                count = (Int32)command.ExecuteScalar();
                command.Connection.Close();
            }

            //Twist ShoppingCart - make all isChecked's true
            string twist = "UPDATE ShoppingCart SET isChecked = '" + true + "' WHERE ([userName] = N'" + userName + "')";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(twist, connection))
            {

                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }

            //If there are records in the current user's shopping cart
            if (count != 0)
            {
                //Display "The following items have been added to your shopping cart"
                lblMessage.Text = "The following items have been added to your shopping cart. Please click this to continue to shop around: ";

                //Populate the GridView on the webpage ShoppingCart.aspx
                GetItemInformation(connectionString, userName);                
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
            updateShoppingCart(connectionString, userName,count);
            AccumulateTotalPrice(connectionString, userName);
            gvShoppingCart.DataBind();
            if (Session["ReserveFailed"] == "True")
                Page.Validate();
        }
    }



    private void updateShoppingCart(string connectionString, string userName,int count)
    {
        string[] upc = new string[count];
        decimal[] shoppingprice = new decimal[count];
        bool[] itemVisible = new bool[count]; 
        int i = 0;
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT [upc] FROM [ShoppingCart] WHERE ([userName] = N'" + userName + "')", connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    upc[i] = reader["upc"].ToString().Trim();
                    i++;
                }
            }
            command.Connection.Close();
        }
        for (i = 0; i < count; i++)
        {
            itemVisible[i] = visibleCheck(connectionString, upc[i]);
            if (itemVisible[i] == false)
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand("DELETE FROM [ShoppingCart] WHERE ([upc] = '" + upc[i] + "' AND [userName] = '" + userName + "')", connection))
                {
                    connection.Open();
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                }
            }
        }


        i = 0;
        upc = new string[count];
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT [upc],[unitPrice] FROM [ShoppingCart] WHERE ([userName] = N'" + userName + "')", connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    upc[i] = reader["upc"].ToString().Trim();
                    shoppingprice[i] = Convert.ToDecimal(reader["unitPrice"]);
                    i++;
                }
            }
            command.Connection.Close();
        }
        for (i = 0; i < count; i++)
        {
            decimal itemPrice =  findItemPrice(connectionString,upc[i]);
            if(shoppingprice[i] > itemPrice) {
                updatePrice(connectionString,upc[i],itemPrice);
            }
        }


    }

    private bool visibleCheck(string connectionString, string upc)
    {
        bool visible = true;
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT [visible] FROM [Item] WHERE ([upc] = N'" + upc + "')", connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                     visible = Convert.ToBoolean(reader["visible"]);
                }
            }
            command.Connection.Close();
        }
        return visible;
    }

    private decimal findItemPrice(string connectionString, string upc)
    {
        decimal price = 0;
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT [discountPrice] FROM [Item] WHERE ([upc] = N'" + upc + "')", connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    price = Convert.ToDecimal(reader["discountPrice"]);
                }
            }
            command.Connection.Close();
        }
        return price;
    }

    private void updatePrice(string connectionString,string upc, decimal price)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("UPDATE [ShoppingCart] SET [unitPrice] = '"+price.ToString().Trim()+"' WHERE ([upc] = N'" + upc + "')", connection))
        {
            command.Connection.Open();
            command.ExecuteReader();
            command.Connection.Close();
        }
    }


    private void AccumulateTotalPrice(string connectionString, string userName)
    {
        //Check whether there is any item to be displayed in ShoppingCart DB for the current user
        //string checkQuery = "SELECT [userName] FROM [ShoppingCart] WHERE [userName] = '" + userName + "'";
        Int32 count = 0;
        //check if the item has already been added into the shopping cart
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [ShoppingCart] WHERE ([userName] = N'" + userName + "')", connection))
        {
            command.Connection.Open();          
            count = (Int32)command.ExecuteScalar();
            command.Connection.Close();
        }

        //If there are records in the current user's shopping cart, proceed to accumulate total price
        if (count != 0)
        {
            //Accumulate total price and selected total price
            decimal TotalPrice = 0;
            decimal SelectedTotalPrice = 0;
            Int32 MaxRows = gvShoppingCart.Rows.Count;

            for (int i = 0; i < MaxRows; i++)
            {
                string currentUPC = ((Label)gvShoppingCart.Rows[i].FindControl("lbUPC")).Text.Trim();
                //check whether the item is invisible
                Boolean currentIsVisible = true;
                string queryInvisible = "SELECT visible FROM [Item] WHERE upc = '" + currentUPC + "'";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand(queryInvisible, connection))
                {
                    command.Connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            currentIsVisible = Convert.ToBoolean(reader["visible"].ToString().Trim());
                        }
                    }
                    command.Connection.Close();
                }

                if (currentIsVisible)
                {
                    bool selected = ((CheckBox)gvShoppingCart.Rows[i].FindControl("SelectLabel")).Checked;
                    decimal totalPriceOfEachItem = Convert.ToDecimal(((Label)gvShoppingCart.Rows[i].FindControl("TotalPriceOfEachItemLabel")).Text.ToString().Trim());

                    if (selected)
                    {
                        SelectedTotalPrice += totalPriceOfEachItem;
                    }

                    TotalPrice += totalPriceOfEachItem;
                }
            }

            SelectedPriceLabel.Text = SelectedTotalPrice.ToString();
            TotalPriceLabel.Text = TotalPrice.ToString();
        }
        //if there is no record in ShoppingCartDB
        else
        {
            SelectedPriceLabel.Text = "- -";
            TotalPriceLabel.Text = "- -";
        }
    }

    private void GetItemInformation(string connectionString, string userName)
    {
        string queryPopulate = "SELECT [Item].[upc], [Item].[name], [Item].[discountPrice] AS unitPrice, [Item].[quantityAvailable], [ShoppingCart].[quantity], ([Item].[discountPrice] * [ShoppingCart].[quantity]) AS TotalPriceOfEachItem FROM [Item] JOIN [ShoppingCart] ON [Item].[upc] = [ShoppingCart].[upc] WHERE [ShoppingCart].[userName] = '" + userName + "'";

        
        // Execute the SQL statement; order the result by item name.
        SqlDataSource1.SelectCommand = queryPopulate;
        SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        gvShoppingCart.DataBind();
        //System.Diagnostics.Debug.WriteLine(gvShoppingCart.Rows.Count);
        

        //Populate the amendable quantity textboxes in GridView
        int i = 0;
        {
            //SELECT quantity FROM ShoppingCart query
            string querySelect = "SELECT [quantity], [isChecked] FROM [ShoppingCart] WHERE [userName] = '" + userName + "'";

            int intQuantity = 0;
            Boolean IsChecked = true;
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
                        ((TextBox)gvShoppingCart.Rows[i].FindControl("QuantityTextBox")).Text = intQuantity.ToString();
                        //Response.Write("<script>alert('" + intQuantity.ToString().Trim() + "')</script>");
                        IsChecked = reader.GetBoolean(1);
                        ((CheckBox)gvShoppingCart.Rows[i++].FindControl("SelectLabel")).Checked = IsChecked;
                        //Response.Write("<script>alert('" + IsChecked.ToString().Trim() + "')</script>");
                        //Response.Write("<script>alert('" + ((CheckBox)gvShoppingCart.Rows[i++].FindControl("SelectLabel")).Checked.ToString().Trim() + "')</script>");
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

            //Check whether the 15 min session has passed
            string querySelectIsReleased = "SELECT isReleased FROM [ShoppingCart] WHERE (upc = '" + itemUPC + "' AND userName = '" + userName + "')";
            Boolean currentItemIsReleased = false;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(querySelectIsReleased, connection))
            {
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                // Check if a result was returned.
                if (reader.HasRows)
                {
                    // Iterate through the table to get the retrieved values.
                    while (reader.Read())
                    {
                        // Assign the data values to currentItemIsReleased
                        currentItemIsReleased = Convert.ToBoolean(reader["isReleased"].ToString().Trim());
                        //Response.Write("<script>alert('" + reader["quantity"].ToString().Trim() + "')</script>");
                        //Response.Write("<script>alert('" + (Convert.ToInt32(tbQuantity.Text) - initialQuantity).ToString().Trim() + "')</script>");
                    }
                }
            }

            //15 min session has not passed
            if (!currentItemIsReleased)
            {
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
            //15 min session has passed
            else
            {
                //Get the quantityAvailable in Item DB
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
                            // Assign the data values to initialQuantity
                            currentQuantityAvailable = Convert.ToInt32(reader["quantityAvailable"].ToString().Trim());
                            //Response.Write("<script>alert('" + reader["quantity"].ToString().Trim() + "')</script>");
                            //Response.Write("<script>alert('" + (Convert.ToInt32(tbQuantity.Text) - initialQuantity).ToString().Trim() + "')</script>");
                        }
                    }
                }
                if (Convert.ToInt32(tbQuantity.Text) > currentQuantityAvailable)
                    args.IsValid = false;
            }
        }
    }
    protected void Next_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            //create connectionString
            string connectionString = "AsiaWebShopDBConnectionString";
            //create userName for current session
            string userName = User.Identity.Name;

            //Check whether there is any item to be displayed in ShoppingCart DB for the current user            
            Int32 countShoppingCart = 0;
            //check if the item has already added into the shopping cart
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [ShoppingCart] WHERE ([userName] = N'" + userName + "')", connection))
            {
                command.Connection.Open();
                countShoppingCart = (Int32)command.ExecuteScalar();
                command.Connection.Close();
            }

            //Check the number of checkBoxes that are checked
            Int32 MaxRow = gvShoppingCart.Rows.Count;
            Int32 countCheckBox = 0;
            for (int i = 0; i < MaxRow; i++)
            {
                CheckBox currentCheck = (CheckBox)gvShoppingCart.Rows[i].FindControl("SelectLabel");
                Boolean currentIsChecked = currentCheck.Checked;

                if (currentIsChecked)
                {
                    countCheckBox++;
                }
            }

            //ShoppingCart is nonempty
            if (countShoppingCart != 0)
            {
                //UpdateItemInformationInDB(connectionString, userName);
                UpdateOrderRecord(connectionString, userName);
                //All checkBox.Checked == false;
                if (countCheckBox != 0)
                {
                    UpdateItemDatabase(connectionString, userName);
                    ShopAround.Visible = true;
                    Response.Redirect("~/MemberOnly/DeliveryInformation.aspx");
                }
                //There is at least one checkBox.Checked == true;
                else
                {
                    lblMessage.Text = "You have not select items to check out. To check out, please select at least one item. ";
                    ShopAround.Visible = false;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            //ShoppingCart is empty
            else if (countShoppingCart == 0)
            {
                AccumulateTotalPrice(connectionString, userName);
                lblMessage.Text = "Your shopping cart is currently empty. You have to have at least one item in your shopping cart in order to proceed. Please shop around: ";
                ShopAround.Visible = true;
            }
        }
    }

    private void UpdateItemDatabase(string connectionString, string userName)
    {
        Int32 MaxRow = gvShoppingCart.Rows.Count;

        //loop the user's shopping cart to check whether the item is checked upon proceeding to next.
        //if the item is checked, then the quantity of this item should be decremented in the Item DB
        //if the item is unchecked, then nothing needs to be done
        for (int i = 0; i < MaxRow; i++)
        {
            Boolean currentIsSelected = false;
            currentIsSelected = ((CheckBox)gvShoppingCart.Rows[i].FindControl("SelectLabel")).Checked;

            if (currentIsSelected)
            {
                string currentItemUPC = ((Label)gvShoppingCart.Rows[i].FindControl("lbUPC")).Text.Trim();

                Int32 ShoppingCartQuantity = 0;
                Boolean currentItemReleased = false;
                //check whether the current item is released back to inventory and store the table
                string querySelect1 = "SELECT isReleased, quantity FROM [ShoppingCart] WHERE (upc = '" + currentItemUPC + "' AND userName = '" + User.Identity.Name + "')";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand(querySelect1, connection))
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    // Check if a result was returned.
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {                            
                            currentItemReleased = Convert.ToBoolean(reader["isReleased"].ToString().Trim());
                            ShoppingCartQuantity = Convert.ToInt32(reader["quantity"].ToString().Trim());
                            //Response.Write("<script>alert('" + reader["quantity"].ToString().Trim() + "')</script>");
                            //Response.Write("<script>alert('" + (Convert.ToInt32(tbQuantity.Text) - initialQuantity).ToString().Trim() + "')</script>");
                        }
                    }
                }

                if(currentItemReleased)
                {
                    string initialQuantityAvailable_string = "";
                    Int32 initialQuantityAvailable = 0;
                    string itemName = "";
                    //get the initial quantityAvailable in Item DB
                    string querySelect2 = "SELECT quantityAvailable, name FROM [Item] WHERE upc = '" + currentItemUPC + "'";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(querySelect2, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        // Check if a result was returned.
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {                            
                                initialQuantityAvailable_string = reader["quantityAvailable"].ToString().Trim();
                                initialQuantityAvailable = Convert.ToInt32(initialQuantityAvailable_string);
                                itemName = reader["name"].ToString().Trim();
                                //Response.Write("<script>alert('" + reader["quantity"].ToString().Trim() + "')</script>");
                                //Response.Write("<script>alert('" + (Convert.ToInt32(tbQuantity.Text) - initialQuantity).ToString().Trim() + "')</script>");
                            }
                        }
                    }


                    //set the currentQuantityAvailable
                    Int32 currentQuantityAvailable = 0;
                    currentQuantityAvailable = initialQuantityAvailable - ShoppingCartQuantity;


                    //update the corresponding item in Item DB
                    string queryUpdate = "UPDATE [Item] SET quantityAvailable = @quantityAvailable WHERE upc = '" + currentItemUPC + "'";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate, connection))
                    {
                        command.Parameters.AddWithValue("@quantityAvailable", currentQuantityAvailable);
                        command.Connection.Open();
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }

                    //update the isreleased flag in shopping cart
                    queryUpdate = "UPDATE [ShoppingCart] SET isReleased = 'False' ";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate, connection))
                    {
                        command.Connection.Open();
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }   
                }
            }
        }
    }

    private void UpdateItemInformationInDB(string connectionString, string userName)
    {
        Int32 MaxIndex = gvShoppingCart.Rows.Count;
        for(int i = 0; i < MaxIndex; i++)
        {
            //get selected checkBox.Checked
            Int32 selected = Convert.ToInt32(((CheckBox)gvShoppingCart.Rows[i].FindControl("SelectLabel")).Checked);


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
            string queryUpdateShoppingCart = "UPDATE [ShoppingCart] SET [quantity] = @Quantity, [isChecked] = @IsChecked WHERE ([userName] = '" + userName + "' AND [upc] = '" + itemUPC + "')";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(queryUpdateShoppingCart, connection))
            {
                //Define the UPDATE query parameters with corresponding values
                command.Parameters.AddWithValue("@Quantity", (initialShoppingCartQuantity + difference).ToString());
                command.Parameters.AddWithValue("@IsChecked", selected.ToString().Trim());
                //Response.Write("<script>alert('" + selected.ToString() + "')</script>");

                //Open the connection, execute the UPDATE query and close the connection.
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }        
    }

    private void UpdateOrderRecord(string connectionString, string userName) //userName is for userName in OrderRecord
    {
        //for each selected item update OrderRecord DB
        Int32 MaxRows = gvShoppingCart.Rows.Count;

        for (int i = 0; i < MaxRows; i++)
        {
                bool selected = ((CheckBox)gvShoppingCart.Rows[i].FindControl("SelectLabel")).Checked;

                string itemName = ((Label)gvShoppingCart.Rows[i].FindControl("NameLabel")).Text.Trim(); //for name in OrderRecord
                string itemUPC = ((Label)gvShoppingCart.Rows[i].FindControl("lbUPC")).Text.Trim(); //for upc in OrderRecord
                string quantity = ((TextBox)gvShoppingCart.Rows[i].FindControl("QuantityTextBox")).Text.Trim(); //for quantity in OrderRecord

                //unitPuchasePrice is from DB Item
                string unitPuchasePrice = gvShoppingCart.Rows[i].Cells[5].Text.Trim();//((Label)gvShoppingCart.Rows[i].FindControl("UnitPurchasePriceLabel")).Text.Trim(); //for unitPrice in OrderRecord

                string IsConfirmed = "0"; //for isConfirmed in OrderRecord
                //string currentTime = "CURRENT_TIMESTAMP"; //for orderDateTime in OrderRecord


                string userEmail = ""; //for email in OrderRecord
                string userPhoneNumber = ""; //for phoneNumber in OrderRecord
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand("SELECT [email], [phoneNumber] FROM [Member] WHERE ([userName] = '" + userName + "')", connection))
                {
                    command.Connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    // Check if a result was returned.
                    if (reader.HasRows)
                    {
                        // Iterate through the table to get the retrieved values.
                        while (reader.Read())
                        {
                            // Assign the data values to userEmail, userPhoneNumber
                            userEmail = reader["email"].ToString().Trim();
                            userPhoneNumber = reader["phoneNumber"].ToString().Trim();
                        }
                    }

                    // Close the connection and the DataReader.
                    command.Connection.Close();
                    reader.Close();
                }

                //get unit Normal Price for later use : OrderRecord.normalPrice
                string unitPurchaseNormalPrice = "";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand("SELECT [normalPrice] FROM [Item] WHERE ([upc] = '" + itemUPC + "')", connection))
                {
                    command.Connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    // Check if a result was returned.
                    if (reader.HasRows)
                    {
                        // Iterate through the table to get the retrieved values.
                        while (reader.Read())
                        {
                            // Assign the data values to unitPurchaseNormalPrice
                            unitPurchaseNormalPrice = reader["normalPrice"].ToString().Trim();
                        }
                    }

                    // Close the connection and the DataReader.
                    command.Connection.Close();
                    reader.Close();
                }

                string userAddress = ""; //for address in OrderRecord
                string Default = "Home";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand("SELECT [building], [floor], [flatSuite], [blockTower], [streetAddress], [district] FROM [Address] WHERE ([userName] = '" + userName + "' AND [nickname] = N'" + Default + "')", connection))
                {
                    command.Connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    // Check if a result was returned.
                    if (reader.HasRows)
                    {
                        // Iterate through the table to get the retrieved values.
                        while (reader.Read())
                        {
                            // Assign the data values to userAddress
                            userAddress = reader["flatSuite"].ToString().Trim() + "  "
                                        + reader["floor"].ToString().Trim() + "  "
                                        + reader["blockTower"].ToString().Trim() + "  "
                                        + reader["building"].ToString().Trim() + "  "
                                        + reader["streetAddress"].ToString().Trim() + "  "
                                        + reader["district"].ToString().Trim();
                        }
                    }

                    // Close the connection and the DataReader.
                    command.Connection.Close();
                    reader.Close();
                }

                string userCreditCardNumber = ""; //for creditCardNumber in OrderRecord
                Default = "1";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand("SELECT [number] FROM [CreditCard] WHERE ([userName] = '" + userName + "' AND [creditCardDefault] = N'" + Default + "')", connection))
                {
                    command.Connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    // Check if a result was returned.
                    if (reader.HasRows)
                    {
                        // Iterate through the table to get the retrieved values.
                        while (reader.Read())
                        {
                            // Assign the data values to userCreditCardNumber
                            userCreditCardNumber = reader["number"].ToString().Trim();
                        }
                    }

                    // Close the connection and the DataReader.
                    command.Connection.Close();
                    reader.Close();
                }

                //Check whether there is any order for this item in OrderRecord
                //string checkQuery = "SELECT [userName] FROM [OrderRecord] WHERE ([userName] = N'" + userName + "' AND [upc] = N'" + itemUPC + "')";
                Int32 count = 0;
                //check if the item has already added into the shopping cart
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [OrderRecord] WHERE ([userName] = N'" + userName + "' AND [upc] = N'" + itemUPC + "' AND [isConfirmed] = 'False')", connection))
                {
                    command.Connection.Open();
                    count = (Int32)command.ExecuteScalar();
                    command.Connection.Close();
                }

                //if checkBox.Checked && Order does not exist, Insert Order
                if (selected && count == 0)
                {
                    string queryInsert = "INSERT INTO [OrderRecord] ("
                                       + "[userName], "
                                       + "[name], "
                                       + "[email], "
                                       + "[phoneNumber], "
                                       + "[upc], "
                                       + "[normalPrice], "
                                       + "[unitPrice], "
                                       + "[quantity], "
                                       + "[address], "
                                       + "[creditCardNumber], "
                                       + "[orderDateTime], "
                                       + "[isConfirmed]"
                                       + ")"

                                       + "VALUES ("
                                       + "@UserName, "
                                       + "@Name, "
                                       + "@Email, "
                                       + "@PhoneNumber, "
                                       + "@Upc, "
                                       + "@NormalPrice, "
                                       + "@UnitPrice, "
                                       + "@Quantity, "
                                       + "@Address, "
                                       + "@CreditCardNumber, "
                                       + "CURRENT_TIMESTAMP, "
                                       + "@IsConfirmed"
                                       + ")";

                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryInsert, connection))
                    {
                        // Define the INSERT query parameters and their values.
                        command.Parameters.AddWithValue("@UserName", userName);
                        command.Parameters.AddWithValue("@Name", itemName);
                        command.Parameters.AddWithValue("@Email", userEmail);
                        command.Parameters.AddWithValue("@PhoneNumber", userPhoneNumber);
                        command.Parameters.AddWithValue("@Upc", itemUPC);
                        command.Parameters.AddWithValue("@NormalPrice", unitPurchaseNormalPrice);
                        command.Parameters.AddWithValue("@UnitPrice", unitPuchasePrice);
                        command.Parameters.AddWithValue("@Quantity", quantity);
                        command.Parameters.AddWithValue("@Address", userAddress);
                        command.Parameters.AddWithValue("@CreditCardNumber", userCreditCardNumber);
                        command.Parameters.AddWithValue("@IsConfirmed", IsConfirmed);

                        // Open the connection, execute the INSERT query and close the connection.
                        command.Connection.Open();
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }
                }
                //else if checkBox.Checked && count != 0 Update Order ??????????????? Discount Price has to be up-to-date, how abt Normal Price
                else if (selected && count != 0)
                {
                    Decimal currentUnitDiscountPrice = Convert.ToDecimal(unitPuchasePrice); // From DB Item
                    Decimal pastUnitDiscountPrice = 0; // From DB OrderRecord
                    //get pastUnitDiscountPrice from OrderRecord
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand("SELECT [unitPrice] FROM [OrderRecord] WHERE ([upc] = '" + itemUPC + "')", connection))
                    {
                        command.Connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        // Check if a result was returned.
                        if (reader.HasRows)
                        {
                            // Iterate through the table to get the retrieved values.
                            while (reader.Read())
                            {
                                // Assign the data values to unitPurchaseNormalPrice
                                pastUnitDiscountPrice = Convert.ToDecimal(reader["unitPrice"].ToString().Trim());
                            }
                        }

                        // Close the connection and the DataReader.
                        command.Connection.Close();
                        reader.Close();
                    }


                    //set up To be UpdateDiscountPrice
                    string UpdateDiscountPrice = "";
                    if (pastUnitDiscountPrice < currentUnitDiscountPrice)
                    {
                        UpdateDiscountPrice = pastUnitDiscountPrice.ToString().Trim();
                    }
                    else
                    {
                        UpdateDiscountPrice = currentUnitDiscountPrice.ToString().Trim();
                    }
                    
                    

                    string queryUpdate = "UPDATE [OrderRecord] SET "
                                       + "[name] = @Name, "
                                       + "[email] = @Email, "
                                       + "[phoneNumber] = @PhoneNumber, "
                                       + "[normalPrice] = @NormalPrice, "
                                       + "[unitPrice] = @UnitPrice, "
                                       + "[quantity] = @Quantity, "
                                       + "[address] = @Address, "
                                       + "[creditCardNumber] = @CreditCardNumber, "
                                       + "[orderDateTime] = CURRENT_TIMESTAMP, "
                                       + "[isConfirmed] = @IsConfirmed "
                                       + " WHERE ([userName] = N'" + userName + "' AND [upc] = N'" + itemUPC + "' AND [isConfirmed] = 'False')";

                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate, connection))
                    {
                        // Define the UPDATE query parameters and their values.
                        command.Parameters.AddWithValue("@UserName", userName);
                        command.Parameters.AddWithValue("@Name", itemName);
                        command.Parameters.AddWithValue("@Email", userEmail);
                        command.Parameters.AddWithValue("@PhoneNumber", userPhoneNumber);
                        command.Parameters.AddWithValue("@Upc", itemUPC);
                        command.Parameters.AddWithValue("@NormalPrice", unitPurchaseNormalPrice); //Normal Price up-to-date ???? Needs verification from Professor
                        command.Parameters.AddWithValue("@UnitPrice", UpdateDiscountPrice);
                        command.Parameters.AddWithValue("@Quantity", quantity);
                        command.Parameters.AddWithValue("@Address", userAddress);
                        command.Parameters.AddWithValue("@CreditCardNumber", userCreditCardNumber);

                        command.Parameters.AddWithValue("@IsConfirmed", IsConfirmed);

                        // Open the connection, execute the INSERT query and close the connection.
                        command.Connection.Open();
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }
                }
                //delete corresponding items in OrderRecord
                else if (!selected && count != 0) 
                {
                    string queryDelete = "DELETE FROM [OrderRecord] WHERE ([userName] = N'" + userName + "' AND [upc] = '" + itemUPC + "' AND [isConfirmed] = 'False')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryDelete, connection))
                    {
                        // Open the connection, execute the INSERT query and close the connection.
                        command.Connection.Open();
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }
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

        int count = 0;
        //check if the item has already added into the shopping cart
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {

            connection.Open();
            SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [ShoppingCart] WHERE ([isReleased] = 'True' AND [upc] = N'" + itemUPC + "' AND [userName] = N'" + userName + "')", connection);
            count = (Int32)command.ExecuteScalar();
            connection.Close();
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

        if (count == 0)
        {
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
            string userName = User.Identity.Name; //Response.Write("<script>alert('Before Update')</script>");
            UpdateItemInformationInDB(connectionString, userName); //Response.Write("<script>alert('After Update; Before Populate')</script>");
            GetItemInformation(connectionString, userName); //Response.Write("<script>alert('After Populate; Before Calc')</script>");
            AccumulateTotalPrice(connectionString, userName); //Response.Write("<script>alert('After Calc')</script>");
        }
        //Response.Write("<script>alert('Hehe')</script>");
    }
    protected void SelectLabel_CheckedChanged(object sender, EventArgs e)
    {
        Page.Validate("ShoppingCartValidation");
        if (Page.IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name; //Response.Write("<script>alert('Before Update')</script>");
            UpdateItemInformationInDB(connectionString, userName); //Response.Write("<script>alert('After Update; Before Populate')</script>");
            GetItemInformation(connectionString, userName); //Response.Write("<script>alert('After Populate; Before Calc')</script>");
            AccumulateTotalPrice(connectionString, userName); //Response.Write("<script>alert('After Calc')</script>");
        }
    }
    protected void deleteButton_Click1(object sender, EventArgs e)
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

        int count = 0;
        //check if the item has already added into the shopping cart
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {

            connection.Open();
            SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [ShoppingCart] WHERE ([isReleased] = 'True' AND [upc] = N'" + itemUPC + "' AND [userName] = N'" + userName + "')", connection);
            count = (Int32)command.ExecuteScalar();
            connection.Close();
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

        if (count == 0)
        {
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
        }
        //Response.Write("<script>alert('Hehe')</script>");
        GetItemInformation(connectionString, userName);
        //Response.Write("<script>alert('Haha')</script>");
        AccumulateTotalPrice(connectionString, userName);
    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        Page.Validate("ShoppingCartValidation");
        if (Page.IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name; //Response.Write("<script>alert('Before Update')</script>");
            UpdateItemInformationInDB(connectionString, userName); //Response.Write("<script>alert('After Update; Before Populate')</script>");
            GetItemInformation(connectionString, userName); //Response.Write("<script>alert('After Populate; Before Calc')</script>");
            AccumulateTotalPrice(connectionString, userName); //Response.Write("<script>alert('After Calc')</script>");
        }
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
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

            //Check whether the 15 min session has passed
            string querySelectIsReleased = "SELECT isReleased FROM [ShoppingCart] WHERE (upc = '" + itemUPC + "' AND userName = '" + userName + "')";
            Boolean currentItemIsReleased = false;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(querySelectIsReleased, connection))
            {
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                // Check if a result was returned.
                if (reader.HasRows)
                {
                    // Iterate through the table to get the retrieved values.
                    while (reader.Read())
                    {
                        // Assign the data values to currentItemIsReleased
                        currentItemIsReleased = Convert.ToBoolean(reader["isReleased"].ToString().Trim());
                        //Response.Write("<script>alert('" + reader["quantity"].ToString().Trim() + "')</script>");
                        //Response.Write("<script>alert('" + (Convert.ToInt32(tbQuantity.Text) - initialQuantity).ToString().Trim() + "')</script>");
                    }
                }
            }

            //15 min session has not passed
            if (!currentItemIsReleased)
            {
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
            //15 min session has passed
            else
            {
                //Get the quantityAvailable in Item DB
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
                            // Assign the data values to initialQuantity
                            currentQuantityAvailable = Convert.ToInt32(reader["quantityAvailable"].ToString().Trim());
                            //Response.Write("<script>alert('" + reader["quantity"].ToString().Trim() + "')</script>");
                            //Response.Write("<script>alert('" + (Convert.ToInt32(tbQuantity.Text) - initialQuantity).ToString().Trim() + "')</script>");
                        }
                    }
                }
                if (Convert.ToInt32(tbQuantity.Text) > currentQuantityAvailable)
                    args.IsValid = false;
            }
        }
    }
    protected void CheckBox3_CheckedChanged(object sender, EventArgs e)
    {
        Page.Validate("ShoppingCartValidation");
        if (Page.IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name; //Response.Write("<script>alert('Before Update')</script>");
            UpdateItemInformationInDB(connectionString, userName); //Response.Write("<script>alert('After Update; Before Populate')</script>");
            GetItemInformation(connectionString, userName); //Response.Write("<script>alert('After Populate; Before Calc')</script>");
            AccumulateTotalPrice(connectionString, userName); //Response.Write("<script>alert('After Calc')</script>");
        }
    }
    protected void QuantityTextBox_TextChanged1(object sender, EventArgs e)
    {
        Page.Validate("ShoppingCartValidation");

        //Response.Write("<script>alert('Hehe')</script>");

        if (Page.IsValid)
        {

            string connectionString = "AsiaWebShopDBConnectionString";

            string userName = User.Identity.Name; //Response.Write("<script>alert('Before Update')</script>");

            UpdateItemInformationInDB(connectionString, userName); //Response.Write("<script>alert('After Update; Before Populate')</script>");

            GetItemInformation(connectionString, userName); //Response.Write("<script>alert('After Populate; Before Calc')</script>");

            AccumulateTotalPrice(connectionString, userName); //Response.Write("<script>alert('After Calc')</script>");

        }
    }
}