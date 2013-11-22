<%@ Application Language="C#" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Timers" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web.Hosting"  %>
<%@ Import Namespace="System.Net.Mail"  %>

<script runat="server">
    public class Availability
    {
        // Member variables
        public string upc;
        public int quantityAvailable;

        // Default constructor
        public Availability()
        {
            upc = "";
            quantityAvailable = 0;
        }

        // Assignment constructor
        public Availability(string u, int q)
        {
            upc = u;
            quantityAvailable = q;
        }

        // Copy constructor
        public Availability(Availability a)
        {
            upc = a.upc;
            quantityAvailable = a.quantityAvailable;
        }
    }
    
    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup
        System.Timers.Timer aTimer = new System.Timers.Timer(30000);
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
        System.Diagnostics.Debug.Write("Session end.");
        System.Diagnostics.Debug.Write("Username:");
        System.Diagnostics.Debug.WriteLine(Session["Username"].ToString());
        
        string username = Session["Username"].ToString().Trim();
        string connectionString = "AsiaWebShopDBConnectionString";
        string query = "UPDATE [Item] SET [quantityAvailable] = ([Item].[quantityAvailable] + [ShoppingCart].[quantity]) FROM [Item] JOIN [ShoppingCart] ON ([ShoppingCart].[upc] = [Item].[upc]) WHERE ([isReleased] = 'False' AND [ShoppingCart].[userName] = '" + username + "')";

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

         query = "UPDATE [ShoppingCart] SET [isReleased] = 'True' WHERE ([isReleased] = 'False' AND [userName] = '" + username + "')";
        
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
        List<Availability> availabilityPast = new List<Availability>();

        while (readFile.Peek() >= 0)
        {
            Availability availabilityItem = new Availability(readFile.ReadLine(), Convert.ToInt32(readFile.ReadLine()));
            availabilityPast.Add(availabilityItem);
        }
        readFile.Close();
        t1.Close();
        
        // Read current quantityAvailable
        string query = "SELECT [quantityAvailable], [upc], [name], [visible] FROM [Item]";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Get the current quantityAvailable
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            
            // Check if a result was returned.
            if (reader.HasRows)
            {
                //int i = 0;
                // Iterate through the table to get the retrieved values.
                while (reader.Read())
                {
                    Int32 updatedQuantity = Convert.ToInt32(reader["quantityAvailable"].ToString().Trim());
                    string itemName = reader["name"].ToString().Trim();
                    string itemUPC = reader["upc"].ToString().Trim();
                    bool isVisible = Convert.ToBoolean(reader["visible"].ToString().Trim());

                    // See if UPC exists
                    bool hasUPC = false;
                    for (int i = 0; i < availabilityPast.Count; ++i)
                    {
                        if (availabilityPast[i].upc == itemUPC)
                        {
                            hasUPC = true;
                            
                            // If past quantity is 0 and is being updated to a positive number and is visible, then send email alert
                            if ((availabilityPast[i].quantityAvailable == 0) && (updatedQuantity > 0) && (isVisible))
                            {
                                System.Diagnostics.Debug.WriteLine("Detected quantity refill for upc " + itemUPC);
                                // Create an instance of MailMessage named mail.
                                MailMessage mail = new MailMessage();

                                // Create an instance of SmtpClient named emailServer and set the mail server to use as "smtp.cse.ust.hk".
                                SmtpClient emailServer = new SmtpClient("smtp.cse.ust.hk");
                                emailServer.Timeout = 30000;

                                // Set the sender (From), receiver (To), subject and message body fields of the mail message.
                                mail.From = new MailAddress("sharpert115@yeah.net", "AsiaWebShop");
                                using (SqlConnection connection2 = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString2"].ConnectionString))
                                {
                                    // Get the email addresses subscribed to the item
                                    connection2.Open();
                                    SqlCommand command2 = new SqlCommand("SELECT [email] FROM [Subscription] WHERE ([upc] = N'" + itemUPC + "')", connection2);
                                    SqlDataReader reader2 = command2.ExecuteReader();

                                    if (reader2.HasRows)
                                    {
                                        while (reader2.Read())
                                        {
                                            string subscriber = reader2["email"].ToString().Trim();
                                            mail.To.Add(subscriber);
                                        }

                                        mail.Subject = "Item " + itemName + " is Available!";
                                        mail.Body = "Dear Customer,\nThank you for your interest in Item " + itemName + ". New stock for this item is available. Act now!\nAsiaWebShop";

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
                                    SqlCommand command2 = new SqlCommand("DELETE FROM [Subscription] WHERE ([upc] = N'" + itemUPC + "')", connection2);
                                    SqlDataReader reader2 = command2.ExecuteReader();
                                    connection2.Close();
                                }
                            }
                            
                            availabilityPast[i].quantityAvailable = updatedQuantity;// update the quantity in array
                            break;// no need to iterate through
                        }
                    }
                    
                    // If a new item exists, add it to the availability array
                    if (!hasUPC)
                    {
                        Availability newItem = new Availability(itemUPC, updatedQuantity);
                        availabilityPast.Add(newItem);
                    }

                    List<string> lines = new List<string>();
                    
                    // Convert availability array to string list
                    for (int i = 0; i < availabilityPast.Count; ++i)
                    {
                        lines.Add(availabilityPast[i].upc);
                        lines.Add(Convert.ToString(availabilityPast[i].quantityAvailable));
                    }

                    try
                    {
                        File.WriteAllLines(File1, lines);
                    }
                    catch (IOException)
                    {
                        System.Diagnostics.Debug.WriteLine("An I/O exception occurred. Safe to continue though.");
                    }
                }
            }
            command.Connection.Close();
        }
    }

       
</script>
