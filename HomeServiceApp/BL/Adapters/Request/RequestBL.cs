using HSM.Interface;
using HSM.DAL;
using Microsoft.Practices.Unity;
using HSM.Entity;
using System.Collections.Generic;

/// <summary>
/// This class represents business layer for service request
/// </summary>

namespace HSM.BL
{
    public class RequestBL
    {

        private readonly IRequestRepository _requestRepo;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="container"></param>
        public RequestBL(IUnityContainer container)
        {
            container.RegisterType<IRequestRepository, RequestRepository>();
            _requestRepo = container.Resolve<IRequestRepository>();
        }

        /// <summary>
        /// Add service request
        /// </summary>
        /// <param name="requestDetails"></param>
        /// <returns>boolean</returns>
        public bool addRequest(Request requestDetails)
        {
            return _requestRepo.addRequest(requestDetails);
        }

        /// <summary>
        /// get requests by different filters
        /// </summary>
        /// <param name="caregiverId"></param>
        /// <param name="requesterId"></param>
        /// <param name="status"></param>
        /// <returns>List of Request</returns>
        public List<Request> getRequestsByFilters(int caregiverId, int requesterId, string status)
        {
            return _requestRepo.getRequestsByFilters(caregiverId, requesterId, status);
        }
    }
}
