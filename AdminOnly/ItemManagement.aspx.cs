using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;


public partial class ItemManagement : System.Web.UI.Page
{
    
    protected void dvItem_ItemDeleted(object sender, EventArgs e)
    {
        gvItem.DataBind();
    }

    protected void dvItem_ItemInserted(object sender, EventArgs e)
    {
        gvItem.DataBind();
    }

    protected void dvItem_ItemUpdated(object sender, EventArgs e)
    {
        gvItem.DataBind();
    }

    protected void cvInsertUPC_ServerValidate(object source, ServerValidateEventArgs args)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {
            // Get the value of the new UPC from the DetailsView control.
            TextBox txtUPC = (TextBox)dvItem.FindControl("InsertUPC");

            // Count how many existing records have the UPC value.
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Item] WHERE ([upc] = N'" + txtUPC.Text + "')", connection);
            Int32 count = (Int32)command.ExecuteScalar();
            connection.Close();

            // If the count is not zero the UPC already exists, so cancel the insert.
            if (count != 0)
            {
                args.IsValid = false;
            }
        }
    }
    protected void cvEditCategory_ServerValidate(object source, ServerValidateEventArgs args)
    {
        TextBox txtCategory = (TextBox)dvItem.FindControl("EditCategory");
        if (!(txtCategory.Text.Equals("Appliances") || txtCategory.Text.Equals("Jewelry and Watches") || txtCategory.Text.Equals("Toys and Games") || txtCategory.Text.Equals("Computers and Electronics") || txtCategory.Text.Equals("Women") || txtCategory.Text.Equals("Men") || txtCategory.Text.Equals("Luggage") || txtCategory.Text.Equals("Baby and Children")))
        {
            args.IsValid = false;
        }
    }
    protected void cvInsertCategory_ServerValidate(object source, ServerValidateEventArgs args)
    {
        TextBox txtCategory = (TextBox)dvItem.FindControl("InsertCategory");
        if (!(txtCategory.Text.Equals("Appliances") || txtCategory.Text.Equals("Jewelry and Watches") || txtCategory.Text.Equals("Toys and Games") || txtCategory.Text.Equals("Computers and Electronics") || txtCategory.Text.Equals("Women") || txtCategory.Text.Equals("Men") || txtCategory.Text.Equals("Luggage") || txtCategory.Text.Equals("Baby and Children")))
        {
            args.IsValid = false;
        }
    }
    protected void cvEditPicture_ServerValidate(object source, ServerValidateEventArgs args)
    {
        FileUpload Picture = (FileUpload)dvItem.FindControl("pictureFileUpload");
        String fileExtension = System.IO.Path.GetExtension(Picture.FileName).ToLower();
        if (Picture.PostedFile.ContentLength > 512 * 1024 || (!fileExtension.Equals(".jpg")) || (!fileExtension.Equals(".JPG")))
        {
            args.IsValid = false;
        }
    }
    protected void cvInsertPicture_ServerValidate(object source, ServerValidateEventArgs args)
    {
        FileUpload Picture = (FileUpload)dvItem.FindControl("pictureFileUpload");
        String fileExtension = System.IO.Path.GetExtension(Picture.FileName).ToLower();
        if (Picture.PostedFile.ContentLength > 512 * 1024 || (!fileExtension.Equals(".jpg")) || (!fileExtension.Equals(".JPG")))
        {
            args.IsValid = false;
        }
    }
}