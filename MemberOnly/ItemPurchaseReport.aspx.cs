using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MemberOnly_ItemPurchaseReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserName.Text = User.Identity.Name;
    }
    protected void GenerateReportButton_Click(object sender, EventArgs e)
    {

    }
}