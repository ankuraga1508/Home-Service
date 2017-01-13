using HSM.Entity;
using System.Collections.Generic;

/// <summary>
/// This class provides an interface for Service Request
/// </summary>

namespace HSM.Interface
{
    public interface IRequestRepository
    {
        /// <summary>
        /// Add a new service request
        /// </summary>
        /// <param name="requestDetails"></param>
        /// <returns>boolean</returns>
        bool addRequest(Request requestDetails);

       
        /// <summary>
        /// Get service request by filters
        /// </summary>
        /// <param name="caregiverId"></param>
        /// <param name="requesterId"></param>
        /// <param name="status"></param>
        /// <returns>List of Request</returns>
        List<Request> getRequestsByFilters(int caregiverId, int requesterId, string status);
    }
}
