using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

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
}
