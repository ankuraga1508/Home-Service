using Microsoft.Practices.Unity;
using Newtonsoft.Json;
using System;
using System.Web.Http;
using HSM.Common;
using HSM.BL;

/// <summary>
/// This class is Service controller. All service related calls goes through this controller. 
/// </summary>

namespace HSM.Services
{
    public class ServiceController : ApiController
    {
        /// <summary>
        /// Handle Http request with service details
        /// </summary>
        /// <param name="serviceDetails"></param>
        /// <returns></returns>
        [System.Web.Http.HttpPost]
        [System.Web.Http.ActionName("addservice")]
        public IHttpActionResult addService([FromBody] Entity.Service serviceDetails)
        {
            string response = null;
            IUnityContainer container = new UnityContainer();
            ServiceBL serviceBl = new ServiceBL(container);

            try
            {
                response = JsonConvert.SerializeObject(serviceBl.AddService(serviceDetails));
            }
            catch (Exception ex)
            {
                var objErr = new ErrorClass(ex, "");
                objErr.LogException();
            }
            return Ok(response);
        }

        /// <summary>
        /// Handle Http request for get all services
        /// </summary>
        /// <returns></returns>
        [System.Web.Http.HttpGet]
        [System.Web.Http.ActionName("services")]
        public IHttpActionResult GetAllServices()
        {
            string response = null;
            IUnityContainer container = new UnityContainer();
            ServiceBL serviceBl = new ServiceBL(container);
            try
            {
                response = JsonConvert.SerializeObject(serviceBl.GetAllServices());
            }
            catch (Exception ex)
            {
                var objErr = new ErrorClass(ex, "");
                objErr.LogException();
            }
            return Ok(response);

        }
    }
}