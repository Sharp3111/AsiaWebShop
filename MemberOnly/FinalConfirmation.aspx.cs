﻿using System;
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
        string query = "SELECT COUNT FROM [OrderRecord] WHERE [" + column + "] =" + code + ") AND isConfirmed = 1";
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
        string query = "UPDATE OrderRecord SET "+ column +"= "+ code + " WHERE isConfirmed = 0 AND userName = "+User.Identity.Name ;

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
        string query = "UPDATE OrderRecord SET isConfirmed = 1, orderDateTime = CAST('"+ System.Data.SqlDbType.SmallDateTime+"' AS smalldatetime WHERE isConfirmed = 0 AND userName = " + User.Identity.Name;

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    protected void confirm_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            string authNum = "";
            string confirmationNum = "";

            int cardNumber = 0;
            int purchaseAmount= 0;

            string connectionString = "AsiaWebShopDBConnectionString";
            string query = "SELECT [creditCardNumber], SUM([unitPrice]*[quantity])AS [totalPrice], FROM [OrderRecord] WHERE [isConfirmed] = 0 AND [username] = " + User.Identity.Name + " GROUP BY [username],[creditCardNumber]";

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
                        cardNumber = Convert.ToInt32(reader["creditCardNumber"].ToString().Trim());
                        purchaseAmount = Convert.ToInt32(reader["totalPrice"].ToString().Trim());
                    }
                }

                // Close the connection and the DataReader.
                command.Connection.Close();
                reader.Close();
            }

            do
            {
                Random random_ = new Random(cardNumber + purchaseAmount);
                StringBuilder builder_ = new StringBuilder();
                char ch_;
                for (int i = 0; i < 4; i++)
                {
                    ch_ = (char)random_.Next('0', '9' + 1);
                    builder_.Append(ch_);
                }
                authNum = builder_.ToString();
            }
            while (codeCheck(authNum, "authorizationCode"));
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
            while (codeCheck(confirmationNum,"confirmationNumber"));//count the docNum in DB if > 0, redo
            codeInsert(confirmationNum, "confirmationNumber");

            finalConfirm();
        }

    }
}