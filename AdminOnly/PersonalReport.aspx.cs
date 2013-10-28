using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminOnly_PersonalReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        result.Visible = false;
        result.Text = "";
        report.Visible = false;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        // Get the search string and the category from the search page.
        string searchString = userName.Text.Trim();
        bool distract = group.Checked;
        string SQLCmd;

        // Hide and clear the search result message.
        result.Visible = false;
        result.Text = "";
        report.Visible = true;
        // Construct the basic SELECT statement for searching; only visible items should be displayed.

        if (searchString == "" & !group.Checked)
        {
            SQLCmd = "SELECT [Member].[userName], [Member].[email], [Member].[firstName], [Member].[lastName], [Member].[phoneNumber], [Member].[renewalDate], [Member].[active],"+
                                "[Address].[userName], [Address].[buildingAddress], [Address].[streetAddress], [Address].[district], " +
                                "[CreditCard].[userName], [CreditCard].[number], [CreditCard].[type], [CreditCard].[cardHolderName], [CreditCard].[expiryMonth], [CreditCard].[expiryYear]" +
                                "FROM [Member]" +
                                "JOIN [Address] on [Address].[userName] = [Member].[userName]"+
                                "JOIN [CreditCard] on [CreditCard].[userName] = [Member].[userName] " +
                                "ORDER BY [Member].[lastName]";
        }

        else if (searchString == "" & group.Checked)
        {
            SQLCmd = "SELECT [Member].[userName], [Member].[email], [Member].[firstName], [Member].[lastName], [Member].[phoneNumber], [Member].[renewalDate], [Member].[active]," +
                                "[Address].[userName], [Address].[buildingAddress], [Address].[streetAddress], [Address].[district], " +
                                "[CreditCard].[userName], [CreditCard].[number], [CreditCard].[type], [CreditCard].[cardHolderName], [CreditCard].[expiryMonth], [CreditCard].[expiryYear]" +
                                "FROM [Member]" +
                                "JOIN [Address] on [Address].[userName] = [Member].[userName]" +
                                "JOIN [CreditCard] on [CreditCard].[userName] = [Member].[userName] " +
                                "ORDER BY [Member].[lastName], [Address].[district]";
        }


        else if (searchString != "" & !group.Checked)
        {
            SQLCmd = "SELECT [Member].[userName], [Member].[email], [Member].[firstName], [Member].[lastName], [Member].[phoneNumber], [Member].[renewalDate], [Member].[active]," +
                                "[Address].[userName], [Address].[buildingAddress], [Address].[streetAddress], [Address].[district], " +
                                "[CreditCard].[userName], [CreditCard].[number], [CreditCard].[type], [CreditCard].[cardHolderName], [CreditCard].[expiryMonth], [CreditCard].[expiryYear]" +
                                "FROM [Member]" +
                                "JOIN [Address] on [Address].[userName] = [Member].[userName]" +
                                "JOIN [CreditCard] on [CreditCard].[userName] = [Member].[userName] " +
                                " AND ([Member].[userName] LIKE N'%" + searchString + "%')" +
                                "ORDER BY [Member].[lastName]";
        }

        else
        {
            SQLCmd = "SELECT [Member].[userName], [Member].[email], [Member].[firstName], [Member].[lastName], [Member].[phoneNumber], [Member].[renewalDate], [Member].[active]," +
                                "[Address].[userName], [Address].[buildingAddress], [Address].[streetAddress], [Address].[district], " +
                                "[CreditCard].[userName], [CreditCard].[number], [CreditCard].[type], [CreditCard].[cardHolderName], [CreditCard].[expiryMonth], [CreditCard].[expiryYear]" +
                                "FROM [Member]" +
                                "JOIN [Address] on [Address].[userName] = [Member].[userName]" +
                                "JOIN [CreditCard] on [CreditCard].[userName] = [Member].[userName] " +
                                " AND ([Member].[userName] LIKE N'%" + searchString + "%')" +
                                "ORDER BY [Member].[lastName], [Address].[district]";
        }
        // Execute the SQL statement; order the result by item name.
        SqlDataSource1.SelectCommand = SQLCmd;
        SqlDataSource1.Select(DataSourceSelectArguments.Empty);

        // Bind the search result to the GridView control.
        report.DataBind();

        // Display a no result message if nothing was retrieved from the database.
        if (report.Rows.Count == 0)
        {
            result.Text = "No records match your query." + result.Text;
            result.Visible = true;
        }
        else
        {
            result.Text = "The following records match your query." + result.Text;
            result.Visible = true;
        }

    
    }
}