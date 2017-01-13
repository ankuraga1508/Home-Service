# Home Service Manager

### Introduction

We recognize there is a need for a scalable communication solution for residents receiving home care solutions and their caregivers. Today, people want to stay in their own home as long as possible without moving into an assisted living facility. This is leading to an increase in the need for homecare services. Residents need to communicate their needs to caregivers, and caregivers need to keep track of the residents needs at a large scale. That is where the Home Service Manger comes in. Many residents don’t need all the available services when they start to receive home care, and their needs change over time. The goals of the home service manager are to allow residents to request alterations to their service quickly and to help caregivers manage many residents efficiently.

### Usage
The application has 3 main stakeholders or users associated with it. These are as follows.
  - Senior
    The end user of this application who will consume the services rolled out by an agency.
  - Administrator
    The user (typically a manager at the agency) who will assign the service requests.
  - Caregiver (CG)
    The user group that will be servicing the requests entered by the seniors and assigned to them by the administrator.

The request flow is initiated by the senior by scheduling a service offered by the agency. This service is next acknowledged by the administrator who either rejects it or assigns it to an available caregiver. The caregiver can now either complete the request or decline it.

![Request Flow](https://s30.postimg.org/nue17wkn5/Request_Flow.png)

Each type of user role is provided with a different home screen for role specific activities. The main activity for a senior is to request services. The admin is responsible for proper assignment of requests apart from maintenance activities. The CG is reponsible for carrying out the requests. The following screens are the role specific screens mentioned above.

#### Senior Dashboard
![Senior Dashboard](https://s30.postimg.org/fnm1gbukh/senior_Dashboard.png)
#### Admin Dashboard
![Admin Dashboard](https://s30.postimg.org/nf2revypt/admin_Dashboard.png)
#### Caregiver Dashboard
![Caregiver Dashboard](https://s30.postimg.org/irs3zdlz5/cg_Dashboard.png)

#### Video Demonstration

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/WXiOD7qXsDg/0.jpg)](https://www.youtube.com/watch?v=WXiOD7qXsDg)

### Execution Environment
This application needs a Windows server and MySql services to run. For execution on localhost, a Windows environment with Visual Studios and MySql is needed.

### Project Setup

1. Clone the Git repository on your local system by using the following command.
```sh
git clone https://github.com/arjun033/HomeServiceManager.git
```

2. Open Microsoft Visual Studio and go to 
    >File -> Open -> Project/Solution and select HomeServiceManager/HomeServiceApp/HSM.sln from the local repository.
    

3. Right click on HSMUI directory and choose "Set as StartUp Project".
4. Open the Web.config file and change the following line to add your MySql username and password.
```sh
<add key="connectionString" value="server=127.0.0.1;uid=YOUR_MYSQL_USER_ID;pwd=YOUR_MYSQL_PWD;database=home_service_db" />
```

### Database Setup

Open MySql command line client and run the HomeServiceManager/home_service_db.sql by using the following command
```sh
mysql> source \home\user\Desktop\home_service_db.sql;
```
Use the correct path according to your repository location.

### Running the Project

After completing all the above set up, go to Visual Studio and start the server by running the Default.aspx page through the browser. If everything is proper, the project will build and serve up on port 62649 by default.

A default admin user is predefined in the solution, with username "admin" and password "test". 

### Executables
The executables for this project can be fould in the cloned repository inside HomeServiceManager/HSMUI_Source.zip

### API Document

A comprehensive API documentation can be found [here](https://drive.google.com/file/d/0B54XkuNZdAcaVTlnbDI5WDRfQWM/view?usp=sharing)

### Contact Us

  - Arjun Bhattacharya - arjunb@iastate.edu
  - Ankur Agarwal - ankuraga@iastate.edu
  - Ian Peeler - iapeeler@iastate.edu
  - Vikas Jyoty - vjyoty@iastate.edu

### External Resources

  - [Microsoft Visual Studio](https://www.visualstudio.com/downloads/)
  - [MySql Community Server](http://dev.mysql.com/downloads/mysql/)
  - [Git](https://git-scm.com/downloads)
