using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RegisterWebsite
{
    public partial class ContactUs : Page
    {
        public static readonly string LOCAL_TO_SERVER_CONNECTION_STRING = "Data Source=ahm43;Initial Catalog=ConnectivityEngineering;Integrated Security=False;User ID=Admin;Password=alnatest;Connect Timeout=30;Encrypt=False;TrustServerCertificate=True;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSendMessage_ServerClick(object sender, EventArgs e)
        {
            try
            {
                string query = "select Name, Email from Employees where Admin_Type=@value1";
                List<string> names = new List<string>();
                List<string> email = new List<string>();

                using (SqlConnection con = new SqlConnection(LOCAL_TO_SERVER_CONNECTION_STRING))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(query))
                    {
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@value1", 2);
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader == null)
                            return;

                        if (reader.HasRows)
                        {
                          

                            while (reader.Read())
                            {
                                names.Add(reader.GetString(0));
                                email.Add(reader.GetString(1));
                            }

                            reader.Close();


                          

                        }

                    }
                    con.Close();

                    if(names.Count == 0)
                    {
                        promptAlertToUser("Failed to send message. Please email contact admin", Color.Red);
                        redirectSafely("~/ContactUs");
                        return;
                    }

                    using (MailMessage mm = new MailMessage())
                    {

                        mm.To.Add(String.Join(", ", email));
                        // mm.To.Add("zachry.denny@alps.com");
                        mm.From = new MailAddress("AHM43-ContactUs@alps.com", "AHM43-ContactUs");
                        mm.Subject = "Contact Us";
                        mm.Body = "From: " + txtName.Value + "<br/>" + "Email: " + txtEmail.Value + "<br/>" + "Phone: " + txtPhone.Value + "<br/><br/>" + txtComment.Value.Replace("\r\n", "<br/>");

                        mm.IsBodyHtml = true;
                        SmtpClient smtp = new SmtpClient();
                        smtp.Host = "10.0.40.55";
                        smtp.UseDefaultCredentials = true;
                        smtp.Send(mm);



                    }

                    promptAlertToUser("Success", Color.ForestGreen);
                    redirectSafely("~/ContactUs");
                    return;
                }


            }
            catch(Exception ex)
            {

                promptAlertToUser("Failed to send message. Please email contact admin", Color.Red);
                redirectSafely("~/ContactUs");
            }

        
        }

        public void redirectSafely(string path)
        {
            try
            {
                HttpContext.Current.Response.Redirect(path, false);
            }
            catch (Exception e)
            {
                //writeStackTrace("problem redirecting", e);
            }
        }

        public void promptAlertToUser(string s)
        {
            Session["UserMessageText"] = s;
        }

        public void promptAlertToUser(string s, Color c)
        {
            Session["UserMessageColor"] = ColorTranslator.ToHtml(c);
            promptAlertToUser(s);
        }

        public void promptAlertToUser(string s, Color c, Color tc)
        {           
            Session["UserMessageTextColor"] = ColorTranslator.ToHtml(tc);
            promptAlertToUser(s, c);
        }
    }
}