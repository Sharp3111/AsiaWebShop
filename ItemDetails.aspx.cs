﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class ItemDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            lblSearchResultMessage.Text = "";

    }

    protected void cvQuantity_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (User.Identity.Name != "")
        {
            if (IsValid)
            {
                string connectionString = "AsiaWebShopDBConnectionString";
                string userName = User.Identity.Name;
                string upc = dvItemDetails.DataKey[0].ToString().Trim();
                TextBox quantity_textbox = (TextBox)dvItemDetails.FindControl("tbQuantity");
                Int32 quantity = Convert.ToInt32(quantity_textbox.Text.Trim());
                Int32 avaiableQuantity = 0;


                //read the available quantity in the item database

                string query = "SELECT [quantityAvailable] FROM [Item] WHERE ([upc] = N'" + upc + "')";

                // Create the connection and the SQL command.
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
                using (SqlCommand command = new SqlCommand(query, connection))
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
                            avaiableQuantity = reader.GetInt32(0);
                        }
                    }

                    // Close the connection and the DataReader.
                    command.Connection.Close();
                    reader.Close();
                }

                //if(quantity == avaiableQuantity)
                //    ValidationSummary1.Enabled = false;

                if (quantity > avaiableQuantity)
                    args.IsValid = false;
            }
        }
    }

    //?????????????????????????????????Prone to error???????????????????????????????????????//
    /*Individual Testing failed; but integrated testing passed*/
    /*it's okay; not a bug*/
    protected void dvItemDetails_DataBound(object sender, EventArgs e)
    {
        DetailsView detailView = (DetailsView)(sender as Control);
        Label quantityAvailableLabel = (Label)detailView.FindControl("quantityAvailableLabel");
        //Response.Write("<script>alert('" + quantityAvailableLabel + "')</script>");
        Int32 quantityAvailable = Convert.ToInt32(quantityAvailableLabel != null ? quantityAvailableLabel.Text.Trim() : "0");

        if (quantityAvailable == 0)
        {
            Button btn = ((Button)detailView.FindControl("btn_ShoppingCart"));
            if (btn != null)
            {
                btn.Text = "Subscribe";
                btn.PostBackUrl = "~/MemberOnly/StockAvailableAlert.aspx?upc=" + detailView.DataKey[0];
            }
        }

        if (detailView.FindControl("upcLabel") != null)
            UPC.Text = ((Label)detailView.FindControl("upcLabel")).Text.Trim();
        //Response.Write("<script>alert('" + UPC.Text + "')</script>");

        populateGridViewReview(UPC.Text.Trim());

        populateLabels(UPC.Text.Trim());
    }

    private void populateGridViewReview(string UPC)
    {
        string connectionString = "AsiaWebShopDBConnectionString";

        string querySelect = "SELECT userName, qualityRating, featuresRating, performanceRating, appearanceRating, durabilityRating, comment FROM Review WHERE (upc = @upc)";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(querySelect, connection))
        {
            command.Connection.Open();
            command.Parameters.AddWithValue("@upc", UPC);
            SqlDataReader reader = command.ExecuteReader();
            // Check if a result was returned.
            if (reader.HasRows)
            {
                int i = 0;
                // Iterate through the table to get the retrieved values.
                while (reader.Read())
                {
                    // Assign the data values to itemUPC
                    string userName = reader["userName"].ToString().Trim();
                    string qualityRating = reader["qualityRating"].ToString().Trim();
                    string featuresRating = reader["featuresRating"].ToString().Trim();
                    string performanceRating = reader["performanceRating"].ToString().Trim();
                    string appearanceRating = reader["appearanceRating"].ToString().Trim();
                    string durabilityRating = reader["durabilityRating"].ToString().Trim();
                    string comment = reader["comment"].ToString().Trim();
                    //Boolean anonymous = Convert.ToBoolean(reader["isAnonymous"].ToString().Trim());

                    //populate username
                    //if (anonymous)
                    //{
                    //    ((Label)gvReview.Rows[i].FindControl("userNameLabel")).Text = "Anonymous";
                    //}
                    //else
                    //{
                    //((Label)gvReview.Rows[i].FindControl("userNameLabel")).Text = userName;
                    //}
                    //populate quality rating
                    ((Label)gvReview.Rows[i].FindControl("qRatingLabel")).Text = qualityRating;

                    //populate features rating
                    ((Label)gvReview.Rows[i].FindControl("fRatingLabel")).Text = featuresRating;

                    //populate performance rating
                    ((Label)gvReview.Rows[i].FindControl("pRatingLabel")).Text = performanceRating;

                    //populate appearance rating
                    ((Label)gvReview.Rows[i].FindControl("aRatingLabel")).Text = appearanceRating;

                    //populate durability rating
                    ((Label)gvReview.Rows[i].FindControl("dRatingLabel")).Text = durabilityRating;

                    //populate comment if any
                    ((Label)gvReview.Rows[i++].FindControl("commentLabel")).Text = comment;
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }

    private void populateLabels(string UPC)
    {
        Int32 MaxRows = gvReview.Rows.Count;

        if (MaxRows == 0)
        {
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Text = "This item has no review.";

            numberOfPeople.Text = "0";
            QualityAggregate.Text = "- -";
            FeaturesAggregate.Text = "- -";
            PerformanceAggregate.Text = "- -";
            AppearanceAggregate.Text = "- -";
            DurabilityAggregate.Text = "- -";
        }
        else
        {
            lblMessage.ForeColor = System.Drawing.Color.Navy;
            lblMessage.Text = "The following are reviews from members who have purchased this item.";

            numberOfPeople.Text = MaxRows.ToString().Trim();
                        
            //calculate quality aggregate
            Decimal Quality = 0;
            for (int i = 0; i < MaxRows; i++)
            {
                Quality += Convert.ToDecimal(((Label)gvReview.Rows[i].FindControl("qRatingLabel")).Text.Trim());
            }
            Quality = Quality / MaxRows;
            QualityAggregate.Text = Quality.ToString("F4").Trim();
            
            //calculate features aggregate
            Decimal Features = 0;
            for (int i = 0; i < MaxRows; i++)
            {
                Features += Convert.ToDecimal(((Label)gvReview.Rows[i].FindControl("fRatingLabel")).Text.Trim());
            }
            Features = Features / MaxRows;
            FeaturesAggregate.Text = Features.ToString("F4").Trim();

            //calculate performance aggregate
            Decimal Performance = 0;
            for (int i = 0; i < MaxRows; i++)
            {
                Performance += Convert.ToDecimal(((Label)gvReview.Rows[i].FindControl("pRatingLabel")).Text.Trim());
            }
            Performance = Performance / MaxRows;
            PerformanceAggregate.Text = Performance.ToString("F4").Trim();

            //calculate performance aggregate
            Decimal Appearance = 0;
            for (int i = 0; i < MaxRows; i++)
            {
                Appearance += Convert.ToDecimal(((Label)gvReview.Rows[i].FindControl("aRatingLabel")).Text.Trim());
            }
            Appearance = Appearance / MaxRows;
            AppearanceAggregate.Text = Appearance.ToString("F4").Trim();

            //calculate performance aggregate
            Decimal Durability = 0;
            for (int i = 0; i < MaxRows; i++)
            {
                Durability += Convert.ToDecimal(((Label)gvReview.Rows[i].FindControl("dRatingLabel")).Text.Trim());
            }
            Durability = Durability / MaxRows;
            DurabilityAggregate.Text = Durability.ToString("F4");
        }

    }

}