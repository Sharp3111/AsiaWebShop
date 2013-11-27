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

public partial class AdminOnly_RecommendationManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void submitButton_Click(object sender, EventArgs e)
    {
        //if the page is valid, do the following
        if (IsValid)
        {
            string DAILY =      "RecommendationDay";
            string WEEKLY =     "RecommendationWeek";
            string MONTHLY =    "RecommendationMonth";
            string YEARLY =     "RecommendationYear";


            string recommendationTable = "";
            if(rangeRadioButtonList.SelectedValue.Equals("0", StringComparison.Ordinal))
            {
                recommendationTable = DAILY;
            }
            else if(rangeRadioButtonList.SelectedValue.Equals("1", StringComparison.Ordinal))
            {
                recommendationTable = WEEKLY;
            }
            else if(rangeRadioButtonList.SelectedValue.Equals("2", StringComparison.Ordinal))
            {
                recommendationTable = MONTHLY;
            }
            else if(rangeRadioButtonList.SelectedValue.Equals("3", StringComparison.Ordinal))
            {
                recommendationTable = YEARLY;
            }

            if(!recommendationTable.Equals("", StringComparison.Ordinal))
            {
                string connectionString = "AsiaWebShopDBConnectionString";

                string UPC = txtUPC.Text.Trim();
                string name = "";
                string discountPrice = "";
                Int32 quantitySold = 0;
                string ranking = rankingRadioButtonList.SelectedValue;

                //get name, discountPrice from [Item]
                string querySelectFromItem = "";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand(querySelectFromItem, connection))
                {
                    // Open the connection.
                    command.Connection.Open();
                    // Execute the SELECT query and place the result in a DataReader.
                    SqlDataReader reader = command.ExecuteReader();
                    // Check if a result was returned.
                    if (reader.HasRows)
                    {
                        // Iterate through the table to get the retrieved values.
                        while (reader.Read())
                        {
                            //Releasedquantity = reader.GetInt32(0);
                        }
                    }

                    // Close the connection and the DataReader.
                    command.Connection.Close();
                    reader.Close();
                }

                //get quantitySold From [OrderRecord]
                string querySelectFromOrderRecord = "";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand(querySelectFromOrderRecord, connection))
                {
                    // Open the connection.
                    command.Connection.Open();
                    // Execute the SELECT query and place the result in a DataReader.
                    SqlDataReader reader = command.ExecuteReader();
                    // Check if a result was returned.
                    if (reader.HasRows)
                    {
                        // Iterate through the table to get the retrieved values.
                        while (reader.Read())
                        {
                            //Releasedquantity = reader.GetInt32(0);
                        }
                    }

                    // Close the connection and the DataReader.
                    command.Connection.Close();
                    reader.Close();
                }

                //count if the recommendation table if full
                Int32 count = 0;
                string queryCount = "SELECT COUNT(*) FROM [" + recommendationTable + "]";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
                {

                    connection.Open();
                    SqlCommand command = new SqlCommand(queryCount, connection);
                    count = (Int32)command.ExecuteScalar();
                    connection.Close();
                }

                //if the recommendation table has quota, then ignore the ranking provided by employee and insert the item
                //and display an appropriate message
                if (count < 5)
                {
                    InsertRecommendationTable(UPC, name, discountPrice, quantitySold, ranking, recommendationTable);
                    lblMessage.Text = "Recommendation table " + recommendationTable + " is not full. The item specified by you is appended to the table.";
                }

                //if the recommendation table has no quota, then update the specified ranking position
                if (count == 5)
                {
                    UpdateRecommendationTable(UPC, name, discountPrice, quantitySold, ranking, recommendationTable);
                    lblMessage.Text = "Recommendation table " + recommendationTable + " is updated successfully.";
                }

            }
        }
    }

    protected void UpdateRecommendationTable(string UPC, string name, string discountPrice, Int32 quantitySold, string ranking, string recommendationTable)
    {
        string queryUpdate = "UPDATE [" + recommendationTable + "] SET upc = @upc, name = @name, discountPrice = @discountPrice, quantitySold = @quantitySold, isEditorChoice = 'True' WHERE ranking = @ranking";

    }

    protected void InsertRecommendationTable(string UPC, string name, string discountPrice, Int32 quantitySold, string ranking, string recommendationTable)
    {
        string queryUpdate = "INSERT INTO [" + recommendationTable + "] VALUES (@upc, @name, @discountPrice, @quantitySold, @ranking, 'True')";

    }
}