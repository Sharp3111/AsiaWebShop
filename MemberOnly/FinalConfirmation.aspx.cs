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
        string userName = User.Identity.Name;
        if (IsValid)
        {
            string authNum = "";
            char[] confirmationNum = new char[] {'A','A','0','0','0','0','0','0'};

            /*Int32 cardNumberHead = 0;            
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
            */

            do
            {
                Random random = new Random((unchecked((int)DateTime.Now.Ticks)));
                StringBuilder builder = new StringBuilder();
                char ch;
                for (int i = 0; i < 4; i++)
                {
                    ch = (char)random.Next('0', '9' + 1);
                    builder.Append(ch);
                }
                authNum = builder.ToString();
            }
            while (!codeCheck(authNum, "authorizationCode"));
            codeInsert(authNum, "authorizationCode");

            do
            {
                confirmationNum[7] ++;
                for ( int i = 0; i < 6; i++) {
                    if (confirmationNum[7 - i] == '9' + 1)
                    {
                        confirmationNum[7 - i] = '0';
                        confirmationNum[6 - i]++;
                    }
                    if (i == 5) {
                        if(confirmationNum[1] == 'Z'+1) {
                            confirmationNum[1] = 'A';
                            confirmationNum[0] ++;
                        }
                        if(confirmationNum[0] == 'Z'+1) {
                            confirmationNum[0] = 'A';
                        }
                    }
                }
            }
            while (!codeCheck(new string(confirmationNum),"confirmationNumber"));//count the docNum in DB if > 0, redo
            codeInsert(new string(confirmationNum), "confirmationNumber");
            //finalConfirmCode.Text = new string(confirmationNum);
            // Create an instance of MailMessage named mail.
            MailMessage mail = new MailMessage();

            // Create an instance of SmtpClient named emailServer and set the mail server to use as "smtp.cse.ust.hk".
            SmtpClient emailServer = new SmtpClient("smtp.cse.ust.hk");

            // Set the sender (From), receiver (To), subject and message body fields of the mail message.
            mail.From = new MailAddress("sharpert115@yeah.net", "Asia Web Shop t115 @Sharp");
            mail.To.Add(emailAddress.Text.Trim());
            mail.Subject = "Receipt";

            //Gather information
            string confirmationNumber = "";

            string itemsInformation = "Purchased item(s) information:\n";
            string itemPurchased = "";
            Int32 quantityPurchased = 0;
            Decimal unitPurchasePrice = 0;
            Decimal totalPurchasePriceOfEachItem = 0;
            string totalPurchasePrice = totalPrice.Text.Trim();
            Decimal totalPurchaseOriginalPrice = 0;
            string amountSaved = ""; //??????????????????????????????????????????????????????????????????????????????????????????//DB needs modification
            string authorizationCode = "";
            string deliveryInformation = "";
            string orderDateTime = DateTime.Now.ToString().Trim();

            string query1 = "SELECT upc, unitPrice, normalPrice, quantity FROM [OrderRecord] WHERE (userName = '" + userName + "' AND isConfirmed = 'False')";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(query1, connection))
            {
                command.Connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                // Check if a result was returned.
                if (reader.HasRows)
                {

                    // Iterate through the table to get the retrieved values.
                    while (reader.Read())
                    {
                        itemPurchased = ConvertUPCToItemName(reader["upc"].ToString().Trim());
                        Decimal unitNormalPrice = Convert.ToDecimal(reader["normalPrice"].ToString().Trim());
                        unitPurchasePrice = Convert.ToDecimal(reader["unitPrice"].ToString().Trim());
                        quantityPurchased = Convert.ToInt32(reader["quantity"].ToString().Trim());
                        totalPurchasePriceOfEachItem = unitPurchasePrice * quantityPurchased;

                        //totalPurchaseOriginalPrice is used to calculate the amount saved
                        totalPurchaseOriginalPrice += unitNormalPrice * quantityPurchased;

                        itemsInformation +="Item name:                            " + itemPurchased.ToString().Trim() + '\n';
                        itemsInformation +="Quanity purchased:                    " + quantityPurchased.ToString().Trim() + '\n';
                        itemsInformation +="Unit purchase price:              HKD " + unitPurchasePrice.ToString().Trim() + '\n';
                        itemsInformation +="Total purchase price of this item:HKD " + totalPurchasePriceOfEachItem.ToString().Trim() + '\n';                        
                    }
                }

                // Close the connection and the DataReader.
                command.Connection.Close();
                reader.Close();
            }
            itemsInformation += "\nTotal purchase price:                   HKD ";
            itemsInformation += totalPurchasePrice;

            amountSaved = (totalPurchaseOriginalPrice - Convert.ToDecimal(totalPurchasePrice)).ToString().Trim();
            itemsInformation += "\nAmount saved from current normal price: HKD ";
            itemsInformation += amountSaved;

            string query2 = "SELECT confirmationNumber, authorizationCode, name, email, phoneNumber, address, deliveryDate, deliveryTime FROM [OrderRecord] WHERE (userName = '" + userName + "' AND isConfirmed = 'False')";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(query2, connection))
            {
                command.Connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                // Check if a result was returned.
                if (reader.HasRows)
                {
                    // Iterate through the table to get the retrieved values.
                    while (reader.Read())
                    {
                        confirmationNumber = reader["confirmationNumber"].ToString().Trim();
                        authorizationCode = reader["authorizationCode"].ToString().Trim();
                        deliveryInformation = "Name:               " + reader["name"].ToString().Trim() + '\n'
                                         + "phoneNumber:        " + reader["phoneNumber"].ToString().Trim() + '\n'
                                         + "Email Address:      " + reader["email"].ToString().Trim() + '\n'
                                         + "Address:            " + reader["address"].ToString().Trim() + '\n'
                                         + "Delivery Date:      " + reader["deliveryDate"].ToString().Trim() + '\n'
                                         + "Delivery Time:      " + reader["deliveryTime"].ToString().Trim() + '\n';
                        break;
                    }
                }

                // Close the connection and the DataReader.
                command.Connection.Close();
                reader.Close();
            }

            Label creditCardNumberLabel = (Label)paymentMethod.Rows[0].FindControl("cardNumberLabel");
            string creditCardNumber_temp = creditCardNumberLabel.Text.Trim();
            int creditCardNumberStars = creditCardNumber_temp.Length - 4;
            string creditCardNumber_temp2 = Reverse(creditCardNumber_temp);
            string creditCardNumber = "";
            for(int i = 0; i < creditCardNumberStars; i++)
            {
                creditCardNumber += "*";
            }

            creditCardNumber += Reverse(creditCardNumber_temp2.Substring(0,4));

            string creditCardType = "";
            //Retrieve 
            string query3 = "SELECT type FROM [CreditCard] WHERE (userName = '" + userName + "' AND number = '" + creditCardNumber_temp + "')";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(query3, connection))
            {
                command.Connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                // Check if a result was returned.
                if (reader.HasRows)
                {
                    // Iterate through the table to get the retrieved values.
                    while (reader.Read())
                    {
                         creditCardType = reader["type"].ToString().Trim();
                    }
                }

                // Close the connection and the DataReader.
                command.Connection.Close();
                reader.Close();
            }

            //the amount that the member saved from the normal price is not included ???? Needs further working
            mail.Body = "Dear " + User.Identity.Name + ", your latest purchase detail is as follows:\n\n"
                        + "Confirmation #:\n" + confirmationNumber + '\n' + '\n'
                        + "Order date and time:\n" + orderDateTime + '\n' + '\n'
                        + "Item information:\n" + itemsInformation + '\n' + '\n'
                        + "Delivery information:\n" + deliveryInformation + '\n' + '\n'
                        + "Payment information:\n"
                        + "Credit Card #:       " + creditCardNumber + '\n'
                        + "Credit Card Type:    " + creditCardType + '\n' + '\n'
                        + "Authorization Code:  " + authorizationCode + '\n' + '\n'
                        + '\n' + '\n'
                        + "Note: this is a system generated email receipt, please do not reply.";

            // Send the message.
            emailServer.Send(mail);

            //delete corresponding items in the shopping cart
            UpdateShoppingCart(connectionString, userName);

            //final confirm
            //finalConfirm();
            Server.Transfer("FinalConfirmDisplay.aspx");
        }


    }
    protected void deliverAddress_DataBound(object sender, EventArgs e)
    {
        //There must be a delivery address in the table, take the first one
        GridViewRow row = deliverAddress.Rows[0];
        Label EmailLabel = (Label)row.FindControl("EmailLabel");
        string email = EmailLabel.Text.Trim();

        emailAddress.Text = email;
    }

    private string ConvertUPCToItemName(string UPC)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        //string userName = User.Identity.Name;

        string itemName = "";
        string query = "SELECT name FROM [Item] WHERE (upc = '" + UPC + "')";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            // Check if a result was returned.
            if (reader.HasRows)
            {
                // Iterate through the table to get the retrieved values.
                while (reader.Read())
                {
                    itemName= reader["name"].ToString().Trim();
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }

        return itemName;
    }

    private void UpdateShoppingCart(string connectionString, string userName)
    {
        

        Int32 MaxRows = itemPurchase.Rows.Count;
        for (int i = 0; i < MaxRows; i++)
        {
            string currentUPC = ((Label)itemPurchase.Rows[i].FindControl("upcLabel")).Text.Trim();
            string queryDelete = "DELETE FROM [ShoppingCart] WHERE (userName = '" + userName + "' AND upc = '" + currentUPC + "')";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(queryDelete, connection))
            {
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }
    }


}