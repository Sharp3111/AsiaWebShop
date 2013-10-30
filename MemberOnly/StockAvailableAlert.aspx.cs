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

public partial class MemberOnly_StockAvailableAlert : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {   //Item was passed through URL, i.e. ?item=
            //can change to textbos but need a validator
            string item = Request.QueryString["item"];
            itemLabel.Text = item;
            
            // Populate the DistrictDropDownList.
            email.Items.Add("-- Select email --");

            string SQLCmd = "SELECT [email] FROM [Member] WHERE [userName] = '"+User.Identity.Name+"'";

            string connectionString = "AsiaWebShopDBConnectionString";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(SQLCmd, connection))
            {
                command.Connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        email.Items.Add(reader["email"].ToString().Trim());
                    }
                }
                command.Connection.Close();
                reader.Close();
            }

        }
    }
    protected void request_Click(object sender, EventArgs e)
    {
        //waiting for future operation.
        if (IsValid)
        {

        }

    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (email.SelectedValue == "-- Select email --")
            args.IsValid = false;
        else
            args.IsValid =true;
    }
}