<%@ Application Language="C#" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Timers" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web.Hosting"  %>
<%@ Import Namespace="System.Net.Mail"  %>

<script runat="server">
    
    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup
        System.Timers.Timer aTimer = new System.Timers.Timer(10000);
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
        Session["Username"] = User.Identity.Name; 
    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.
        System.Diagnostics.Debug.Write("Username:");
        System.Diagnostics.Debug.WriteLine(Session["Username"].ToString());
        
        string username = Session["Username"].ToString().Trim();
        string connectionString = "AsiaWebShopDBConnectionString";
        string query = "UPDATE [ShoppingCart] SET [isReleased] = 'True' WHERE ([isReleased] = 'False' AND [userName] = '" + username + "')";
        
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        {
            SqlCommand command = new SqlCommand(query, connection);
            {

                // Open the connection, execute the INSERT query and close the connection.
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }

        query = "UPDATE [Item] SET [quantityAvailable] = ([Item].[quantityAvailable] + [ShoppingCart].[quantity]) FROM [Item] JOIN [ShoppingCart] ON ([ShoppingCart].[upc] = [Item].[upc]) WHERE ([isReleased] = 'False' AND [ShoppingCart].[userName] = '" + username + "')";

        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        {
            SqlCommand command = new SqlCommand(query, connection);
            {

                // Open the connection, execute the INSERT query and close the connection.
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }

    }

    void OnTimedEvent(object source, System.Timers.ElapsedEventArgs e)
    {
        // Read in past quantities from log file and store them into quantityPast
        String File1 = HostingEnvironment.MapPath("~/Quantity.md");
        FileStream t1 = new System.IO.FileStream(File1, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
        StreamReader readFile = new StreamReader(t1);
        List<Int32> quantityPast = new List<Int32>();
        Int32 getLine;

        while (readFile.Peek() >= 0)
        {
            getLine = Convert.ToInt32(readFile.ReadLine());
            quantityPast.Add(getLine);
        }
        readFile.Close();
        t1.Close();
        
        // Read current quantityAvailable
        string query = "SELECT [quantityAvailable], [upc] FROM [Item]";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Get the current quantityAvailable
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            
            // Check if a result was returned.
            if (reader.HasRows)
            {
                int i = 0;
                // Iterate through the table to get the retrieved values.
                while (reader.Read())
                {
                    Int32 updatedQuantity = Convert.ToInt32(reader["quantityAvailable"].ToString().Trim());
                    string itemName = reader["upc"].ToString().Trim();

                    // Update the current quantityAvailable
                    string[] lines = File.ReadAllLines(File1);
                    lines[i] = updatedQuantity.ToString().Trim();
                    File.WriteAllLines(File1, lines);
                    
                    // If quantityPast[i] == 0 and is being updated to a positive number, then send email alert
                    if ((quantityPast[i] == 0) && (updatedQuantity > 0))
                    {
                        System.Diagnostics.Debug.WriteLine("Detected quantity refill for upc " + itemName);
                        // Create an instance of MailMessage named mail.
                        MailMessage mail = new MailMessage();

                        // Create an instance of SmtpClient named emailServer and set the mail server to use as "smtp.cse.ust.hk".
                        SmtpClient emailServer = new SmtpClient("smtp.cse.ust.hk");
                        emailServer.Timeout = 30000;

                        // Set the sender (From), receiver (To), subject and message body fields of the mail message.
                        mail.From = new MailAddress("wliab@stu.ust.hk", "AsiaWebShop");
                        using (SqlConnection connection2 = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString2"].ConnectionString))
                        {
                            // Get the email addresses subscribed to the item
                            connection2.Open();
                            SqlCommand command2 = new SqlCommand("SELECT [email] FROM [Subscription] WHERE ([upc] = N'" + itemName + "')", connection2);
                            SqlDataReader reader2 = command2.ExecuteReader();

                            if (reader2.HasRows)
                            {
                                while (reader2.Read())
                                {
                                    string subscriber = reader2["email"].ToString().Trim();
                                    mail.To.Add(subscriber);
                                }
                                
                                mail.Subject = "Item No. " + itemName + " is Available!";
                                mail.Body = "Dear Customer,\nThank you for your interest in Item No. " + itemName + ". New stock for this item is available. Act now!\nAsiaWebShop";

                                // Send the message.
                                emailServer.Send(mail);
                                System.Diagnostics.Debug.WriteLine("Can send email!");
                            }
                            connection2.Close();
                        }

                        // Delete the subscriptions
                        using (SqlConnection connection2 = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString2"].ConnectionString))
                        {
                            // Get the email addresses subscribed to the item
                            connection2.Open();
                            SqlCommand command2 = new SqlCommand("DELETE FROM [Subscription] WHERE ([upc] = N'" + itemName + "')", connection2);
                            SqlDataReader reader2 = command2.ExecuteReader();
                            connection2.Close();
                        }
                    }
                    ++i;
                }
            }
            command.Connection.Close();
        }
    }

       
</script>
