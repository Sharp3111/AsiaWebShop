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
using System.Text;
using System.Net.Mail;

//Page description:
/*  Finally, a final confirmation page should be displayed showing all the details of the member’s 
 *  purchase including item, delivery and payment information. The member should [be able to edit any of ] <------------ !!!!!!!!!............
 *  this information. After the member has confirmed the information on the final confirmation page, a 
 *  confirmation for his purchase should be displayed and the appropriate quantity available of 
 *  each item purchased should be updated. 
 *  A confirmation number should be a unique system-generated identifier consisting of eight alphanumeric characters (two letters 
 *  followed by six decimal digits). 
 */
//TODO list:
/* 1.display and edit item
 * 2.display and edit delivery information
 * 3.display and edit payment method
 * 4.connect to a credit card authorization authority and transmit some details of the purchase (credit card number and purchase amount),
 *   it will return a 4-digit authorization code that is kept by 
 *   AsiaWebShop as part of the purchase information, or decline it as may be the case when a card is fake or 
 *   has expired. 
 * 5.generate a purchase identifier
 * 6.send purchase receipt to user's email (please refer to the statement for detail
 */



public partial class MemberOnly_FinalConfirmationPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        userName.Text = User.Identity.Name;

        string SQLCmd = "SELECT SUM([unitPrice]*[quantity])AS [totalPrice] FROM [OrderRecord] WHERE [isConfirmed] = 0 AND [userName] = '" + User.Identity.Name + "' GROUP BY [userName]";
        string connectionString = "AsiaWebShopDBConnectionString";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(SQLCmd, connection))
            {
                command.Connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Read();
                    totalPrice.Text = reader["totalPrice"].ToString().Trim();
                }
                command.Connection.Close();
                reader.Close();
            }



        /*
        string SQLCmd2 = "SELECT [email] FROM [Member] WHERE [userName] = '"+User.Identity.Name+"'";

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(SQLCmd2, connection))
            {
                command.Connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        emailAddress.Text = (reader["email"].ToString().Trim());
                    }
                }
                command.Connection.Close();
                reader.Close();
            }

        */
    }

    /*private Random random = new Random((int)DateTime.Now.Ticks);
    private string RandomLetter()
    {
        StringBuilder builder = new StringBuilder();
        char ch;
        for (int i = 0; i < 2; i++)
        {
            ch = (char)random.Next('A', 'Z' + 1);
            builder.Append(ch);
        }

        for (int i = 0; i < 6; i++)
        {
            ch = (char)random.Next('0', '9' + 1);
            builder.Append(ch);
        }

        return builder.ToString();
    }
    */

    public bool codeCheck(string code, string column)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        string query = "SELECT COUNT(*) FROM [OrderRecord] WHERE (" + column + " = '" + code + "' AND isConfirmed = 'True')";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Open the connection.
            command.Connection.Open();
            // Execute the SELECT query and place the result in a DataReader.
            int count = (Int32)command.ExecuteScalar();
            command.Connection.Close();
            if (count == 0)
                return true;
            else
                return false;

        }
    }

    public void codeInsert(string code, string column) 
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        string query = "UPDATE OrderRecord SET "+ column +" = '"+ code + "' WHERE (isConfirmed = 'False' AND userName = '"+User.Identity.Name + "')" ;

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    public void finalConfirm()
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        string query = "UPDATE OrderRecord SET isConfirmed = 'True', orderDateTime = CURRENT_TIMESTAMP WHERE (isConfirmed = 'False' AND userName = '" + User.Identity.Name + "')";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    public static string Reverse(string s)
    {
        char[] charArray = s.ToCharArray();
        Array.Reverse(charArray);
        return new string(charArray);
    }

    protected void confirm_Click(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        if (IsValid)
        {
            string authNum = "";
            string confirmationNum = "";

            Int32 cardNumberHead = 0;            
            Int32 cardNumberTail = 0;

            
            string query = "SELECT [creditCardNumber] FROM [OrderRecord] WHERE [isConfirmed] = 0 AND [username] = N'" + User.Identity.Name + "' GROUP BY [username], [creditCardNumber]";

            // Create the connection and the SQL command.
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                // Open the connection.
                command.Connection.Open();
                // Execute the SELECT query and place the result in a DataReader.
                SqlDataReader reader = command.ExecuteReader();
                // Check if a result was returned.
                if (reader.HasRows)
                {
                    // Iterate through the table to get the retrieved values.
                    while (reader.Read())
                    {
                        // Assign the data values to the web form labels.
                        cardNumberHead = Convert.ToInt32(reader["creditCardNumber"].ToString().Trim().Substring(0, 7));
                        cardNumberTail = Convert.ToInt32(reader["creditCardNumber"].ToString().Trim().Substring(7, 7));
                    }
                }

                // Close the connection and the DataReader.
                command.Connection.Close();
                reader.Close();
            }

            do
            {
                Random random_ = new Random(cardNumberHead + cardNumberTail);
                StringBuilder builder_ = new StringBuilder();
                char ch_;
                for (int i = 0; i < 4; i++)
                {
                    ch_ = (char)random_.Next('0', '9' + 1);
                    builder_.Append(ch_);
                }
                authNum = builder_.ToString();
            }
            while (!codeCheck(authNum, "authorizationCode"));
            codeInsert(authNum, "authorizationCode");

            do
            {
                Random random = new Random((int)DateTime.Now.Ticks);
                StringBuilder builder = new StringBuilder();
                char ch;
                for (int i = 0; i < 2; i++)
                {
                    ch = (char)random.Next('A', 'Z' + 1);
                    builder.Append(ch);
                }
                for (int i = 0; i < 6; i++)
                {
                    ch = (char)random.Next('0', '9' + 1);
                    builder.Append(ch);
                }
                confirmationNum = builder.ToString(); 
            }
            while (!codeCheck(confirmationNum,"confirmationNumber"));//count the docNum in DB if > 0, redo
            codeInsert(confirmationNum, "confirmationNumber");

            finalConfirm();
        }

        // Create an instance of MailMessage named mail.
        MailMessage mail = new MailMessage();

        // Create an instance of SmtpClient named emailServer and set the mail server to use as "smtp.cse.ust.hk".
        SmtpClient emailServer = new SmtpClient("smtp.cse.ust.hk");

        // Set the sender (From), receiver (To), subject and message body fields of the mail message.
        mail.From = new MailAddress("huanbang@gmail.com", "Asia Web Shop");
        mail.To.Add(emailAddress.Text.Trim());
        mail.Subject = "Receipt";

        //Gather information
        string confirmationNumber = "";

        string itemsInformation = "";
        string itemPurchased = "";
        string quantityPurchased = "";
        string unitPurchasePrice = "";
        string totalPurchasePriceOfEachItem = "";
        string totalPurchasePrice = totalPrice.Text.Trim();
        //string amountSaved = "";

        string deliveryInformation = "";

        Label creditCardNumberLabel = (Label)paymentMethod.Rows[0].FindControl("cardNumberLabel");
        string creditCardNumber = "";
        string creditCardType = "";

        string authorizationCode = "";

        string query1 = "SELECT "
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query1, connection))


        //the amount that the member saved from the normal price is not included ???? Needs further working
        mail.Body = "Dear " + User.Identity.Name + ", your latest purchase detail is as follows:\n\n"
                    + "Confirmation #:\n" + confirmationNumber + '\n' + '\n'
                    + "Item information:\n" + itemsInformation + '\n' + '\n'
                    + "Delivery information:\n" + deliveryInformation + '\n' + '\n'
                    + "Payment information:\n"
                    + "Credit Card #:     " + creditCardNumber + '\n'
                    + "Credit Card Type:  " + creditCardType + '\n' + '\n'
                    + "Authorization Code:" + authorizationCode + '\n' + '\n'
                    + '\n' + '\n'
                    + "Note: this is a system generated email receipt, please do not reply.";

        // Send the message.
        emailServer.Send(mail);
    }
    protected void deliverAddress_DataBound(object sender, EventArgs e)
    {
        //There must be a delivery address in the table, take the first one
        GridViewRow row = deliverAddress.Rows[0];
        Label EmailLabel = (Label)row.FindControl("EmailLabel");
        string email = EmailLabel.Text.Trim();

        emailAddress.Text = email;
    }
}