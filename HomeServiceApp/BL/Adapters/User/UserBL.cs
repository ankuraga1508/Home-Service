using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HSM.Interface;
using HSM.Entity;
using HSM.Common;
using HSM.DAL;
using Microsoft.Practices.Unity;

/// <summary>
/// This class represents business layer for user
/// </summary>

namespace HSM.BL
{
    public class UserBL
    {

        private readonly IUserRepository _userRepo;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="container"></param>
        public UserBL(IUnityContainer container)
        {
            container.RegisterType<IUserRepository, UserRepository>();
            _userRepo = container.Resolve<IUserRepository>();
        }

        /// <summary>
        /// Get all users (Senior, Admin, Caregiver)
        /// </summary>
        /// <param name="roleId"></param>
        /// <returns>List of User</returns>
        public List<User> GetAllUser(int roleId)
        {
            return _userRepo.GetAllUsers(roleId);
        }

        /// <summary>
        /// Verify User credentials
        /// </summary>
        /// <param name="usercr"></param>
        /// <returns>Valid User</returns>
        public User userLogin(Credential usercr)
        {
            return _userRepo.userLogin(usercr);

        }

        /// <summary>
        /// Get user using id
        /// </summary>
        /// <param name="userId"></param>
        /// <returns>User</returns>
        public User GetUserById(int userId)
        {
            return _userRepo.GetUserById(userId);
        }

        /// <summary>
        /// Get user using name
        /// </summary>
        /// <param name="UserName"></param>
        /// <returns>User</returns>
        public User GetUserByUserName(string UserName)
        {
            return _userRepo.GetUserByUserName(UserName);
        }

        /// <summary>
        /// Save user method
        /// </summary>
        /// <param name="userData"></param>
        /// <returns>User</returns>
        public User SaveUser(User userData)
        {
            return _userRepo.SaveUserDetails(userData);
        }
    }
}
