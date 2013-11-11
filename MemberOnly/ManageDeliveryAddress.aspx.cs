using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class MemberOnly_DeliveryAddressManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;

            //GridView.DataKeyNames 
            UserName.Text = userName;

            //GetCreditCardInformationForGridView(connectionString, userName);

        }
    }

    protected void insertUserName_Load(object sender, EventArgs e)
    {
        ((TextBox)(sender as Control)).Text = User.Identity.Name.Trim();
    }

    protected void dvDelivery_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        gvDelivery.DataBind();
    }

    protected void InsertUserName_Load(object sender, EventArgs e)
    {
        ((TextBox)(sender as Control)).Text = User.Identity.Name.Trim();
        ((TextBox)(sender as Control)).ReadOnly = true;
    }
 
    protected void dvDelivery_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        gvDelivery.DataBind();
    }

    protected void cvEditDistrict_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = true;

        TextBox txtEditDistrict = (TextBox)dvDelivery.FindControl("EditDistrict");

        string P1 = "Central and Western";
        string P2 = "Eastern";
        string P3 = "Islands";
        string P4 = "Kowloon City";
        string P5 = "Kwai Tsing";
        string P6 = "Kwun Tong";
        string P7 = "North";
        string P8 = "Sai Kung";
        string P9 = "Sha Tin";
        string P10 = "Sham Shui Po";
        string P11 = "Southern";
        string P12 = "Tai Po";
        string P13 = "Tsuen Wan";
        string P14 = "Tuen Mun";
        string P15 = "Wan Chai";
        string P16 = "Wong Tai Sin";
        string P17 = "Yau Tsim Mong";
        string P18 = "Yuen Long";

        if (!(txtEditDistrict.Text.Trim().Equals(P1, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P2, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P3, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P4, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P5, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P6, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P7, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P8, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P9, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P10, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P11, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P12, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P13, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P14, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P15, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P16, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P17, StringComparison.Ordinal) ||
             txtEditDistrict.Text.Trim().Equals(P18, StringComparison.Ordinal)))
        {
            args.IsValid = false;
        }
    }

    protected void cvInsertDistrict_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = true;

        TextBox txtInsertistrict = (TextBox)dvDelivery.FindControl("InsertDistrict");

        string P1 = "Central and Western";
        string P2 = "Eastern";
        string P3 = "Islands";
        string P4 = "Kowloon City";
        string P5 = "Kwai Tsing";
        string P6 = "Kwun Tong";
        string P7 = "North";
        string P8 = "Sai Kung";
        string P9 = "Sha Tin";
        string P10 = "Sham Shui Po";
        string P11 = "Southern";
        string P12 = "Tai Po";
        string P13 = "Tsuen Wan";
        string P14 = "Tuen Mun";
        string P15 = "Wan Chai";
        string P16 = "Wong Tai Sin";
        string P17 = "Yau Tsim Mong";
        string P18 = "Yuen Long";

        if (!(txtInsertistrict.Text.Trim().Equals(P1, StringComparison.Ordinal) ||
           txtInsertistrict.Text.Trim().Equals(P2, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P3, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P4, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P5, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P6, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P7, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P8, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P9, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P10, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P11, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P12, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P13, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P14, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P15, StringComparison.Ordinal) ||
            txtInsertistrict.Text.Trim().Equals(P16, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P17, StringComparison.Ordinal) ||
             txtInsertistrict.Text.Trim().Equals(P18, StringComparison.Ordinal)))
        {
            args.IsValid = false;
        }
    }
    protected void cvEditNickname_ServerValidate(object source, ServerValidateEventArgs args)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {
            // Get the value of the new UPC from the DetailsView control.
            TextBox txtEditNickname = (TextBox)dvDelivery.FindControl("EditNickname");

            // Count how many existing records have the student id value.
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Address] WHERE ([nickname] = N'" + txtEditNickname.Text + "')", connection);
            Int32 count = (Int32)command.ExecuteScalar();
            connection.Close();

            // If the count is not zero the UPC already exists, so cancel the insert.
            if (count != 0)
            {
                args.IsValid = false;
            }
        }
    }
    protected void cvInsertNickname_ServerValidate(object source, ServerValidateEventArgs args)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {
            // Get the value of the new UPC from the DetailsView control.
            TextBox txtInsertNickname = (TextBox)dvDelivery.FindControl("InsertNickname");

            // Count how many existing records have the student id value.
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Address] WHERE ([nickname] = N'" + txtInsertNickname.Text + "')", connection);
            Int32 count = (Int32)command.ExecuteScalar();
            connection.Close();

            // If the count is not zero the UPC already exists, so cancel the insert.
            if (count != 0)
            {
                args.IsValid = false;
            }
        }
    }
}