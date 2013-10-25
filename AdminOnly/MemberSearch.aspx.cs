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

public partial class ItemSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        // Get the search string and the category from the search page.

        string searchString = txtSearchString.Text.Trim();
        //string category = categoryDropDownList.SelectedValue.Trim();

        // Construct the basic SELECT statement for searching; only visible items should be displayed.
        string SQLCmd = "SELECT [userName], [email], [firstName], [lastName], [phoneNumber], [renewalDate], [active] FROM [Member] WHERE [userName] LIKE N'%" + searchString + "%'";

        // Hide and clear the search result message.
        lblSearchResultMessage.Visible = false;
        lblSearchResultMessage.Text = "";

        // Execute the SQL statement; order the result by item name.
        AsiaWebShopDBSqlDataSource.SelectCommand = SQLCmd ;
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
   
}