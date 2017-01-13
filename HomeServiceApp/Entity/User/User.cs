using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/// <summary>
/// This class represents the model for User
/// </summary>

namespace HSM.Entity
{
    public class User : Credential
    {
        public int idUser { get; set; }
        public string LoginId { get; set; }
       
        public string UserEmail { get; set; }
        public string UserMobile { get; set; }

        public int UserRoleId { get; set; }
        public string UserSSN { get; set; }

        public DateTime CreatedOn { get; set; }
        public int CreatedBy { get; set; }
        public DateTime ModifiedOn { get; set; }
        public int ModifiedBy { get; set; }

        public int IsActive { get; set; }
        public string Address { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Sex { get; set; }

    }

}

