using Microsoft.Practices.Unity;
using Newtonsoft.Json;
using System;
using System.Web.Http;
using HSM.Common;
using HSM.BL;
using System.Net.Http;

/// <summary>
/// This class is request controller. All service requests goes through this controller. 
/// </summary>

namespace HSM.Services
{
    public class RequestController : ApiController
    {
        /// <summary>
        /// Handle Http request with service request details
        /// </summary>
        /// <param name="requestDetails"></param>
        /// <returns></returns>
        [System.Web.Http.HttpPost]
        [System.Web.Http.ActionName("postrequest")]
        public IHttpActionResult addRequest([FromBody] Entity.Request requestDetails)
        {
            string response = null;
            IUnityContainer container = new UnityContainer();
            RequestBL requestBL = new RequestBL(container);

            try
            {
                response = JsonConvert.SerializeObject(requestBL.addRequest(requestDetails));
            }
            catch (Exception ex)
            {
                var objErr = new ErrorClass(ex, "");
                objErr.LogException();
            }
            return Ok(response);
        }

        /// <summary>
        /// Http request to get service requests.
        /// </summary>
        /// <returns></returns>
        [System.Web.Http.HttpGet]
        [System.Web.Http.ActionName("getrequestbyfilters")]
        public IHttpActionResult getRequest()
        {
            string response = null;
            var QueryString = Request.RequestUri.ParseQueryString();

            int requesterid = (QueryString["requesterid"] != null && !String.IsNullOrEmpty(QueryString["requesterid"].ToString())) ? Convert.ToInt32(QueryString["requesterid"]) : -1;
            int caregiverid = (QueryString["caregiverid"] != null && !String.IsNullOrEmpty(QueryString["caregiverid"].ToString())) ? Convert.ToInt32(QueryString["caregiverid"]) : -1;
            string status = (QueryString["status"] != null && !String.IsNullOrEmpty(QueryString["status"].ToString())) ? QueryString["status"] : "";

            IUnityContainer container = new UnityContainer();
            RequestBL requestBL = new RequestBL(container);

            try
            {
                response = JsonConvert.SerializeObject(requestBL.getRequestsByFilters(caregiverid,requesterid,status));
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