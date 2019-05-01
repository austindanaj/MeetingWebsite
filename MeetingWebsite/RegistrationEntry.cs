using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MeetingWebsite
{
    public class RegistrationEntry
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Alna_Num { get; set; }
        public string Emp_Name { get; set; }
        public string Item_Type { get; set; }
        public System.DateTime Date_Created { get; set; }
        public System.DateTime Start_DateTime { get; set; }
        public System.DateTime End_DateTime { get; set; }
        public string Comment { get; set; }
        public bool Active { get; set; }
    }
}