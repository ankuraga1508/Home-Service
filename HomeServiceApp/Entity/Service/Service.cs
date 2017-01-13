using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/// <summary>
/// This class represents the model for Service
/// </summary>

namespace HSM.Entity
{
    public class Service
    {
        public string serviceName { get; set; }
        public string serviceDesc { get; set; }
        public int serviceStatus { get; set; }
        public int id { get; set; }
    }

}

