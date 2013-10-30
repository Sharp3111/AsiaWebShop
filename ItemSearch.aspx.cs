﻿using System;
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
        string catagory = Request.QueryString["category"];
        switch (catagory)
        {
            case "Appliances": 
                categoryDropDownList.SelectedIndex = 1;
                btnSearch_Click(sender,e);
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

    }

    protected void btn_ShoppingCart_Click(object sender, EventArgs e)
    {
        if (User.Identity.Name != "")
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;
            GridViewRow gridViewRow = (GridViewRow)(sender as Control).Parent.Parent;
            int Row_index = gridViewRow.RowIndex;
            string upc = gvItemSearchResult.DataKeys[Row_index][0].ToString().Trim();
            //Response.Write("<script>alert('Upc:"+upc+"')</script>");
            int quantity = 1;

            string SQLCmd = "INSERT INTO [ShoppingCart] " +
                           "VALUES (@UserName, @Upc, @Quantity)";

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
            Response.Redirect("~/MemberOnly/ShoppingCart.aspx");
        }
        else 
        {
            Response.Write("<script>alert('Please Login')</script>");
        }
    }
    protected void categoryDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}