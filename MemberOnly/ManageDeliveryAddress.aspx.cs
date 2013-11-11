using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MemberOnly_DeliveryAddressManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;

            //GridView.DataKeyNames 
            UserName.Text = userName;

            //GetCreditCardInformationForGridView(connectionString, userName);

        }
    }

    protected void insertUserName_Load(object sender, EventArgs e)
    {
        ((TextBox)(sender as Control)).Text = User.Identity.Name.Trim();
    }

    protected void dvDelivery_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        gvDelivery.DataBind();
    }

    protected void InsertUserName_Load(object sender, EventArgs e)
    {
        ((TextBox)(sender as Control)).Text = User.Identity.Name.Trim();
        ((TextBox)(sender as Control)).ReadOnly = true;
    }
 
    protected void dvDelivery_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        gvDelivery.DataBind();
    }

}