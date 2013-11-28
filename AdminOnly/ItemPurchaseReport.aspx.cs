using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminOnly_ItemPurchaseReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        result.Visible = false;
        result.Text = "";
        report.Visible = false;

        if (!Page.IsPostBack)
        {
            //Fill Years
            for (int year = DateTime.Now.Year; year <= DateTime.Now.Year + 10; year++)
            {
                yearFrom.Items.Add(year.ToString());
                yearTo.Items.Add(year.ToString());
            }
            yearFrom.Items.FindByValue(System.DateTime.Now.Year.ToString()).Selected = true;  //set current year as selected
            yearTo.Items.FindByValue(System.DateTime.Now.Year.ToString()).Selected = true;
            //Fill Months
            for (int i = 1; i <= 12; i++)
            {
                monthFrom.Items.Add(i.ToString());
                monthTo.Items.Add(i.ToString());
            }
            monthFrom.Items.FindByValue(System.DateTime.Now.Month.ToString()).Selected = true; // Set current month as selected
            monthTo.Items.FindByValue(System.DateTime.Now.Month.ToString()).Selected = true;
            //Fill days
            FillDaysFrom();
            FillDaysTo();
            dayFrom.Items.FindByValue(System.DateTime.Now.Day.ToString()).Selected = true;// Set current date as selected
            dayTo.Items.FindByValue(System.DateTime.Now.Day.ToString()).Selected = true;
        }
    }

    public void FillDaysFrom()
    {
        dayFrom.Items.Clear();
        //getting numbner of days in selected month & year
        int noofdays = DateTime.DaysInMonth(Convert.ToInt32(yearFrom.SelectedValue), Convert.ToInt32(monthFrom.SelectedValue));
        //Response.Write("<script>alert('"+Convert.ToInt32(yearFrom.SelectedValue)+Convert.ToInt32(monthFrom.SelectedValue)+noofdays+"')</script>");
        //Fill days
        for (int i = 1; i <= noofdays; i++)
        {
            dayFrom.Items.Add(i.ToString());
        }

    }

    public void FillDaysTo()
    {
        dayTo.Items.Clear();
        //getting numbner of days in selected month & year
        int noofdays = DateTime.DaysInMonth(Convert.ToInt32(yearTo.SelectedValue), Convert.ToInt32(monthTo.SelectedValue));
        //Response.Write("<script>alert('"+Convert.ToInt32(yearFrom.SelectedValue)+Convert.ToInt32(monthFrom.SelectedValue)+noofdays+"')</script>");
        //Fill days
        for (int i = 1; i <= noofdays; i++)
        {
            dayTo.Items.Add(i.ToString());
        }

    }
    protected void yearFrom_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillDaysFrom();
    }
    protected void monthFrom_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillDaysFrom();
    }
    protected void yearTo_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillDaysTo();
    }
    protected void monthTo_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillDaysTo();
    }

    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (date.SelectedValue == "certain")
        {

            if (int.Parse(yearFrom.SelectedValue) > int.Parse(yearTo.SelectedValue))
                args.IsValid = false;
            else if (int.Parse(yearFrom.SelectedValue) == int.Parse(yearTo.SelectedValue))
            {
                if (int.Parse(monthFrom.SelectedValue) > int.Parse(monthTo.SelectedValue))
                    args.IsValid = false;
                else if (int.Parse(monthFrom.SelectedValue) == int.Parse(monthTo.SelectedValue))
                {
                    if (int.Parse(dayFrom.SelectedValue) > int.Parse(dayTo.SelectedValue))
                        args.IsValid = false;
                    else
                        args.IsValid = true;
                }
                else
                    args.IsValid = true;
            }
            else
                args.IsValid = true;
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string SQLCmd = "";
        string SQLCmd2 = "";
        string SQLCmd3 = "";
        if (IsValid)
        {
            if (date.SelectedValue == "certain")
                SQLCmd2 = "AND [OrderRecord].[orderDateTime] >= '" + yearFrom.SelectedValue + "-" + monthFrom.SelectedValue + "-" + dayFrom.SelectedValue + " 00:00:00'" +
                             "AND [OrderRecord].[orderDateTime] <= '" + yearTo.SelectedValue + "-" + monthTo.SelectedValue + "-" + dayTo.SelectedValue + " 23:59:59'";
            if (userName.Text.Trim() != "")
                SQLCmd3 = "AND [Member].[userName] = '" + userName.Text.Trim() + "' ";


            SQLCmd = "SELECT [Item].[name], [Item].[category], SUM(OrderRecord.quantity) AS totalQuantity, [OrderRecord].[unitPrice], SUM(OrderRecord.quantity * OrderRecord.unitPrice) AS totalPrice, SUM(OrderRecord.quantity * (OrderRecord.normalPrice - OrderRecord.unitPrice)) AS saving," +
                            "[Member].[firstName] + ' ' + [Member].[lastName] AS customerName," +
                            "[OrderRecord].[email], [OrderRecord].[phoneNumber], [OrderRecord].[address]," +
                            " + RIGHT([CreditCard].[number],4) AS cardnumber, + [CreditCard].[type]," +
                            "[OrderRecord].[authorizationCode], [OrderRecord].[orderDateTime], [Member].[userName]" +
                     "FROM [OrderRecord] " +
                     "JOIN [Member] ON [OrderRecord].[userName] = [Member].[userName] " +
                     "JOIN [Item] ON [OrderRecord].[upc] = [Item].[upc]" +
                     "JOIN [CreditCard] ON [OrderRecord].[creditCardNumber] = [CreditCard].[number]" +
                     "WHERE [OrderRecord].[isConfirmed] = 'True'" +
                     SQLCmd2 +
                     SQLCmd3 +
                     "GROUP BY [Item].[name], [Item].[category], [Member].[userName]," +
                     "[Member].[firstName], [Member].[lastName],[CreditCard].[number], [CreditCard].[type]," +
                     "[OrderRecord].[unitPrice],[OrderRecord].[email],[OrderRecord].[phoneNumber],[OrderRecord].[address],[OrderRecord].[authorizationCode],[OrderRecord].[orderDateTime]" +
                     "ORDER BY [Item].[category], [Item].[name]";
            SqlDataSource1.SelectCommand = SQLCmd;
            SqlDataSource1.Select(DataSourceSelectArguments.Empty);

            // Bind the search result to the GridView control.
            report.DataBind();
            report.Visible = true;
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
}