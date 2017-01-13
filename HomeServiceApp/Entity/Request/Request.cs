using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/// <summary>
/// This class represents the model for Service Request
/// </summary>

namespace HSM.Entity
{
    public class Request
    {
        public int id { get; set; }
        public int RequesterId { get; set; }
        public int RoleId { get; set; }
        public int CaregiverId { get; set; }
        public int ServiceId { get; set; }
        public string Status { get; set; }
        public string ScheduleDate { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string Comments { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime ModifiedOn { get; set; }

        public string Address { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string RequesterName { get; set; }
        public string serviceName { get; set; }
    }

}

