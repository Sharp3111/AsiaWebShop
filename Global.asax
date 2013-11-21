<%@ Application Language="C#" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Timers" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">

    //global List<Int32> quantityPast = new List<Int32>();
    
    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup
        System.Timers.Timer aTimer = new System.Timers.Timer(2000);
        aTimer.Enabled = true;
        aTimer.Elapsed += new ElapsedEventHandler(OnTimedEvent);        
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }

    void OnTimedEvent(object source, System.Timers.ElapsedEventArgs e)
    {
        //List<Int32> quantityPast = new List<Int32>();
        //int i = 0;
        //string query = "SELECT [quantityAvailable], [name] FROM [Item]";
        //using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        //using (SqlCommand command = new SqlCommand(query, connection))
        //{
        //    // Get the current quantityAvailable
        //    command.Connection.Open();
        //    System.Data.SqlClient.SqlDataReader reader = command.ExecuteReader();
            
        //    // Check if a result was returned.
        //    if (reader.HasRows)
        //    {
        //        // Iterate through the table to get the retrieved values.
        //        while (reader.Read())
        //        {
        //            Int32 quantityCurrent = Convert.ToInt32(reader["quantityAvailable"].ToString().Trim());
        //            string itemName = reader["name"].ToString().Trim();
                    
        //        }
        //    }
            
        //    quantity = (Int32)command.ExecuteScalar();
        //    connection.Close();
        //}

        //// If quantity == 0 and is being updated to a positive number, then send email alert
        //Int32 updatedQuantity = Convert.ToInt32(((TextBox)dvItem.FindControl("EditQuantityAvailable")).Text.Trim());

        //if ((quantity == 0) && (updatedQuantity > 0))
        //{
        //    // Create an instance of MailMessage named mail.
        //    MailMessage mail = new MailMessage();

        //    // Create an instance of SmtpClient named emailServer and set the mail server to use as "smtp.ust.hk".
        //    SmtpClient emailServer = new SmtpClient("smtp.ust.hk");
        //    emailServer.UseDefaultCredentials = false;
        //    emailServer.Port = 587;
        //    emailServer.EnableSsl = true;
        //    System.Net.NetworkCredential basicAuthenticationInfo = new System.Net.NetworkCredential("wliab", "vdKv42##");
        //    emailServer.Credentials = basicAuthenticationInfo;
        //    emailServer.Timeout = 5000;

        //    // Prepare necessary information
        //    string itemName = ((TextBox)dvItem.FindControl("EditName")).Text.Trim();

        //    // Set the sender (From), receiver (To), subject and message body fields of the mail message.
        //    mail.From = new MailAddress("sharp@cse.ust.hk", "AsiaWebShop");
        //    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        //    {
        //        // Get the email addresses subscribed to the item
        //        connection.Open();
        //        SqlCommand command = new SqlCommand("SELECT [email] FROM [Subscription] WHERE ([name] = N'" + itemName + "')", connection);
        //        string subscriber = (string)command.ExecuteScalar();
        //        if (subscriber != null)
        //        {
        //            mail.To.Add(subscriber);
        //            mail.Subject = itemName + " is Available!";
        //            mail.Body = "Dear Customer,\nThank you for your interest in " + itemName + ". New stock for this item is available. Act now!\nAsiaWebShop";

        //            // Send the message.
        //            emailServer.Send(mail);
        //        }
        //        connection.Close();
        //    }

        //}
    }

       
</script>
