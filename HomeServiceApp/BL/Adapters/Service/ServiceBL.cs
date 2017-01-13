using HSM.Interface;
using HSM.DAL;
using Microsoft.Practices.Unity;
using HSM.Entity;
using System.Collections.Generic;

/// <summary>
/// This class represents business layer for service
/// </summary>

namespace HSM.BL
{
    public class ServiceBL
    {

        private readonly IServiceRepository _serviceRepo;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="container"></param>
        public ServiceBL(IUnityContainer container)
        {
            container.RegisterType<IServiceRepository, ServiceRepository>();
            _serviceRepo = container.Resolve<IServiceRepository>();
        }

        /// <summary>
        /// Add a service into the system
        /// </summary>
        /// <param name="serviceDetails"></param>
        /// <returns>boolean</returns>
        public bool AddService(Service serviceDetails)
        {
            return _serviceRepo.AddService(serviceDetails);
        }

        /// <summary>
        /// Get all services available
        /// </summary>
        /// <returns>List of Services</returns>
        public List<Service> GetAllServices()
        {
            return _serviceRepo.GetAllServices();
        }
    }
}
