using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class MemberOnly_ItemReview : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserName.Text = User.Identity.Name;
    }
    protected void cvItem_ServerValidate(object source, ServerValidateEventArgs args)
    {/*
        string userName = User.Identity.Name;
        
        Int32 MaxRow = gvItemReview.Rows.Count;
        Int32 count = 0;
        for (int i = 0; i < MaxRow; i++)
        {
            if (((CheckBox)gvItemReview.Rows[i].FindControl("selected")).Checked == true) 
            {
                count++;
            }
        }

        if (count < 1)
        {
            args.IsValid = false;
        }
        else
        {
            args.IsValid = true;
        }        
      * */
    }

    protected void selected_CheckedChanged(object sender, EventArgs e)
    {
        if (lblMessage.Text == "* You have to select an item to review")
        {
            lblMessage.Text = "";
        }

        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;

        GridViewRow gridViewRow = (GridViewRow)(sender as Control).Parent.Parent;
        Int32 Row_index = gridViewRow.RowIndex;

        //check a new item
        if (((CheckBox)gvItemReview.Rows[Row_index].FindControl("selected")).Checked == true)
        {
            string checkedItemUPC = ((Label)gvItemReview.Rows[Row_index].FindControl("ItemUPC")).Text.Trim();
            Int32 MaxRow = gvItemReview.Rows.Count;
            //check whether the currently checked one has been reviewed by the current member.
            Int32 count = 0;
            //check if the item has already been reviewed by the user before
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Review] WHERE ([userName] = N'" + userName + "' AND [upc] = '" + checkedItemUPC + "')", connection))
            {
                command.Connection.Open();
                count = (Int32)command.ExecuteScalar();
                command.Connection.Close();
            }

            //the current member has not reviewed the item, so good to go
            if (count == 0)
            {
                for (int i = 0; i < MaxRow; i++)
                {
                    if (gvItemReview.Rows[i] != gridViewRow && ((CheckBox)gvItemReview.Rows[i].FindControl("selected")).Checked == true)
                    {
                        ((CheckBox)gvItemReview.Rows[i].FindControl("selected")).Checked = false;
                    }
                }
                lblMessage.Text = "";
            }
            //the current member has reviewed the item
            else
            {
                ((CheckBox)gvItemReview.Rows[Row_index].FindControl("selected")).Checked = false;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "* You have reviewed this item before. You cannot reviewed an item twice";
            }
        }
        //uncheck an item
        else
        {
            ((CheckBox)gvItemReview.Rows[Row_index].FindControl("selected")).Checked = true;
            lblMessage.Text = "";
        }        
    }
    protected void submit_Click(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;

        Int32 MaxRow = gvItemReview.Rows.Count;
        Int32 count = 0;
        for (int i = 0; i < MaxRow; i++)
        {
            if (((CheckBox)gvItemReview.Rows[i].FindControl("selected")).Checked == true)
            {
                count++;
            }
        }

        //the member has not specified any item
        if (count < 1)
        {
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Text = "* You have to select an item to review";
        }
        else
        {
            Page.Validate();

            if (Page.IsValid)
            {
                string checkedUPC = "";
                //find the checked item
                for (int i = 0; i < MaxRow; i++)
                {
                    if (((CheckBox)gvItemReview.Rows[i].FindControl("selected")).Checked == true)
                    {
                        checkedUPC = ((Label)gvItemReview.Rows[i].FindControl("ItemUPC")).Text.Trim();
                    }
                }

                string queryInsert = "INSERT INTO [Review] VALUES(@upc, @userName, @qualityRating, @featuresRating, @performanceRating, @appearanceRating, @durabilityRating, @comment, @isAnonymous)";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand(queryInsert, connection))
                {
                    command.Connection.Open();
                    command.Parameters.AddWithValue("@upc", checkedUPC.Trim());
                    command.Parameters.AddWithValue("@userName", userName.Trim());
                    command.Parameters.AddWithValue("@qualityRating", qualityRadioButtonList.SelectedValue);
                    command.Parameters.AddWithValue("@featuresRating", featuresRadioButtonList.SelectedValue);
                    command.Parameters.AddWithValue("@performanceRating", performanceRadioButtonList.SelectedValue);
                    command.Parameters.AddWithValue("@appearanceRating", appearanceRadioButtonList.SelectedValue);
                    command.Parameters.AddWithValue("@durabilityRating", durabilityRadioButtonList.SelectedValue);
                    if (comment.Text.Trim() == String.Empty)
                    {
                        command.Parameters.AddWithValue("@comment", "");
                    }
                    else
                    {
                        command.Parameters.AddWithValue("@comment", comment.Text.Trim());
                    }
                    command.Parameters.AddWithValue("@isAnonymous", checkAnonymous.Checked);
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                }
                indicator.ForeColor = System.Drawing.Color.Green;
                indicator.Text = "Your review is successfully submitted.";
            }
        }
    }
}