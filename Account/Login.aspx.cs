using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class Account_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
    }



    protected void LoginUser_LoggingIn(object sender, LoginCancelEventArgs e)
    {

        // Get the username from the Deactive textbox
        string username = LoginUser.UserName;

        string query = "SELECT COUNT(*) FROM [Member] WHERE ([userName] = N'" + username + "') ";

        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Count how many existing records using this user name.
            command.Connection.Open();
            Int32 count = (Int32)command.ExecuteScalar();
            command.Connection.Close();

            if (count == 0)
            {
                LoginUser.FailureText = "User not found.";
            }
            else
            {

                MembershipUser user = Membership.GetUser(LoginUser.UserName);

                if (user.IsApproved == false)
                {
                    LoginUser.FailureText = "Your account has been deactivated .";
                }
                else 
                {
                    LoginUser.FailureText = "Wrong password.";
                }
            }
        }

            
       
    
    }
    protected void UserNameExist_ServerValidate(object source, ServerValidateEventArgs args)
    {

    }
        
}
