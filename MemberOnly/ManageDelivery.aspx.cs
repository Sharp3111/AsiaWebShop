using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class MemberOnly_PaymentMethodManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;

            //GridView.DataKeyNames 
            UserName.Text = userName;

            //GetDeliveryInformationForGridView(connectionString, userName);

        }
    }


    protected void insertUserName_Load(object sender, EventArgs e)
    {
        ((Label)(sender as Control)).Text = User.Identity.Name.Trim();
    }
    protected void dvDelivery_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        gvDelivery.DataBind();
    }
  
    
   
  
    protected void InsertUserName_Load(object sender, EventArgs e)
    {
        ((Label)(sender as Control)).Text = User.Identity.Name.Trim();
    }
    protected void dvDelivery_ItemInserted1(object sender, DetailsViewInsertedEventArgs e)
    {
        gvDelivery.DataBind();
    }
    protected void dvDelivery_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {      
        gvDelivery.DataBind();
    }
    protected void RemoveButton_Click(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;
        Int32 MaxRows = gvDelivery.Rows.Count;

        Int32 count = 0;
        //check if there is only one address in delivery address list
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Address] WHERE ([userName] = N'" + userName + "')", connection))
        {
            command.Connection.Open();
            count = (Int32)command.ExecuteScalar();
            command.Connection.Close();
        }

        if (count > 1)
        {
            //Response.Write("<script>alert('enter delete button')</script>");
            GridViewRow gridViewRow = (GridViewRow)(sender as Control).Parent.Parent;
            Boolean currentDefault = ((CheckBox)gridViewRow.FindControl("isDefault")).Checked;
            string currentNickname = ((Label)gridViewRow.FindControl("nickname")).Text.Trim();

            string queryDelete = "DELETE FROM [Address] WHERE ([userName] = N'" + userName + "' AND [nickname] = '" + currentNickname + "')";
            //Response.Write("<script>alert('" + currentNumber + "')</script>");
            if (!currentDefault)
            {
                lblMessage.Visible = false;
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "The selected address is your default address. After deletion, your default address will be the first one appearing in your delivery address list different from your original default address";


                string firstValidInGridViewAddress = "";
                for (int i = 0; i < MaxRows; i++)
                {
                    if (((Label)gvDelivery.Rows[i].FindControl("nickname")).Text.Trim() != currentNickname)
                    {
                        firstValidInGridViewAddress = ((Label)gvDelivery.Rows[i].FindControl("nickname")).Text.Trim();
                        break;
                    }
                }

                
                string queryUpdate = "UPDATE [Address] SET isDefault = @IsDefault WHERE ([userName] = N'" + userName + "' AND [nickname] = '" + firstValidInGridViewAddress + "')";

                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand(queryUpdate, connection))
                {
                    command.Parameters.AddWithValue("@IsDefault", true);
                    command.Connection.Open();
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                }
            }

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(queryDelete, connection))
            {
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }
 
            gvDelivery.DataBind();
           
        }
        else
        {
            lblMessage.Visible = true;
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Text = "You cannot delete the only address in your delivery address list";
        }
    }
    protected void EditDeliveryDefault_CheckedChanged(object sender, EventArgs e)
    {
    }
    protected void dvDelivery_Load(object sender, EventArgs e)
    {
        lblMessage.Visible = false;
    }
    protected void InsertDeliveryDefault_CheckedChanged(object sender, EventArgs e)
    {
    }
    
    protected void dvDelivery_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        Page.Validate();

        if (Page.IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;

            Int32 count = 0;
            //check if only
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Address] WHERE ([userName] = N'" + userName + "')", connection))
            {
                command.Connection.Open();
                count = (Int32)command.ExecuteScalar();
                command.Connection.Close();
            }

            if (count <= 1)
            {
                //if the only one edited address changes from default to non default, error message.
                if (((CheckBox)(dvDelivery.FindControl("EditIsDefault"))).Checked == false)
                {
                    ((CheckBox)(dvDelivery.FindControl("EditIsDefault"))).Checked = true;
                    ((CheckBox)(dvDelivery.FindControl("EditIsDefault"))).Enabled = false;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "This is your only address in your delivery address list. You have to have this address as the default delivery address.";
                    lblMessage.Visible = true;
                }
            }
            else
            {
                //if the edited credit card changes from nondefault to default, then the initial default card becomes nondefault
                if (((CheckBox)(dvDelivery.FindControl("EditIsDefault"))).Checked == true)
                {
                    //find the initial default number for later update
                    string currentnickname = ((TextBox)dvDelivery.FindControl("EditNickname")).Text.Trim();
                    string initialDefaultAddress = "";

                    string querySelect = "SELECT [nickname] FROM [Address] WHERE ([userName] = N'" + userName + "' AND [isDefault] = '" + Convert.ToString(true) + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(querySelect, connection))
                    {
                        command.Connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                initialDefaultAddress = reader.GetString(0);
                            }
                        }

                        reader.Close();
                        command.Connection.Close();
                    }

                    //Set the edited card to be default
                    string queryUpdate1 = "UPDATE [Address] SET [isDefault] = @IsDefault WHERE ([userName] = N'" + userName + "' AND [nickname] = '" + currentnickname + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate1, connection))
                    {
                        command.Connection.Open();
                        command.Parameters.AddWithValue("@IsDefault", true);
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }

                    //Set the initial default to be nondefault
                    string queryUpdate2 = "UPDATE [Address] SET [isDefault] = @IsDefault WHERE ([userName] = N'" + userName + "' AND [nickname] = '" + initialDefaultAddress + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate2, connection))
                    {
                        command.Connection.Open();
                        command.Parameters.AddWithValue("@IsDefault", false);
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }

                    gvDelivery.DataBind();

                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Your default delivery address has changed.";
                    lblMessage.Visible = true;
                }
                //else the edited address changes from default to nondefault, then this card is set to the default
                else
                {
                    string currentnickname = ((TextBox)dvDelivery.FindControl("EditNickname")).Text.Trim();
                    string changedDefaultAddress = "";

                    string querySelect = "SELECT [nickname] FROM [Address] WHERE ([userName] = N'" + userName + "' AND [isDefault] = '" + Convert.ToString(false) + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(querySelect, connection))
                    {
                        command.Connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                // find next address to be default
                                changedDefaultAddress = reader.GetString(0); break;
                            }
                        }

                        reader.Close();
                        command.Connection.Close();
                    }

                    //Set the edited card to be default
                    string queryUpdate1 = "UPDATE [Address] SET [isDefault] = @IsDefault WHERE ([userName] = N'" + userName + "' AND [nickname] = '" + changedDefaultAddress + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate1, connection))
                    {
                        command.Connection.Open();
                        command.Parameters.AddWithValue("@IsDefault", true);
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }

                    //Set the initial default to be nondefault
                    string queryUpdate2 = "UPDATE [Address] SET [isDefault] = @IsDefault WHERE ([userName] = N'" + userName + "' AND [nickname] = '" + currentnickname + "')";
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                    using (SqlCommand command = new SqlCommand(queryUpdate2, connection))
                    {
                        command.Connection.Open();
                        command.Parameters.AddWithValue("@IsDefault", false);
                        command.ExecuteNonQuery();
                        command.Connection.Close();
                    }

                    gvDelivery.DataBind();

                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Your default delivery address has changed.";
                }
            }
        }
        else
        {
            ((CheckBox)(dvDelivery.FindControl("EditIsDefault"))).Checked = false;
        }
    }
    protected void dvDelivery_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        ////Response.Write("<script>alert('" + "Enter" + "')</script>");
        //Page.Validate();

        //if (Page.IsValid)
        //{
        //    string connectionString = "AsiaWebShopDBConnectionString";
        //    string userName = User.Identity.Name;

        //    Int32 count = 0;
        //    //check if the item has already added into the shopping cart
        //    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        //    using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Address] WHERE ([userName] = N'" + userName + "')", connection))
        //    {
        //        command.Connection.Open();
        //        count = (Int32)command.ExecuteScalar();
        //        command.Connection.Close();
        //    }

        //    //Response.Write("<script>alert( count = '" + count.ToString().Trim() + "')</script>");

        //    if (count < 1)
        //    {
        //        //if the edited credit card changes from default to non default, error message.
        //        if (((CheckBox)(dvDelivery.FindControl("InsertIsDefault"))).Checked == false)
        //        {
        //            ((CheckBox)(dvDelivery.FindControl("InsertIsDefault"))).Checked = true;
        //            ((CheckBox)(dvDelivery.FindControl("InsertIsDefault"))).Enabled = false;
        //            lblMessage.ForeColor = System.Drawing.Color.Red;
        //            lblMessage.Text = "This is your only delivery address in your address list. You have to use this address as the default delivery address.";
        //            lblMessage.Visible = true;
        //        }
        //    }

        //    else
        //    {
        //        //if the edited credit card changes from nondefault to default, then the initial default card becomes nondefault
        //        if (((CheckBox)(dvDelivery.FindControl("InsertIsDefault"))).Checked == true)
        //        {
        //            //find the initial default address for later update
        //            string currentnickname = ((TextBox)dvDelivery.FindControl("InsertNickname")).Text.Trim();
        //            string initialDefaultAddress = "";

        //            string querySelect = "SELECT [nickname] FROM [Address] WHERE ([userName] = N'" + userName + "' AND [isDefault] = '" + Convert.ToString(true) + "')";
        //            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        //            using (SqlCommand command = new SqlCommand(querySelect, connection))
        //            {
        //                command.Connection.Open();
        //                SqlDataReader reader = command.ExecuteReader();
        //                if (reader.HasRows)
        //                {
        //                    while (reader.Read())
        //                    {
        //                        initialDefaultAddress = reader.GetString(0);
        //                    }
        //                }

        //                reader.Close();
        //                command.Connection.Close();
        //            }

        //            count = 0;
        //            //check if the item has already added into the shopping cart
        //            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        //            using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Address] WHERE ([userName] = N'" + userName + "' AND [nickname] = '" + currentnickname + "')", connection))
        //            {
        //                command.Connection.Open();
        //                count = (Int32)command.ExecuteScalar();
        //                command.Connection.Close();
        //            }

        //            //Response.Write("<script>alert( count = '" + count.ToString().Trim() + "')</script>");

        //            //Set the edited card to be default
        //            string queryUpdate1 = "UPDATE [Address] SET [isDefault] = @IsDefault WHERE ([userName] = N'" + userName + "' AND [nickname] = '" + currentnickname + "')";
        //            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        //            using (SqlCommand command = new SqlCommand(queryUpdate1, connection))
        //            {
        //                command.Connection.Open();
        //                command.Parameters.AddWithValue("@IsDefault", true);
        //                command.ExecuteNonQuery();
        //                command.Connection.Close();
        //            }
        //            //Response.Write("<script>alert('" + currentnickname + "')</script>");
        //            //Set the initial default to be nondefault
        //            string queryUpdate2 = "UPDATE [Address] SET [isDefault] = @IsDefault WHERE ([userName] = N'" + userName + "' AND [nickname] = '" + initialDefaultAddress + "')";
        //            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        //            using (SqlCommand command = new SqlCommand(queryUpdate2, connection))
        //            {
        //                command.Connection.Open();
        //                command.Parameters.AddWithValue("@IsDefault", false);
        //                command.ExecuteNonQuery();
        //                command.Connection.Close();
        //            }
        //            //Response.Write("<script>alert('" + initialDefaultAddress + "')</script>");
        //            gvDelivery.DataBind();

        //            lblMessage.ForeColor = System.Drawing.Color.Green;
        //            lblMessage.Text = "Your default delivery address has changed.";
        //            lblMessage.Visible = true;
        //        }
        //        ////else the edited credit card changes from default to nondefault, then this card is set to the default
        //        //else
        //        //{
        //        //    string currentnickname = ((TextBox)dvDelivery.FindControl("InsertNickname")).Text.Trim();
        //        //    string changedDefaultAddress = "";

        //        //    string querySelect = "SELECT [nickname] FROM [Address] WHERE ([userName] = N'" + userName + "' AND [isDefault] = '" + Convert.ToString(false) + "')";
        //        //    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        //        //    using (SqlCommand command = new SqlCommand(querySelect, connection))
        //        //    {
        //        //        command.Connection.Open();
        //        //        SqlDataReader reader = command.ExecuteReader();
        //        //        if (reader.HasRows)
        //        //        {
        //        //            while (reader.Read())
        //        //            {
        //        //                changedDefaultAddress = reader.GetString(0); break;
        //        //            }
        //        //        }

        //        //        reader.Close();
        //        //        command.Connection.Close();
        //        //    }

        //        //    //Set the edited card to be default
        //        //    string queryUpdate1 = "UPDATE [Address] SET [isDefault] = @IsDefault WHERE ([userName] = N'" + userName + "' AND [nickname] = '" + changedDefaultAddress + "')";
        //        //    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        //        //    using (SqlCommand command = new SqlCommand(queryUpdate1, connection))
        //        //    {
        //        //        command.Connection.Open();
        //        //        command.Parameters.AddWithValue("@IsDefault", true);
        //        //        command.ExecuteNonQuery();
        //        //        command.Connection.Close();
        //        //    }

        //        //    //Set the initial default to be nondefault
        //        //    string queryUpdate2 = "UPDATE [Address] SET [isDefault] = @IsDefault WHERE ([userName] = N'" + userName + "' AND [nickname] = '" + currentnickname + "')";
        //        //    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        //        //    using (SqlCommand command = new SqlCommand(queryUpdate2, connection))
        //        //    {
        //        //        command.Connection.Open();
        //        //        command.Parameters.AddWithValue("@IsDefault", false);
        //        //        command.ExecuteNonQuery();
        //        //        command.Connection.Close();
        //        //    }

        //        //    gvDelivery.DataBind();

        //        //    lblMessage.ForeColor = System.Drawing.Color.Green;
        //        //    lblMessage.Text = "Your default delivery address has changed.";
        //        //    lblMessage.Visible = true;
        //        //}
        //    }
        //}
        //else
        //{
        //    ((CheckBox)(dvDelivery.FindControl("InsertIsDefault"))).Checked = false;
        //}
    }

    protected void gvDelivery_SelectedIndexChanged(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;

        Int32 MaxRow = gvDelivery.Rows.Count;
        GridViewRow row = gvDelivery.SelectedRow;       

        for (int i = 0; i < MaxRow; i++)
        {
            string currentnickname = ((Label)gvDelivery.Rows[i].FindControl("nickname")).Text.Trim();
            if(gvDelivery.Rows[i] == row)
            {
                string queryUpdate = "UPDATE [Address] SET [isSelected] = @isSelected WHERE ([userName] = '" + userName + "' AND [nickname] = '" + currentnickname + "')";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand(queryUpdate, connection))
                {
                    command.Connection.Open();
                    command.Parameters.AddWithValue("@isSelected", true);
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                }
            }
            else
            {
                string queryUpdate = "UPDATE [Address] SET [isSelected] = @isSelected WHERE ([userName] = '" + userName + "' AND [nickname] = '" + currentnickname + "')";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand(queryUpdate, connection))
                {
                    command.Connection.Open();
                    command.Parameters.AddWithValue("@isSelected", false);
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                }
            }            
        }
    }
    protected void dvDelivery_DataBound(object sender, EventArgs e)
    {
        if (dvDelivery.CurrentMode == DetailsViewMode.Edit)
        {
            foreach (DetailsViewRow dvr in dvDelivery.Rows)
            {
                if (dvr.Cells.Count.Equals(2) && dvr.Cells[1].HasControls())
                {
                    foreach (Control ctrl in dvr.Cells[1].Controls)
                    {
                        if (ctrl is TextBox)
                        {
                            TextBox txt = ctrl as TextBox;
                            txt.Text = txt.Text.Trim();
                        }
                    }
                }
            }
        }

    }
    protected void cvEditCardType_ServerValidate_ServerValidate(object source, ServerValidateEventArgs args)
    {

    }
    protected void cvInsertNickname_ServerValidate(object source, ServerValidateEventArgs args)
    {
        string userName = User.Identity.Name;
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {
            // Get the value of the new UPC from the DetailsView control.
            TextBox txtInsertNickname = (TextBox)dvDelivery.FindControl("InsertNickname");

            // Count how many existing records have the student id value.
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Address] WHERE ([userName] = '" + userName + "' AND [nickname] = N'" + txtInsertNickname.Text + "')", connection);
            Int32 count = (Int32)command.ExecuteScalar();
            connection.Close();

            // If the count is not zero the UPC already exists, so cancel the insert.
            if (count != 0)
            {
                args.IsValid = false;
            }
        }
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
        GridViewRow row = gvDelivery.SelectedRow;

        string currentNickname = ((TextBox)dvDelivery.FindControl("EditNickname")).Text.Trim();
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;

        Int32 count = 0;
        Int32 MaxRows = gvDelivery.Rows.Count;

        for (int i = 0; i < MaxRows; i++)
        {
            if (gvDelivery.Rows[i] != row) //not the selected row
            {
                if (((Label)gvDelivery.Rows[i].FindControl("nickname")).Text.Trim() == currentNickname)
                {
                    count++;
                }
            }
        }

        if (count == 0)
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }
    protected void EditIsDefault_CheckedChanged(object sender, EventArgs e)
    {

    }
    protected void InsertIsDefault_CheckedChanged(object sender, EventArgs e)
    {

    }
}