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

    //utility function: Get item name
    protected string GetItemName(string connectionString, string UPC)
    {
        string name = "";
        string querySelectFromItem = "SELECT name FROM [Item] WHERE upc = '" + UPC + "'";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(querySelectFromItem, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    name = reader["name"].ToString().Trim();                    
                }
            }
            command.Connection.Close();
            reader.Close();
        }
        return name;
    }
    //utility function: Get discount price
    protected string GetDiscountPrice(string connectionString, string UPC)
    {
        string discountPrice = "";
        string querySelectFromItem = "SELECT discountPrice FROM [Item] WHERE upc = '" + UPC + "'";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(querySelectFromItem, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {                    
                    discountPrice = reader["discountPrice"].ToString().Trim();
                }
            }
            command.Connection.Close();
            reader.Close();
        }
        return discountPrice;
    }
    //utility function: Get quantity sold
    protected Int32 GetQuantitySold(string connectionString, string UPC)
    {
        Int32 quantitySold = 0;
        Int32 quantityHolder = 0;
        string querySelectFromOrderRecord = "SELECT quantity FROM [OrderRecord] WHERE (upc = '" + UPC + "' AND isConfirmed = 'True')";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(querySelectFromOrderRecord, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    quantityHolder = reader.GetInt32(0);
                    quantitySold += quantityHolder;
                }
            }
            command.Connection.Close();
            reader.Close();
        }
        return quantitySold;
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
    //utility function: Check whether Recommendation Table is full - with 5 items
    protected Boolean FullRecommendationTable(string connectionString, string recommendationTable)
    {
        Int32 MaxNumInRecommendationTable = 5;
        //count # of items in the Recommendation Table
        Int32 count = CountRecommendationTable(connectionString, recommendationTable);
        if (count < MaxNumInRecommendationTable)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    //utility function: Check whether the item fall within items in Recommendation Table
    protected Boolean EmployeeSpecifiedRankingWithinItemsInRecommendationTable(string ranking, string connectionString, string recommendationTable)
    {
        Int32 Ranking = Convert.ToInt32(ranking);
        Int32 NumItemsInRecommendationTable = CountRecommendationTable(connectionString, recommendationTable);

        if (NumItemsInRecommendationTable < Ranking)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    //utility function: Check whether present ranking is greater than employee-specified ranking
    protected Boolean PresentRankingGreaterThanEmployeeSpecifiedRanking(string UPC, string ranking, string connectionString, string recommendationTable)
    {
        Int32 EmployeeSpecifiedRanking = Convert.ToInt32(ranking);
        Int32 PresentRanking = 0;

        string querySelectFromOrderRecord = "SELECT ranking FROM [" + recommendationTable + "] WHERE (upc = '" + UPC + "')";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(querySelectFromOrderRecord, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    PresentRanking = reader.GetInt32(0);
                }
            }
            command.Connection.Close();
            reader.Close();
        }

        if (PresentRanking > EmployeeSpecifiedRanking)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    //utility function: Insert the item with UPC into Recommendation Table (Append to the end of the table)
    protected void AppendItemToRecommendationTable(string UPC, string name, string discountPrice, Int32 quantitySold, string connectionString, string recommendationTable)
    {
        
        Int32 ranking = CountRecommendationTable(connectionString, recommendationTable) + 1;        

        string queryInsert = "INSERT INTO [" + recommendationTable + "] VALUES (@upc, @name, @discountPrice, @quantitySold, @ranking, 'True')";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(queryInsert, connection))
        {
            //Instantiation
            command.Parameters.AddWithValue("@upc", UPC);
            command.Parameters.AddWithValue("@name", name);
            command.Parameters.AddWithValue("@discountPrice", discountPrice);
            command.Parameters.AddWithValue("@quantitySold", quantitySold);
            command.Parameters.AddWithValue("@ranking", ranking);

            //Processing
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }


    protected void submitButton_Click(object sender, EventArgs e)
    {
        //if the page is valid, do the following
        if (IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";

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
                string UPC = txtUPC.Text.Trim();
                string name = GetItemName(connectionString, UPC);
                string discountPrice = GetDiscountPrice(connectionString, UPC);
                Int32 quantitySold = GetQuantitySold(connectionString, UPC);
                string ranking = rankingRadioButtonList.SelectedValue.Trim();

                /* MANAGEMENT SCHEME
                 1 * If (the Recommendation Table is not full)
                 2 * * * If (the item is not present in Recommendation Table)
                 3 * * * * * If (# of items in Recommendation Table < employee-specified ranking)
                 4 * * * * * * * Append the item to Recommendation Table. Display an appropriate message.
                 5 * * * * * Else - # of items in Recommendation Table >= employee-specified ranking
                 6 * * * * * * * Update Recommendation Table.
                 7 * * * Else - the item is present in Recommendation Table 
                 8 * * * * * If (the present ranking <= employee-specified ranking)
                 9 * * * * * * * DO NOTHING.
                 10* * * * * Else - the present ranking > employee-specified ranking
                 11* * * * * * * Update Recommendation Table.
                 * 
                 12* Else - the Recommendation Table is full
                 13* * * If (the item is not present in Recommendation Table)
                 14* * * * * Update Recommendation Table.
                 15* * * Else - the item is present in Recommendation Table
                 16* * * * * If (the present ranking <= employee-specified ranking)
                 17* * * * * * * DO NOTHING.
                 18* * * * * Else - the present ranking > employee-specified ranking
                 19* * * * * * * Update Recommendation Table.
                 * */
                
                //check wether the Recommendation Table is full
                Boolean full = FullRecommendationTable(connectionString, recommendationTable);
                //check whether the item is in Recommendation Table
                Boolean present = PresentInRecommendationTable(UPC, connectionString, recommendationTable);
                //check wether employee-specified ranking is within # of items in Recommendation Table
                Boolean within = EmployeeSpecifiedRankingWithinItemsInRecommendationTable(ranking, connectionString, recommendationTable);
                //check with present ranking is greater than employee-specified ranking
                Boolean greater = false;
                if (present)
                {
                    greater = PresentRankingGreaterThanEmployeeSpecifiedRanking(UPC, ranking, connectionString, recommendationTable);
                }
                

                //1 * If (the Recommendation Table is not full)
                //Response.Write("<script>alert('" + full.ToString() + "')</script>");
                if (!full)
                {
                    //Response.Write("<script>alert('" + present.ToString() + "')</script>");
                    //2 * * * If (the item is not present in Recommendation Table)
                    if (!present)
                    {
                        //Response.Write("<script>alert('" + within.ToString() + "')</script>");
                        //3 * * * * * If (# of items in Recommendation Table < employee-specified ranking)
                        if (!within)
                        {
                            
                            //4 * * * * * * * Append the item to Recommendation Table. 
                            AppendItemToRecommendationTable(UPC, name, discountPrice, quantitySold, connectionString, recommendationTable);
                            //Display an appropriate message.
                            lblMessage.Text = "The number of items in recommendation table " + recommendationTable + " is less than the specified ranking. The item with the UPC specified is appended at the end of the table.";
                        }
                        //5 * * * * * Else - # of items in Recommendation Table >= employee-specified ranking
                        else
                        {
                            //6 * * * * * * * Update Recommendation Table.
                            UpdateRecommendationTable(UPC, name, discountPrice, quantitySold, ranking, connectionString, recommendationTable);
                            lblMessage.Text = "The recommendation table " + recommendationTable + " is successfully updated";
                        }
                    }
                    //7 * * * Else - the item is present in Recommendation Table 
                    else
                    {
                        //8 * * * * * If (the present ranking <= employee-specified ranking)
                        if (!greater)
                        {
                            //9 * * * * * * * DO NOTHING.
                            lblMessage.Text = "No action is taken since the sepcified ranking is not better";
                        }
                        //10* * * * * Else - the present ranking > employee-specified ranking
                        else
                        {
                            //11* * * * * * * Update Recommendation Table.
                            UpdateRecommendationTable(UPC, name, discountPrice, quantitySold, ranking, connectionString, recommendationTable);
                            lblMessage.Text = "The recommendation table " + recommendationTable + " is successfully updated";
                        }
                    }
                }
                //12* Else - the recommendation table is full
                else
                {
                    //13* * * If (the item is not present in Recommendation Table)
                    if (!present)
                    {
                        //14* * * * * Update Recommendation Table.
                        UpdateRecommendationTable(UPC, name, discountPrice, quantitySold, ranking, connectionString, recommendationTable);
                        lblMessage.Text = "The recommendation table " + recommendationTable + " is successfully updated";
                    }
                    //15* * * Else - the item is present in Recommendation Table
                    else
                    {
                        //16 * * * * * If (the present ranking <= employee-specified ranking)
                        if (!greater)
                        {
                            //17 * * * * * * * DO NOTHING.
                            lblMessage.Text = "No action is taken since the sepcified ranking is not better";
                        }
                        //18* * * * * Else - the present ranking > employee-specified ranking
                        else
                        {
                            //19* * * * * * * Update Recommendation Table.
                            UpdateRecommendationTable(UPC, name, discountPrice, quantitySold, ranking, connectionString, recommendationTable);
                            lblMessage.Text = "The recommendation table " + recommendationTable + " is successfully updated";
                        }
                    }
                }
            }
        }
    }

    //utility function: Update Recommendation Table
    protected void UpdateRecommendationTable(string UPC, string name, string discountPrice, Int32 quantitySold, string ranking, string connectionString, string recommendationTable)
    {
        OverrideRecommendationTable(UPC, name, discountPrice, quantitySold, ranking, connectionString, recommendationTable);
        CleanUpGreaterRankingItemWithSpecifiedUPC(UPC, ranking, connectionString, recommendationTable);
        CleanUpNonEditorChoice(connectionString, recommendationTable);

        //count Editor's Choices
        Int32 NumItemsInRecommendationTable = CountRecommendationTable(connectionString, recommendationTable);
        //calculate items needed to fill up
        Int32 NumItemsNeeded = 5 - NumItemsInRecommendationTable;

        AddItemsIntoRecommendationtableWithSpecifiedNumber(NumItemsNeeded, connectionString, recommendationTable);
        CleanUpZeroQuantityNonEditorChoice(connectionString, recommendationTable);
    }

    //utility function: Override Recommendation Table
    protected void OverrideRecommendationTable(string UPC, string name, string discountPrice, Int32 quantitySold, string ranking, string connectionString, string recommendationTable)
    {
        string queryOverride = "UPDATE [" + recommendationTable + "] SET upc = @upc, name = @name, discountPrice = @discountPrice, quantitySold = @quantitySold, isEditorChoice = 'True' WHERE ranking = @ranking";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(queryOverride, connection))
        {
            //Instantiation
            command.Parameters.AddWithValue("@upc", UPC);
            command.Parameters.AddWithValue("@name", name);
            command.Parameters.AddWithValue("@discountPrice", discountPrice);
            command.Parameters.AddWithValue("@quantitySold", quantitySold);
            command.Parameters.AddWithValue("@ranking", ranking);

            //Processing
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }
    //utility function: Clean Up Greater Ranking Item With Specified UPC
    protected void CleanUpGreaterRankingItemWithSpecifiedUPC(string UPC, string ranking, string connectionString, string recommendationTable)
    {
        //delete the duplicate item if there is any
        Int32 count = 0;
        string queryCount = "SELECT COUNT(*) FROM [" + recommendationTable + "] WHERE upc = '" + UPC + "'";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {

            connection.Open();
            SqlCommand command = new SqlCommand(queryCount, connection);
            count = (Int32)command.ExecuteScalar();
            connection.Close();
        }

        //There is a duplicate
        if (count > 1)
        {
            //Initialize to the overriden ranking
            Int32 duplicateRanking = Convert.ToInt32(ranking);
            string querySelect = "SELECT ranking FROM [" + recommendationTable + "] WHERE upc = '" + UPC + "'";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(querySelect, connection))
            {
                command.Connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                         Int32 currentRanking = reader.GetInt32(0);
                         if (currentRanking != duplicateRanking)
                         {
                             duplicateRanking = currentRanking;
                         }
                    }
                }
                command.Connection.Close();
                reader.Close();
            }


            string queryDelete = "DELETE FROM [" + recommendationTable + "] WHERE (ranking = @ranking AND upc = '" + UPC + "')";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(queryDelete, connection))
            {
                //Instantiation
                command.Parameters.AddWithValue("@ranking", duplicateRanking);

                //Processing
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }
    }
    //utility function: Clean Up Non Editor's Choices
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
                if (quantitySoldList[indexHolder] < 0)
                    break;

                currentUPC = upcList[indexHolder];
                currentName = nameList[indexHolder];
                currentDiscountPrice = discountPriceList[indexHolder];
                currentQuantitySold = quantitySoldList[indexHolder];                

                present = PresentInRecommendationTable(currentUPC, connectionString, recommendationTable);

                //make the extracted item invisible
                quantitySoldList[indexHolder] = -1;
            }
            while(present);

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
                        rankingAvailability[index-1] = false;
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
    

    /*
    protected void UpdateRecommendationTable(string connectionString, string recommendationTable)
    {


        string queryUpdate = "UPDATE [" + recommendationTable + "] SET upc = @upc, name = @name, discountPrice = @discountPrice, quantitySold = @quantitySold, isEditorChoice = 'True' WHERE ranking = @ranking";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(queryUpdate, connection))
        {
            //Instantiation
            command.Parameters.AddWithValue("@upc", UPC);
            command.Parameters.AddWithValue("@name", name);
            command.Parameters.AddWithValue("@discountPrice", discountPrice);
            command.Parameters.AddWithValue("@quantitySold", quantitySold);
            command.Parameters.AddWithValue("@ranking", ranking);

            //Processing
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }
     * */
    /*
    protected void InsertRecommendationTable(string connectionString, string UPC, string name, string discountPrice, Int32 quantitySold, string ranking, string recommendationTable)
    {
        string queryInsert= "INSERT INTO [" + recommendationTable + "] VALUES (@upc, @name, @discountPrice, @quantitySold, @ranking, 'True')";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(queryInsert, connection))
        {
            //Instantiation
            command.Parameters.AddWithValue("@upc", UPC);
            command.Parameters.AddWithValue("@name", name);
            command.Parameters.AddWithValue("@discountPrice", discountPrice);
            command.Parameters.AddWithValue("@quantitySold", quantitySold);
            command.Parameters.AddWithValue("@ranking", ranking);

            //Processing
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }
     * */
    protected void cvUPCExist_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //Check whether the item specified by the employee exists in [Item]
        if (IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string UPC = txtUPC.Text.Trim();

            //count # of item(s) in [Item]
            Int32 count = 0;
            string queryExistence = "SELECT COUNT(*) FROM [Item] WHERE upc = '" + UPC + "'";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(queryExistence, connection))
            {
                command.Connection.Open();
                count = (Int32)command.ExecuteScalar();
                command.Connection.Close();
            }

            //if there exists such UPC in the database, then args.IsValid = true
            if (count > 0)
            {
                args.IsValid = true;
            }
            //if there is no such UPC in database, then args.IsValid = false
            else
            {
                args.IsValid = false;
            }
        }
    }
    protected void cvUPC_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //Check whether the item has positive quantity
        //The idea is that if the item has zero quantity, 
        //there is no point of putting it in the recommendation table,
        //since no one can buy it.
        if (IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";
            string UPC = txtUPC.Text.Trim();

            //count # of quantityAvailable of the item
            Int32 quantityAvailable = 0;
            string querySelectQuantityAvailable = "SELECT quantityAvailable FROM [Item] WHERE (upc = '" + UPC + "')";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(querySelectQuantityAvailable, connection))
            {
                command.Connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        quantityAvailable = reader.GetInt32(0);
                    }
                }
                command.Connection.Close();
                reader.Close();
            }

            //if the quantity available is positive, then args.IsValid = true
            if (quantityAvailable > 0)
            {
                args.IsValid = true;
            }
            //if the quantity available is not positive, then args.IsValid = false
            else
            {
                args.IsValid = false;
            }
        }
    }

    /*
    protected void cvUPC2_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //Check whether the item with specified UPC has already existed in the recommendation table.
        //If so, the employee can not add it again into the recommendation table.
        if (IsValid)
        {
            string connectionString = "AsiaWebShopDBConnectionString";

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

            if (!recommendationTable.Equals("", StringComparison.Ordinal))
            {
                string UPC = txtUPC.Text.Trim();

                //count # of item(s) in recommendation table
                Int32 count = 0;
                string queryExistence = "SELECT COUNT(*) FROM [" + recommendationTable + "] WHERE upc = '" + UPC + "'";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand(queryExistence, connection))
                {
                    command.Connection.Open();
                    count = (Int32)command.ExecuteScalar();
                    command.Connection.Close();
                }

                //if there exists such UPC in the recommendation table, then args.IsValid = false
                if (count > 0)
                {
                    args.IsValid = false;
                }
                //if there is no such UPC in the recommendation table, then args.IsValid = true
                else
                {
                    args.IsValid = true;
                }
            }
        }
    }
     * */
}