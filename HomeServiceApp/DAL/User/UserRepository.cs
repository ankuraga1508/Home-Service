using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HSM.Interface;
using System.Data;
using HSM.Entity;
using HSM.Common;
using MySql.Data.MySqlClient;
using Newtonsoft.Json.Linq;
using System.Configuration;

/// <summary>
/// This class make connection with database and call different stored procedures related to users.
/// </summary>

namespace HSM.DAL
{
    public class UserRepository : IUserRepository
    {
        /// <summary>
        ///  This method calls stored procedure getalluser to get all users from the database.
        /// </summary>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public List<User> GetAllUsers(int roleId)
        {
            var UserList = new List<User>();

            try
            {
                using (MySqlCommand cmd = new MySqlCommand("getalluser"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("_UserRoleId", roleId);
                    Database db = new Database();
                    using (MySqlDataReader dr = db.SelectQry(cmd))
                    {
                        while (dr.Read())
                        {
                            UserList.Add(new User()
                            {
                                idUser = Int32.Parse(dr["idUser"].ToString()),
                                UserName = dr["UserName"].ToString(),
                                UserEmail = dr["UserEmail"].ToString(),
                                UserMobile = dr["UserMobile"].ToString(),
                                UserSSN = dr["UserSSN"].ToString(),
                                LoginId = dr["LoginId"].ToString(),
                                LoginPassword = dr["LoginPassword"].ToString(),
                                CreatedOn = Convert.ToDateTime(dr["CreatedOn"].ToString()),
                                CreatedBy = Int32.Parse(dr["CreatedBy"].ToString()),
                                ModifiedOn = Convert.ToDateTime(dr["ModifiedOn"].ToString()),
                                ModifiedBy = Int32.Parse(dr["ModifiedBy"].ToString()),
                                IsActive = Int32.Parse(dr["IsActive"].ToString()),
                                Address = dr["Address"].ToString(),
                                FirstName = dr["FirstName"].ToString(),
                                LastName = dr["LastName"].ToString(),
                                Sex = dr["Sex"].ToString(),
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                var objErr = new ErrorClass(ex, "");
                objErr.LogException();
            }
            return UserList;
        }

        /// <summary>
        /// This method calls stored procedure userlogin to validate user credentials.
        /// </summary>
        /// <param name="usercr"></param>
        /// <returns>User</returns>
        public User userLogin(Credential usercr)
        {
            try
            {
                User user;

                string Username = usercr.UserName;
                string LoginPassword = usercr.LoginPassword;
                using (MySqlCommand cmd = new MySqlCommand("userlogin"))
                {                    
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("_username", Username);
                    cmd.Parameters.AddWithValue("_password", LoginPassword);
                    Database db = new Database();
                    using (MySqlDataReader dr = db.SelectQry(cmd))
                    {
                        if (dr.Read())
                        {
                            user = new User() {
                                UserRoleId = Int32.Parse(dr["UserRoleId"].ToString()),
                                idUser = Int32.Parse(dr["idUser"].ToString()),
                                UserName = dr["UserName"].ToString(),
                                UserEmail = dr["UserEmail"].ToString(),
                                UserMobile = dr["UserMobile"].ToString(),
                                UserSSN = dr["UserSSN"].ToString(),
                                CreatedOn = Convert.ToDateTime(dr["CreatedOn"].ToString()),
                                CreatedBy = Int32.Parse(dr["CreatedBy"].ToString()),
                                ModifiedOn = Convert.ToDateTime(dr["ModifiedOn"].ToString()),
                                ModifiedBy = Int32.Parse(dr["ModifiedBy"].ToString()),
                                IsActive = Int32.Parse(dr["IsActive"].ToString()),
                                Address = dr["Address"].ToString(),
                                FirstName = dr["FirstName"].ToString(),
                                LastName = dr["LastName"].ToString(),
                                Sex = dr["Sex"].ToString(),
                            };
                            return user;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.ToString());
                var objErr = new ErrorClass(ex, "");
                objErr.LogException();
            }
            return null;
        }

        /// <summary>
        /// This method calls stored procedure getuserbyid to get all users based on id.
        /// </summary>
        /// <param name="UserId"></param>
        /// <returns></returns>
        public User GetUserById(int UserId)
        {
            var UserData = new User();
            try
            {
                using (MySqlCommand cmd = new MySqlCommand("getuserbyid"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idUser", UserId);
                    Database db = new Database();
                    using (MySqlDataReader dr = db.SelectQry(cmd))
                    {

                        while (dr.Read())
                        {
                                UserData.idUser = Int32.Parse(dr["idUser"].ToString());
                                UserData.UserName = dr["UserName"].ToString();
                                UserData.UserEmail = dr["UserEmail"].ToString();
                                UserData.UserMobile = dr["UserMobile"].ToString();
                                UserData.UserSSN = dr["UserSSN"].ToString();
                                UserData.LoginId = dr["LoginId"].ToString();
                                UserData.LoginPassword = dr["LoginPassword"].ToString();
                                UserData.CreatedOn = Convert.ToDateTime(dr["CreatedOn"].ToString());
                                UserData.CreatedBy = Int32.Parse(dr["CreatedBy"].ToString());
                                UserData.ModifiedOn = Convert.ToDateTime(dr["ModifiedOn"].ToString());
                                UserData.ModifiedBy = Int32.Parse(dr["ModifiedBy"].ToString());
                                UserData.Address = dr["Address"].ToString();
                                UserData.FirstName = dr["FirstName"].ToString();
                                UserData.LastName = dr["LastName"].ToString();
                                UserData.Sex = dr["Sex"].ToString();
                        }

                    }

                }
            }
            catch (Exception ex)
            {
                var objErr = new ErrorClass(ex, "");
                objErr.LogException();
            }
            return UserData;
        }

        /// <summary>
        /// This method calls stored procedure getuserbyusername to get all users based on username.
        /// </summary>
        /// <param name="UserName"></param>
        /// <returns></returns>
        public User GetUserByUserName(string UserName)
        {
            var UserData = new User();
            try
            {
                using (MySqlCommand cmd = new MySqlCommand("getuserbyusername"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("_UserName", UserName);
                    Database db = new Database();
                    using (MySqlDataReader dr = db.SelectQry(cmd))
                    {

                        if (dr.Read())
                        {
                            UserData.idUser = Int32.Parse(dr["idUser"].ToString());
                            UserData.UserName = dr["UserName"].ToString();
                            UserData.UserEmail = dr["UserEmail"].ToString();
                            UserData.UserMobile = dr["UserMobile"].ToString();
                            UserData.UserSSN = dr["UserSSN"].ToString();
                            UserData.LoginId = dr["LoginId"].ToString();
                            UserData.LoginPassword = dr["LoginPassword"].ToString();
                            UserData.CreatedOn = Convert.ToDateTime(dr["CreatedOn"].ToString());
                            UserData.CreatedBy = Int32.Parse(dr["CreatedBy"].ToString());
                            UserData.ModifiedOn = Convert.ToDateTime(dr["ModifiedOn"].ToString());
                            UserData.ModifiedBy = Int32.Parse(dr["ModifiedBy"].ToString());
                            UserData.Address = dr["Address"].ToString();
                            UserData.FirstName = dr["FirstName"].ToString();
                            UserData.LastName = dr["LastName"].ToString();
                            UserData.Sex = dr["Sex"].ToString();
                        }

                    }

                }
            }
            catch (Exception ex)
            {
                var objErr = new ErrorClass(ex, "");
                objErr.LogException();
            }
            return UserData;
        }

        /// <summary>
        /// This method dave user's details into the database by calling stored procedure insertorupdate_user.
        /// </summary>
        /// <param name="UserData"></param>
        /// <returns>User</returns>
        public User SaveUserDetails(User UserData)
        {
            try
            {
                using (MySqlConnection con = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                    using (MySqlCommand cmd = new MySqlCommand("insertorupdate_user"))
                    {
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("_idUser", MySqlDbType.Int32).Value = UserData.idUser;
                        cmd.Parameters.Add("UserName", MySqlDbType.VarChar).Value = UserData.UserName;
                        cmd.Parameters.Add("UserEmail", MySqlDbType.VarChar).Value = UserData.UserEmail;
                        cmd.Parameters.Add("UserMobile", MySqlDbType.VarChar).Value = UserData.UserMobile;
                        cmd.Parameters.Add("UserRoleId", MySqlDbType.Int32).Value = UserData.UserRoleId;
                        cmd.Parameters.Add("UserSSN", MySqlDbType.VarChar).Value = UserData.UserSSN;
                        cmd.Parameters.Add("CreatedBy", MySqlDbType.Int32).Value = UserData.CreatedBy;
                        cmd.Parameters.Add("ModifiedBy", MySqlDbType.Int32).Value = UserData.ModifiedBy;
                        cmd.Parameters.Add("LoginId", MySqlDbType.VarChar).Value = UserData.LoginId;
                        cmd.Parameters.Add("LoginPassword", MySqlDbType.VarChar).Value = UserData.LoginPassword;
                        cmd.Parameters.Add("IsActive", MySqlDbType.Bit).Value = UserData.IsActive;
                        cmd.Parameters.Add("Address", MySqlDbType.VarChar).Value = UserData.Address;
                        cmd.Parameters.Add("FirstName", MySqlDbType.VarChar).Value = UserData.FirstName;
                        cmd.Parameters.Add("LastName", MySqlDbType.VarChar).Value = UserData.LastName;
                        cmd.Parameters.Add("Sex", MySqlDbType.VarChar).Value = UserData.Sex;
                        cmd.Parameters.AddWithValue("ModifiedOn", UserData.ModifiedOn);

                        cmd.ExecuteReader();
                        con.Close();

                        return GetUserByUserName(UserData.UserName);
                    }
                }

                
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
                var objErr = new ErrorClass(ex, "");
                objErr.LogException();
                return null;
            }

        }
    }
}
