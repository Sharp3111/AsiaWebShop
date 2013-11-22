using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;




public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
 
        Session.Timeout = 1;
    }

    protected void LoginStatus_LoggingOut(Object sender, EventArgs e)
    {
        Session.Abandon();
        //Response.Write("<script>alert('adsfsdfasdf')</script>");
        //Response.Redirect("About.aspx");
        
    }


}
