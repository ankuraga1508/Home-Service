using System;
using HSM.Interface;
using System.Data;
using HSM.Entity;
using HSM.Common;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Collections.Generic;

/// <summary>
/// This class make connection with database and call different stored procedures related to services.
/// </summary>

namespace HSM.DAL
{
    public class ServiceRepository : IServiceRepository
    {
        /// <summary>
        /// This method calls stored procedure addservice to add a new service.
        /// </summary>
        /// <param name="serviceDetails"></param>
        /// <returns>boolean</returns>
        public Boolean AddService(Service serviceDetails)
        {
            try
            {
                int id = serviceDetails.id;
                string serviceName = serviceDetails.serviceName;
                string serviceDesc = serviceDetails.serviceDesc;
                int serviceStatus = serviceDetails.serviceStatus;

                using (MySqlConnection con = new MySqlConnection(ConfigurationManager.AppSettings["connectionString"]))
                {
                   using (MySqlCommand cmd = new MySqlCommand("addservice"))
                    {
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.StoredProcedure;
                        if(id==0)
                            cmd.Parameters.AddWithValue("_id", null);
                        else
                            cmd.Parameters.AddWithValue("_id", id);
                        cmd.Parameters.AddWithValue("serviceName", serviceName);
                        cmd.Parameters.AddWithValue("servicesDesc", serviceDesc);
                        cmd.Parameters.AddWithValue("IsActive", serviceStatus);
                        cmd.ExecuteReader();
                        con.Close();
                        return true;
                    }
                }
               
            }
            catch (Exception ex)
            {
                var objErr = new ErrorClass(ex, "");
                objErr.LogException();
            }
            return false;
        }

        /// <summary>
        ///  This method calls stored procedure getallservices to get all available services.
        /// </summary>
        /// <returns></returns>
        public List<Service> GetAllServices()
        {
            var serviceList = new List<Service>();

            try
            {
                using (MySqlCommand cmd = new MySqlCommand("getallservices"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    Database db = new Database();
                    using (MySqlDataReader dr = db.SelectQry(cmd))
                    {
                        while (dr.Read())
                        {
                            serviceList.Add(new Service()
                            {
                                serviceName = dr["serviceName"].ToString(),
                                serviceDesc = dr["servicesDesc"].ToString(),
                                serviceStatus = Int32.Parse(dr["IsActive"].ToString()),
                                id = Int32.Parse(dr["id"].ToString()),
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
                var objErr = new ErrorClass(ex, "");
                objErr.LogException();
            }
            return serviceList;
        }
    }
}
