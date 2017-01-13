using HSM.Entity;
using System.Collections.Generic;

/// <summary>
/// This class provides an interface for Service
/// </summary>

namespace HSM.Interface
{
    public interface IServiceRepository
    {
        /// <summary>
        /// Add new service
        /// </summary>
        /// <param name="serviceDetails"></param>
        /// <returns>boolean</returns>
        bool AddService(Service serviceDetails);

        /// <summary>
        /// Get all services
        /// </summary>
        /// <returns>List of Services</returns>
        List<Service> GetAllServices();

    }
}
