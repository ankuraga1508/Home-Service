//using Carwale.Notifications.MailTemplates;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace HSM.Common
{
    public class ErrorClass
    {
        private Exception _err;
        public Exception Error
        {
            get { return _err; }
            set { _err = value; }
        }

        private string _pageUrl;
        public string PageUrl
        {
            get { return _pageUrl; }
            set { _pageUrl = value; }
        }


        //used for writing the debug messages
        private HttpContext objTrace = HttpContext.Current;

        //constructor which assigns the exception
        public ErrorClass(Exception ex, string pageUrl)
        {
            Error = ex;	//assign the exception
            PageUrl = pageUrl;		//assign the page url
        }

        public ErrorClass(SqlException ex, string pageUrl)
        {
            Error = (Exception)ex;	//convert the sqlexceptio to exception
            PageUrl = pageUrl;		//assign the page url
        }

        public ErrorClass(OleDbException ex, string pageUrl)
        {
            Error = (Exception)ex;	//convert the sqlexceptio to exception
            PageUrl = pageUrl;		//assign the page url
        }

        /********************************************************************************************
        SendMail()
        THIS FUNCTION sends the mail for the error message as passed in the constructor.
        First it checks the value for the sendError flag in the web.config file. if it is set to 'On'
        then only it sends the message. Note that web.config file is case sensitive, hence the value 
        should be 'On' only. By default it is assumed to be Off. If it is not required to send the mail
        then it is set to 'Off'. If it is set to On, the we get the mail id to which the message is 
        to be sent, from the key,: 'errorMail'. default it is set to rajeevmantu@gmail.com.
        The mail id from which the mail is to be sent is get from the key, "localMail".
        ********************************************************************************************/
        public void LogException()
        {            
            HttpContext.Current.Trace.Warn(_err.Message);
        }
    }//class
}
