using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/// <summary>
/// This class represents the model for User Credential
/// </summary>

namespace HSM.Entity
{
    public class Credential
    {
        public string UserName { get; set; }
        public string LoginPassword { get; set; }

    }

}

