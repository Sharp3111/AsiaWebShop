using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class ItemDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userName = Request.QueryString["userName"];
    }



    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        CheckBox cbx = (CheckBox)dvItemDetails.FindControl("CheckBox1");
        Label Username = (Label)dvItemDetails.FindControl("Label1");
        
        MembershipUser user = Membership.GetUser(Username.Text.ToString().Trim());
        
        //Response.Write(@"<script language='javascript'>alert('" + cbx.ToString() + user + " ');</script>");
        
        if(cbx.Checked)
            user.IsApproved = true;
        else
            user.IsApproved = false;

        Membership.UpdateUser(user);
    }
}