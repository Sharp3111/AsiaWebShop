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
        result.Visible = false;
        if (!Page.IsPostBack)
        {   //Item was passed through URL, i.e. ?item=
            //can change to textbos but need a validator
            //string item = Request.QueryString["item"];
            string upc = Request.QueryString["upc"];
            //itemBox.Text = item;
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

            if (upc != null)
            {
                SQLCmd = "SELECT [name] FROM [Item] WHERE [upc] = '" + upc + "'";

                connectionString = "AsiaWebShopDBConnectionString";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand(SQLCmd, connection))
                {
                    command.Connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            itemBox.Text = reader["name"].ToString().Trim();
                        }
                    }
                    command.Connection.Close();
                    reader.Close();
                }
            }

        }
    }
    protected void request_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            
            string SQLCmd = "INSERT INTO [Subscription]([email],[name]) VALUES ('" + email.SelectedValue + " ',' " + itemBox.Text.Trim() +" ')";
            string connectionString = "AsiaWebShopDBConnectionString";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(SQLCmd, connection))
            {
                command.Connection.Open();
                command.ExecuteScalar();
                command.Connection.Close();
            }
            result.Text = "Redord Added!";
            result.Visible = true;
        }
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (email.SelectedValue == "-- Select email --")
            args.IsValid = false;
        else
            args.IsValid =true;
    }
    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
    {
        int count = 0;
        string SQLCmd = "SELECT COUNT(1) FROM [Item] WHERE ([name] ='" + itemBox.Text.Trim() + "')";
        string connectionString = "AsiaWebShopDBConnectionString";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(SQLCmd, connection))
        {
            command.Connection.Open();
            count = (Int32)command.ExecuteScalar();
            command.Connection.Close();
        }
        if (count == 0)
            args.IsValid = false;
        else
            args.IsValid = true;
    }
    protected void CustomValidator3_ServerValidate(object source, ServerValidateEventArgs args)
    {
        /*
         * cannot count name from Subscription
         * works well when count email
         * works well when count in table item
         */
            int count = 0;
//            Response.Write("<script>alert('" + itemBox.Text.Trim() + "')</script>");
            string SQLCmd = "SELECT COUNT(1) FROM [Subscription] WHERE ([name] LIKE '%" + itemBox.Text.Trim() + "%' AND [email] = '" + email.SelectedValue + "') ";
            string connectionString = "AsiaWebShopDBConnectionString";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(SQLCmd, connection))
            {
                command.Connection.Open();
                count = (Int32)command.ExecuteScalar();
                command.Connection.Close();
            }
            //Response.Write("<script>alert('" + count + "')</script>");
            if (count != 0)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }

    }
}