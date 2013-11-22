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


public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";

        UpdateRecommendationDB(connectionString, "RecommendationDay");
        UpdateRecommendationDB(connectionString, "RecommendationWeek");
        UpdateRecommendationDB(connectionString, "RecommendationMonth");
        UpdateRecommendationDB(connectionString, "RecommendationYear");

        DisplayRecommendationDB(connectionString, "RecommendationDay");

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


    protected void DisplayRecommendationDB(string connectionString, string RecommendationTable)
    {
        //retrieve necessary information for later population of the recommendation table        
        string itemName = "";
        string itemDiscountPrice = "";
        string itemQuantitySold = "";
        string itemRanking = "";
        Boolean itemIsEditorChoiceBoolean = false;
        string itemIsEditorChoice = "";


        //lists of information
        Int32 TOPNUM = 5; //# of top items
        string[] rankingLabel = new string[TOPNUM];
        string[] itemNameLabel = new string[TOPNUM];
        string[] discountPriceLabel = new string[TOPNUM];
        string[] quantitySoldLabel = new string[TOPNUM];
        string[] editorChoiceLabel = new string[TOPNUM];

        int i = 0;
        //initialization
        for (; i < TOPNUM; i++)
        {
            rankingLabel[i] = " ";
            itemNameLabel[i] = " ";
            discountPriceLabel[i] = " ";
            quantitySoldLabel[i] = " ";
            editorChoiceLabel[i] = " ";
        }


        //loop through the recommendation database to get and store data for later population of the recommendation table
        i = 0;
        string querySelect = "SELECT ranking, name, discountPrice, quantitySold, isEditorChoice FROM [" + RecommendationTable + "] ORDER BY ranking";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(querySelect, connection))
        {
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    //retrieve data
                    itemRanking = reader["ranking"].ToString().Trim();
                    itemName = reader["name"].ToString().Trim();
                    itemDiscountPrice = reader["discountPrice"].ToString().Trim();
                    itemQuantitySold = reader["quantitySold"].ToString().Trim();
                    itemIsEditorChoiceBoolean = Convert.ToBoolean(reader["isEditorChoice"].ToString().Trim());
                    if (itemIsEditorChoiceBoolean)
                    {
                        itemIsEditorChoice = " * ";
                    }


                    //put data into lists
                    rankingLabel[i] = itemRanking.Trim();
                    itemNameLabel[i] = itemName.Trim();
                    discountPriceLabel[i] = itemDiscountPrice.Trim();
                    quantitySoldLabel[i] = itemQuantitySold.Trim();
                    editorChoiceLabel[i] = itemIsEditorChoice.Trim();

                    //go to another row
                    i++;
                }
            }
            command.Connection.Close();
        }


        //populate the recommendation with hard coding (5 parts)
        //part 1: populate ranking labels
        rankingLabel1.Text = rankingLabel[1 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : rankingLabel[1 - 1].Trim();
        rankingLabel2.Text = rankingLabel[2 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : rankingLabel[2 - 1].Trim();
        rankingLabel3.Text = rankingLabel[3 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : rankingLabel[3 - 1].Trim();
        rankingLabel4.Text = rankingLabel[4 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : rankingLabel[4 - 1].Trim();
        rankingLabel5.Text = rankingLabel[5 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : rankingLabel[5 - 1].Trim();

        //part 2: populate item name labels
        itemNameLabel1.Text = itemNameLabel[1 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : itemNameLabel[1 - 1].Trim();
        itemNameLabel2.Text = itemNameLabel[2 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : itemNameLabel[2 - 1].Trim();
        itemNameLabel3.Text = itemNameLabel[3 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : itemNameLabel[3 - 1].Trim();
        itemNameLabel4.Text = itemNameLabel[4 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : itemNameLabel[4 - 1].Trim();
        itemNameLabel5.Text = itemNameLabel[5 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : itemNameLabel[5 - 1].Trim();

        //part 3: populate item discount price labels
        discountPriceLabel1.Text = discountPriceLabel[1 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : discountPriceLabel[1 - 1].Trim();
        discountPriceLabel2.Text = discountPriceLabel[2 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : discountPriceLabel[2 - 1].Trim();
        discountPriceLabel3.Text = discountPriceLabel[3 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : discountPriceLabel[3 - 1].Trim();
        discountPriceLabel4.Text = discountPriceLabel[4 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : discountPriceLabel[4 - 1].Trim();
        discountPriceLabel5.Text = discountPriceLabel[5 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : discountPriceLabel[5 - 1].Trim();

        //part 4: populate item quantity sold
        quantitySoldLabel1.Text = quantitySoldLabel[1 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : quantitySoldLabel[1 - 1].Trim();
        quantitySoldLabel2.Text = quantitySoldLabel[2 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : quantitySoldLabel[2 - 1].Trim();
        quantitySoldLabel3.Text = quantitySoldLabel[3 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : quantitySoldLabel[3 - 1].Trim();
        quantitySoldLabel4.Text = quantitySoldLabel[4 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : quantitySoldLabel[4 - 1].Trim();
        quantitySoldLabel5.Text = quantitySoldLabel[5 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : quantitySoldLabel[5 - 1].Trim();

        //part 5: populate editor's choice label
        editorChoiceLabel1.Text = editorChoiceLabel[1 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : editorChoiceLabel[1 - 1].Trim();
        editorChoiceLabel2.Text = editorChoiceLabel[2 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : editorChoiceLabel[2 - 1].Trim();
        editorChoiceLabel3.Text = editorChoiceLabel[3 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : editorChoiceLabel[3 - 1].Trim();
        editorChoiceLabel4.Text = editorChoiceLabel[4 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : editorChoiceLabel[4 - 1].Trim();
        editorChoiceLabel5.Text = editorChoiceLabel[5 - 1].Equals(" ", StringComparison.Ordinal) ? "  -  " : editorChoiceLabel[5 - 1].Trim();

    }

    protected void UpdateRecommendationDB(string connectionString, string RecommendationTable)
    {
        DateTime Now = DateTime.Now;
        //Past is initialized to
        DateTime Past = Now;
        string DAILYTABLE = "RecommendationDay";
        string WEEKLYTABLE = "RecommendationWeek";
        string MONTHLYTABLE = "RecommendationMonth";
        string YEARLYTABLE = "RecommendationYear";

        //the past DateTime Past which serves as a reference later
        if (RecommendationTable.Equals(DAILYTABLE, StringComparison.Ordinal))
        {
            Past = Now.Add(new TimeSpan(0, -24, 0, 0, 0));
        }
        else if (RecommendationTable.Equals(WEEKLYTABLE, StringComparison.Ordinal))
        {
            Past = Now.Add(new TimeSpan(-7, 0, 0, 0, 0));
        }
        else if (RecommendationTable.Equals(MONTHLYTABLE, StringComparison.Ordinal))
        {
            Past = Now.Add(new TimeSpan(-30, 0, 0, 0, 0));
        }
        else if (RecommendationTable.Equals(YEARLYTABLE, StringComparison.Ordinal))
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

        for (i = 0; i < MaxNumItems; i++)
        {
            indexHolder = IndexOfMaxOfAnArray(quantitySoldList, MaxNumItems);
            if (quantitySoldList[indexHolder] <= 0)
                break;

            string queryInsert = "INSERT INTO [" + RecommendationTable + "] VALUES (@upc, @name, @discountPrice, @quantitySold, @ranking, @isEditorChoice)";
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(queryInsert, connection))
            {
                command.Parameters.AddWithValue("@upc", upcList[indexHolder]);
                command.Parameters.AddWithValue("@name", nameList[indexHolder]);
                command.Parameters.AddWithValue("@discountPrice", discountPriceList[indexHolder]);
                command.Parameters.AddWithValue("@quantitySold", quantitySoldList[indexHolder].ToString().Trim());
                command.Parameters.AddWithValue("@ranking", Convert.ToString(i + 1));
                command.Parameters.AddWithValue("@isEditorChoice", Convert.ToString(false));
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }
            //make the extracted item invisible
            quantitySoldList[indexHolder] = -1;
        }
    }

    protected void rangeRadioButtonList_SelectedIndexChanged(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        string selectedValue = rangeRadioButtonList.SelectedValue;
        string DAILY = "0";
        string WEEKLY = "1";
        string MONTHLY = "2";
        string YEARLY = "3";

        if (selectedValue.Equals(DAILY, StringComparison.Ordinal))
        {
            DisplayRecommendationDB(connectionString, "RecommendationDay");
        }
        else if (selectedValue.Equals(WEEKLY, StringComparison.Ordinal))
        {
            DisplayRecommendationDB(connectionString, "RecommendationWeek");
        }
        else if (selectedValue.Equals(MONTHLY, StringComparison.Ordinal))
        {
            DisplayRecommendationDB(connectionString, "RecommendationMonth");
        }
        else if (selectedValue.Equals(YEARLY, StringComparison.Ordinal))
        {
            DisplayRecommendationDB(connectionString, "RecommendationYear");
        }

    }
}