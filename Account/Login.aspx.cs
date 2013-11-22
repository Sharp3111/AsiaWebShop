using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;


public partial class Account_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
    }
    protected void LoginUser_LoggingIn(object sender, LoginCancelEventArgs e)
    {
        e.Cancel = false;
        if (LoginUser.UserName.Trim() != "")
        {
            MembershipUser user = Membership.GetUser(LoginUser.UserName.Trim());
            if (user != null && !user.IsApproved)
            {
                ((Literal)LoginUser.FindControl("FailureText")).Text = "Your account is deactivated by administrator. Please contact the administrator for further information. ";
                e.Cancel = true;
            }
        }      
    }
    protected void LoginUser_LoggedIn(object sender, EventArgs e)
    {
        Session["Username"] = LoginUser.UserName;
        System.Diagnostics.Debug.Write("Login Username:");
        System.Diagnostics.Debug.WriteLine(Session["Username"].ToString());
        //Response.Write("<script>alert('" + (User.IsInRole("Member")).ToString() + "')</script>");
        //check if the item has already added into the shopping cart
        int count = 0;
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {

            connection.Open();
            SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [ShoppingCart] WHERE ([userName] = N'" + LoginUser.UserName + "')", connection);
            count = (Int32)command.ExecuteScalar();
            connection.Close();
        }
        if (count > 0)
        {
            //Response.Redirect("~/MemberOnly/ShoppingCart.aspx");

            string query = "UPDATE [ShoppingCart] SET [isReleased] = 'False' FROM [Item] JOIN [ShoppingCart] ON ([ShoppingCart].[upc] = [Item].[upc]) WHERE ([Item].[quantityAvailable] - [ShoppingCart].[quantity]>'0' AND [ShoppingCart].[userName] = '" + LoginUser.UserName + "')";

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                {

                    // Open the connection, execute the INSERT query and close the connection.
                    command.Connection.Open();
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                }
            }

            query = "UPDATE [Item] SET [quantityAvailable] = ([Item].[quantityAvailable] - [ShoppingCart].[quantity]) FROM [Item] JOIN [ShoppingCart] ON ([ShoppingCart].[upc] = [Item].[upc]) WHERE ([Item].[quantityAvailable] - [ShoppingCart].[quantity]>'0' AND [ShoppingCart].[userName] = '" + LoginUser.UserName + "')";

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                {

                    // Open the connection, execute the INSERT query and close the connection.
                    command.Connection.Open();
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                }
            }

            int isReleasedCount = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
            {

                connection.Open();
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [ShoppingCart] WHERE ([isReleased]='True' AND [userName] = N'" + LoginUser.UserName + "')", connection);
                isReleasedCount = (Int32)command.ExecuteScalar();
                connection.Close();
            }

            if (isReleasedCount > 0)
            {
                Response.Redirect("~/MemberOnly/ShoppingCart.aspx");
                Session["ReserveFailed"] = "True";
            }
        }


    }
}
