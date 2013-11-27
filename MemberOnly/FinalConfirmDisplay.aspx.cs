using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class MemberOnly_FinalConfirmDisplay : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Write("<script>alert('Enter PageLoad')</script>");
        userName.Text = User.Identity.Name;

        string connectionString = "AsiaWebShopDBConnectionString";
        string SQLCmd = "SELECT [email],[confirmationNumber] FROM [OrderRecord] WHERE [userName] = '" + User.Identity.Name + "' AND isConfirmed = 'False'";

        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(SQLCmd, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    email.Text = (reader["email"].ToString().Trim());
                    confirmationCode.Text = (reader["confirmationNumber"].ToString().Trim());
                }
            }
            command.Connection.Close();
            reader.Close();
        }


        string query = "UPDATE OrderRecord SET isConfirmed = 'True', orderDateTime = CURRENT_TIMESTAMP WHERE (isConfirmed = 'False' AND userName = '" + User.Identity.Name + "')";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }

        UpdateAllRecommendationTable(connectionString);
    }

    protected void UpdateAllRecommendationTable(string connectionString)
    {
        UpdateRecommendationDB(connectionString, "RecommendationDay");
        UpdateRecommendationDB(connectionString, "RecommendationWeek");
        UpdateRecommendationDB(connectionString, "RecommendationMonth");
        UpdateRecommendationDB(connectionString, "RecommendationYear");
    }

    protected void UpdateRecommendationDB(string connectionString, string recommendationTable)
    {
        //Response.Write("<script>alert('" + recommendationTable + "')</script>");
        //clean up all non Editor's Choices
        CleanUpNonEditorChoice(connectionString, recommendationTable);
        /*
        //Get cavity information
        Int32 Capacity = 5;
        bool[] rankingAvailability = new bool[Capacity];
        for (int j = 0; j < Capacity; j++)
        {
            rankingAvailability[j] = true;
        }

        string queryRanking = "SELECT ranking FROM [" + recommendationTable + "]";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(queryRanking, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    Int32 index = reader.GetInt32(0);
                    rankingAvailability[index - 1] = false;
                }
            }
            command.Connection.Close();
        }
         * */

        //count Editor's Choices
        Int32 NumItemsInRecommendationTable = CountRecommendationTable(connectionString, recommendationTable);
        //calculate items needed to fill up
        Int32 NumItemsNeeded = 5 - NumItemsInRecommendationTable;
        //Response.Write("<script>alert('" + NumItemsNeeded.ToString() + "')</script>");

        AddItemsIntoRecommendationtableWithSpecifiedNumber(NumItemsNeeded, connectionString, recommendationTable);
        //Response.Write("<script>alert('" + CountRecommendationTable(connectionString, recommendationTable).ToString() + "')</script>");
        CleanUpZeroQuantityNonEditorChoice(connectionString, recommendationTable);
        
    }

    //utility function: Add Items Into Recommendation Table With Specified Number
    protected void AddItemsIntoRecommendationtableWithSpecifiedNumber(Int32 NumItemsNeeded, string connectionString, string recommendationTable)
    {
        //Collect required data
        DateTime Now = DateTime.Now;
        DateTime Past = Now;
        string DAILYTABLE = "RecommendationDay";
        string WEEKLYTABLE = "RecommendationWeek";
        string MONTHLYTABLE = "RecommendationMonth";
        string YEARLYTABLE = "RecommendationYear";

        //the past DateTime Past which serves as a reference later
        if (recommendationTable.Equals(DAILYTABLE, StringComparison.Ordinal))
        {
            Past = Now.Add(new TimeSpan(0, -24, 0, 0, 0));
        }
        else if (recommendationTable.Equals(WEEKLYTABLE, StringComparison.Ordinal))
        {
            Past = Now.Add(new TimeSpan(-7, 0, 0, 0, 0));
        }
        else if (recommendationTable.Equals(MONTHLYTABLE, StringComparison.Ordinal))
        {
            Past = Now.Add(new TimeSpan(-30, 0, 0, 0, 0));
        }
        else if (recommendationTable.Equals(YEARLYTABLE, StringComparison.Ordinal))
        {
            Past = Now.Add(new TimeSpan(-365, 0, 0, 0, 0));
        }

        //get the maximum number of items in Item DB
        Int32 MaxNumItems = 0;
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Item]", connection))
        {
            command.Connection.Open();
            MaxNumItems = (Int32)command.ExecuteScalar();
            command.Connection.Close();
        }

        int i = 0;
        //loop through the OrderRecord database to get the required information
        //create separate lists to hold different attributes required.
        string[] upcList = new string[MaxNumItems];
        string[] nameList = new string[MaxNumItems];
        string[] discountPriceList = new string[MaxNumItems];
        Int32[] quantitySoldList = new Int32[MaxNumItems];
        //Initialization of quantitySoldList
        for (i = 0; i < MaxNumItems; i++)
        {
            quantitySoldList[i] = 0;
        }

        i = 0;
        string queryUPC_name_discountPrice = "SELECT upc, name, discountPrice FROM [Item]";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(queryUPC_name_discountPrice, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    upcList[i] = reader["upc"].ToString().Trim();
                    nameList[i] = reader["name"].ToString().Trim();
                    discountPriceList[i] = reader["discountPrice"].ToString().Trim();

                    //proceed to populate the next item
                    i++;
                }
            }
            command.Connection.Close();
        }

        //instantiate quantitySoldList according to OrderRecord Database
        for (i = 0; i < MaxNumItems; i++)
        {
            string queryQuantitySold = "SELECT quantity FROM OrderRecord WHERE (upc = '" + upcList[i]
                                     + "' AND isConfirmed = 'True' AND orderDateTime >= '" + Past.Year.ToString().Trim()
                                     + "-" + Past.Month.ToString().Trim() + "-" + Past.Day.ToString().Trim()
                                     + " 00:00:00')";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(queryQuantitySold, connection))
            {
                command.Connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        quantitySoldList[i] += Convert.ToInt32(reader["quantity"].ToString().Trim());
                    }
                }
                command.Connection.Close();
            }
        }

        //indexHolder is used to hold index of the max in an array every round
        Int32 indexHolder;
        //Response.Write("<script>alert('" + NumItemsNeeded.ToString() + "')</script>");
        for (i = 0; i < NumItemsNeeded; i++)
        {
            Boolean present = false;

            string currentUPC = "";
            string currentName = "";
            string currentDiscountPrice = "";
            Int32 currentQuantitySold = 0;
            Int32 currentRanking = 0;
            Boolean isEditorChoice = false;

            do
            {
                indexHolder = IndexOfMaxOfAnArray(quantitySoldList, MaxNumItems);
                //Response.Write("<script>alert('" + quantitySoldList[indexHolder].ToString() + "')</script>");
                if (quantitySoldList[indexHolder] < 0)
                    break;

                currentUPC = upcList[indexHolder];
                currentName = nameList[indexHolder];
                currentDiscountPrice = discountPriceList[indexHolder];
                currentQuantitySold = quantitySoldList[indexHolder];
                //Response.Write("<script>alert('" + currentQuantitySold.ToString() + "')</script>");

                present = PresentInRecommendationTable(currentUPC, connectionString, recommendationTable);
                //Response.Write("<script>alert('" + present.ToString() + "')</script>");
                //make the extracted item invisible
                quantitySoldList[indexHolder] = -1;
            }
            while (present);

            Int32 Capacity = 5;
            bool[] rankingAvailability = new bool[Capacity];
            for (int j = 0; j < Capacity; j++)
            {
                rankingAvailability[j] = true;
            }

            string queryRanking = "SELECT ranking FROM [" + recommendationTable + "]";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(queryRanking, connection))
            {
                command.Connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        Int32 index = reader.GetInt32(0);
                        rankingAvailability[index - 1] = false;
                    }
                }
                command.Connection.Close();
            }

            //find the smallest index in rankingAvailability[]
            Int32 Index = 0;
            for (; Index < Capacity; Index++)
            {
                if (rankingAvailability[Index] == true)
                {
                    currentRanking = Index + 1;
                    break;
                }
            }
            //Response.Write("<script>alert('" + Index.ToString() + "')</script>");
            //Response.Write("<script>alert('" + currentQuantitySold.ToString() + "')</script>");
            string queryInsert = "INSERT INTO [" + recommendationTable + "] VALUES (@upc, @name, @discountPrice, @quantitySold, @ranking, @isEditorChoice)";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(queryInsert, connection))
            {
                command.Parameters.AddWithValue("@upc", currentUPC);
                command.Parameters.AddWithValue("@name", currentName);
                command.Parameters.AddWithValue("@discountPrice", currentDiscountPrice);
                command.Parameters.AddWithValue("@quantitySold", currentQuantitySold);
                command.Parameters.AddWithValue("@ranking", currentRanking);
                command.Parameters.AddWithValue("@isEditorChoice", isEditorChoice);
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }

    }
    //utility function: CleanUpZeroQuantityNonEditorChoice
    protected void CleanUpZeroQuantityNonEditorChoice(string connectionString, string recommendationTable)
    {
        string queryDelete = "DELETE FROM [" + recommendationTable + "] WHERE (quantitySold = '0' AND isEditorChoice = 'False')";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(queryDelete, connection))
        {
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    //utility function: Check whether the item with specified UPC exist in Recommendation Table
    protected Boolean PresentInRecommendationTable(string UPC, string connectionString, string recommendationTable)
    {
        Int32 count = 0;
        string queryCount = "SELECT COUNT(*) FROM [" + recommendationTable + "] WHERE upc = '" + UPC + "'";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {

            connection.Open();
            SqlCommand command = new SqlCommand(queryCount, connection);
            count = (Int32)command.ExecuteScalar();
            connection.Close();
        }
        if (count > 0) //EXIST
        {
            return true;
        }
        else // does not EXIST
        {
            return false;
        }
    }


    protected void CleanUpNonEditorChoice(string connectionString, string recommendationTable)
    {
        string queryDelete = "DELETE FROM [" + recommendationTable + "] WHERE isEditorChoice = 'False'";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(queryDelete, connection))
        {
            //Processing
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    //utility function: Index Of Max Of An Array
    protected Int32 IndexOfMaxOfAnArray(Int32[] Array, Int32 size)
    {
        Int32 index = 0;
        Int32 Max = Array[0];
        for (int i = 1; i < size; i++)
        {
            if (Array[i] > Max)
            {
                index = i;
                Max = Array[i];
            }
        }
        return index;
    }

    //utility function: Count # of items in Recommendation Table
    protected Int32 CountRecommendationTable(string connectionString, string recommendationTable)
    {
        Int32 count = 0;
        string queryCount = "SELECT COUNT(*) FROM [" + recommendationTable + "]";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {

            connection.Open();
            SqlCommand command = new SqlCommand(queryCount, connection);
            count = (Int32)command.ExecuteScalar();
            connection.Close();
        }
        return count;
    }
}