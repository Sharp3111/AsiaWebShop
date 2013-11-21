using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.IO;
using System.Text.RegularExpressions;
using System.Net.Mail;



public partial class ItemManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

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

            // Count how many existing records have the student id value.
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
        args.IsValid = true;

        // Get the value of the new Category from the DetailsView control.
        TextBox txtCategory = (TextBox)dvItem.FindControl("EditCategory");

        // Count the number of matching categories: either 1 or none.
        string C1 = "Appliances";
        string C2 = "Baby and Children";
        string C3 = "Computers and Electronics";
        string C4 = "Jewelry and Watches";
        string C5 = "Luggage";
        string C6 = "Men";
        string C7 = "Toys and Games";
        string C8 = "Women";

        if (!(txtCategory.Text.Trim().Equals(C1, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C2, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C3, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C4, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C5, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C6, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C7, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C8, StringComparison.Ordinal)))
        {
            args.IsValid = false;
        }
    }

    protected void cvInsertCategory_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = true;

        // Get the value of the new Category from the DetailsView control.
        TextBox txtCategory = (TextBox)dvItem.FindControl("InsertCategory");

        // Count the number of matching categories: either 1 or none.
        string C1 = "Appliances";
        string C2 = "Baby and Children";
        string C3 = "Computers and Electronics";
        string C4 = "Jewelry and Watches";
        string C5 = "Luggage";
        string C6 = "Men";
        string C7 = "Toys and Games";
        string C8 = "Women";

        if (!(txtCategory.Text.Trim().Equals(C1, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C2, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C3, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C4, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C5, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C6, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C7, StringComparison.Ordinal) ||
             txtCategory.Text.Trim().Equals(C8, StringComparison.Ordinal)))
        {
            args.IsValid = false;
        }
    }

    protected void cvInsertPicture_ServerValidate(object source, ServerValidateEventArgs args)
    {
        FileUpload fileName = (FileUpload)dvItem.FindControl("pictureFileUpload");

        string fileExtension = System.IO.Path.GetExtension(fileName.FileName);

        string fileMimeType = fileName.PostedFile.ContentType;

        int fileLengthInKB = fileName.PostedFile.ContentLength / 512;




        string[] matchExtension = { ".jpg", ".jpeg", ".JPG", "JPEG" };

        string[] matchMimeType = { "image/jpeg" };





        if (matchExtension.Contains(fileExtension) && matchMimeType.Contains(fileMimeType))
        {
            if (fileLengthInKB > 512)
            {
                //Please choose a file less than 512kb
                args.IsValid = false;

            }

        }

        else
        {

            //Please choose only jpg, png or gif file.
            args.IsValid = false;

        }
    }
    protected void cvEditPicture_ServerValidate(object source, ServerValidateEventArgs args)
    {
        FileUpload fileName = (FileUpload)dvItem.FindControl("pictureFileUpload");

        string fileExtension = System.IO.Path.GetExtension(fileName.FileName);

        string fileMimeType = fileName.PostedFile.ContentType;

        int fileLengthInKB = fileName.PostedFile.ContentLength / 512;




        string[] matchExtension = { ".jpg", ".jpeg", ".JPG", "JPEG" };

        string[] matchMimeType = { "image/jpeg" };





        if (matchExtension.Contains(fileExtension) && matchMimeType.Contains(fileMimeType))
        {
            if (fileLengthInKB > 512)
            {
                //Please choose a file less than 512kb
                args.IsValid = false;

            }

        }

        else
        {

            //Please choose only jpg, png or gif file.
            args.IsValid = false;

        }
    }

    private bool isValid(string price)
    {
        return Regex.IsMatch(price, @"^([1-9]{1}[\d]{0,2}(\,[\d]{3})*(\.[\d]{0,2})?|[1-9]{1}[\d]{0,}(\.[\d]{0,2})?|0(\.[\d]{0,2})?|(\.[\d]{1,2})?)$");
    }

    protected void cvEditDiscountPrice_ServerValidate(object source, ServerValidateEventArgs args)
    {
        string txtDiscountPrice = ((TextBox)dvItem.FindControl("EditDiscountPrice")).Text.Trim();
        string txtNormalPrice = ((TextBox)dvItem.FindControl("EditNormalPrice")).Text.Trim();

        if (isValid(txtDiscountPrice) && isValid(txtNormalPrice))
        {
            Decimal discountPrice = Convert.ToDecimal(((TextBox)dvItem.FindControl("EditDiscountPrice")).Text.Trim());
            Decimal normalPrice = Convert.ToDecimal(((TextBox)dvItem.FindControl("EditNormalPrice")).Text.Trim());

            if (discountPrice > normalPrice)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }
        else
        {
            args.IsValid = false;
        }
    }
    protected void cvInsertDiscountPrice_ServerValidate(object source, ServerValidateEventArgs args)
    {
        string txtDiscountPrice = ((TextBox)dvItem.FindControl("InsertDiscountPrice")).Text.Trim();
        string txtNormalPrice = ((TextBox)dvItem.FindControl("InsertNormalPrice")).Text.Trim();

        if (isValid(txtDiscountPrice) && isValid(txtNormalPrice))
        {
            Decimal discountPrice = Convert.ToDecimal(((TextBox)dvItem.FindControl("InsertDiscountPrice")).Text.Trim());
            Decimal normalPrice = Convert.ToDecimal(((TextBox)dvItem.FindControl("InsertNormalPrice")).Text.Trim());

            if (discountPrice > normalPrice)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }
        else
        {
            args.IsValid = false;
        }
    }
    protected void dvItem_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        
    }
    protected void dvItem_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        /*Int32 quantity;
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {
            // Get the value of the current UPC from the DetailsView control.
            Label lblUPC = (Label)dvItem.FindControl("Label1");

            // Get the current quantityAvailable
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT [quantityAvailable] FROM [Item] WHERE ([upc] = N'" + lblUPC.Text + "')", connection);
            quantity = (Int32)command.ExecuteScalar();
            connection.Close();
        }

        // If quantity == 0 and is being updated to a positive number, then send email alert
        Int32 updatedQuantity = Convert.ToInt32(((TextBox)dvItem.FindControl("EditQuantityAvailable")).Text.Trim());
            
        if ((quantity == 0) && (updatedQuantity > 0))
        {
            // Create an instance of MailMessage named mail.
            MailMessage mail = new MailMessage();

            // Create an instance of SmtpClient named emailServer and set the mail server to use as "smtp.ust.hk".
            SmtpClient emailServer = new SmtpClient("smtp.ust.hk");
            emailServer.UseDefaultCredentials = false;
            emailServer.Port = 587;
            emailServer.EnableSsl = true;
            System.Net.NetworkCredential basicAuthenticationInfo = new System.Net.NetworkCredential("wliab", "vdKv42##");
            emailServer.Credentials = basicAuthenticationInfo;
            emailServer.Timeout = 5000;

            // Prepare necessary information
            string itemName = ((TextBox)dvItem.FindControl("EditName")).Text.Trim();

            // Set the sender (From), receiver (To), subject and message body fields of the mail message.
            mail.From = new MailAddress("sharp@cse.ust.hk", "AsiaWebShop");
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
            {
                // Get the email addresses subscribed to the item
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT [email] FROM [Subscription] WHERE ([name] = N'" + itemName + "')", connection);
                string subscriber = (string)command.ExecuteScalar();
                if (subscriber != null)
                {
                    mail.To.Add(subscriber);
                    mail.Subject = itemName + " is Available!";
                    mail.Body = "Dear Customer,\nThank you for your interest in " + itemName + ". New stock for this item is available. Act now!\nAsiaWebShop";

                    // Send the message.
                    emailServer.Send(mail);
                }
                connection.Close();
            }
            
        }*/
    }
}