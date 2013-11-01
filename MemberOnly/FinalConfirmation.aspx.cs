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
        emailAddress.Items.Add("-- Select email --");

        string SQLCmd = "SELECT SUM([unitPrice]*[quantity])AS [totalPrice] FROM [OrderRecord] WHERE [userName] = '" + User.Identity.Name + "' GROUP BY [userName]";
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
                        emailAddress.Items.Add(reader["email"].ToString().Trim());
                    }
                }
                command.Connection.Close();
                reader.Close();
            }
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (emailAddress.SelectedValue == "-- Select email --")
            args.IsValid = false;
        else
            args.IsValid = true;
    }
    protected void confirm_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
        }

    }
}