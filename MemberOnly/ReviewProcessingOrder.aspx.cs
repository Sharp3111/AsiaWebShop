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

public partial class MemberOnly_ReviewProcessingOrder : System.Web.UI.Page
{
    DataTable dtDeliveryTime = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string userName = User.Identity.Name;

            UserName.Text = userName;

            createDataTable();
            getOrderData(connectionString,userName);
            
            gvDeliveryTime.DataSource = dtDeliveryTime;
            gvDeliveryTime.DataBind();
            Label1.Text = "";
        }
    }

    void createDataTable() 
    {
        dtDeliveryTime.Columns.Add("Name", typeof(string));
        dtDeliveryTime.Columns.Add("Email", typeof(string));
        dtDeliveryTime.Columns.Add("PhoneNumber", typeof(string));
        dtDeliveryTime.Columns.Add("Address", typeof(string));
        dtDeliveryTime.Columns.Add("DeliveryDate", typeof(string));
        dtDeliveryTime.Columns.Add("DeliveryTime", typeof(string));
        dtDeliveryTime.Columns.Add("ConfirmationNumber", typeof(string));
    }

    void getOrderData(string connectionString, string username)
    {
        string query = "SELECT [name] , [email] , [phoneNumber] , [address] , [deliveryDate] , [deliveryTime] , [confirmationNumber] FROM [OrderRecord] WHERE (isConfirmed = 'True' AND [userName] = '" + username + "') GROUP BY [name] , [email] , [phoneNumber] , [address] , [deliveryDate] , [deliveryTime] , [confirmationNumber]";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    string name = reader.GetString(0);
                    string email = reader.GetString(1);
                    string phoneNumber = reader.GetString(2);
                    string address = reader.GetString(3);
                    string deliveryDate = reader.GetString(4);
                    string deliveryTime = reader.GetString(5);
                    string confirmationNumber = reader.GetString(6);

                    DateTime deliveryDateTime = Convert.ToDateTime(deliveryDate.Trim() + ' ' + deliveryTime.Split('-')[1].Trim());
                    
                    //Response.Write("<script>alert('" + deliveryDateTime.AddDays(-1).ToString() + "')</script>");
                    if(deliveryDateTime.AddDays(-1)>DateTime.Now)
                        dtDeliveryTime.Rows.Add(name,email,phoneNumber,address,deliveryDate,deliveryTime,confirmationNumber);
                }
            }
            command.Connection.Close();
            reader.Close();
        }

    }
    protected void cbOrderRecord_CheckedChanged(object sender, EventArgs e)
    {
        bool isChecked = ((CheckBox)(sender as object)).Checked;
        int MaxRow = gvDeliveryTime.Rows.Count;

        //Response.Write("<script>alert('" + MaxRow + "')</script>");
        for (int i = 0; i < MaxRow; i++)
        {
            ((CheckBox)gvDeliveryTime.Rows[i].FindControl("cbOrderRecord")).Checked=false;
        }

        ((CheckBox)(sender as object)).Checked = isChecked;

        Label1.Text = "";
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        int MaxRow = gvDeliveryTime.Rows.Count;

        for (int i = 0; i < MaxRow; i++)
        {
            if (((CheckBox)gvDeliveryTime.Rows[i].FindControl("cbOrderRecord")).Checked)
            {
                string confirmationNumber = gvDeliveryTime.Rows[i].Cells[7].Text;
                //Response.Write("<script>alert('" + confirmationNumber + "')</script>");
                Response.Redirect("ChangeDeliveryInformation.aspx?confirmationNumber="+confirmationNumber);
            }
        }

        Label1.Text = "Please choose an order!";
    }
}