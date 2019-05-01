using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.UI;

namespace MeetingWebsite
{
    public partial class _Default : Page
    {
        private static readonly HttpClient client = new HttpClient();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SelectReservations();
                PopulateDropDowns();
            }
        }
        private void SelectReservations()
        {
           
            try
            {
                // var responseString = await client.GetStringAsync("");
                string url = "http://ahm43/connectivitywebapi/api/SelectReservationEntites?Active={True}";
                HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(new Uri(url));
                request.ContentType = "application/json";
                request.Method = "GET";
                string message = "{\"Active\":\"" + true+ "\" }";

                string responseString;
                using (WebResponse response = request.GetResponse())
                {
                    responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();
                }
                Console.WriteLine(responseString);
                var array = JArray.Parse(responseString);
                List<RegistrationEntry> list = new List<RegistrationEntry>();
                foreach (var item in array)
                {
                    try
                    {
                        list.Add(item.ToObject<RegistrationEntry>());
                    }
                    catch (Exception ex)
                    {
                        
                    }
                }
                //DataTable dt = ToDataTable(list);
                rptCarousel.DataSource = list;
                rptCarousel.DataBind();




            }
            catch (Exception ex)
            {

            }
        }
        private void PopulateDropDowns()
        {

        }
    }
}