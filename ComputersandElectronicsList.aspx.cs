using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ComputersandElectronicsList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Construct the basic SELECT statement for searching; only visible items should be displayed.
        string SQLCmd = "SELECT [upc], [name], [picture], [normalPrice], [discountPrice], [quantityAvailable] FROM [Item] WHERE (([visible] = 'true') AND [category] = 'Computers and Electronics'";

        // Execute the SQL statement; order the result by item name.
        AsiaWebShopDBSqlDataSource.SelectCommand = SQLCmd + ") ORDER BY [name]";
        AsiaWebShopDBSqlDataSource.Select(DataSourceSelectArguments.Empty);

        // Bind the search result to the GridView control.
        gvItemSearchResult.DataBind();

        // Display a no result message if nothing was retrieved from the database.
        if (gvItemSearchResult.Rows.Count == 0)
        {
            lblSearchResultMessage.Text = "No records in Computers and Electronics." + lblSearchResultMessage.Text;
            lblSearchResultMessage.Visible = true;
        }
        else
        {
            lblSearchResultMessage.Text = "The following records are in Computers and Electronics." + lblSearchResultMessage.Text;
            lblSearchResultMessage.Visible = true;
        }
    }
}