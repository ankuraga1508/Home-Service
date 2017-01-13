using HSM.Entity;
using System.Collections.Generic;

/// <summary>
/// This class provides an interface for User
/// </summary>

namespace HSM.Interface
{
    public interface IUserRepository
    {
        /// <summary>
        /// get all Users list
        /// </summary>
        /// <param name="roleId"></param>
        /// <returns>List of User</returns>
        List<User> GetAllUsers(int roleId);

        /// <summary>
        /// Check user is valid or not
        /// </summary>
        /// <param name="usercr"></param>
        /// <returns>User</returns>
        User userLogin(Credential usercr);

        /// <summary>
        /// get userdetails based on UserId
        /// </summary>
        /// <param name="UserId"></param>
        /// <returns>User</returns>
        User GetUserById(int UserId);

        /// <summary>
        /// get user based on UserName
        /// </summary>
        /// <param name="UserId"></param>
        /// <returns>User</returns>
        User GetUserByUserName(string UserName);

        /// <summary>
        /// Save/Update User info
        /// </summary>
        /// <param name="UserData"></param>
        /// <returns>User</returns>
        User SaveUserDetails(User UserData);


    }
}
