using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminOnly_AmountReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
            
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





    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {

        if (int.Parse(yearFrom.SelectedValue) > int.Parse(yearTo.SelectedValue))
            args.IsValid = false;
        else if(int.Parse(yearFrom.SelectedValue) == int.Parse(yearTo.SelectedValue))
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