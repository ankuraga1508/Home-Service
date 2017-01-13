using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web;
using System.Threading;
using HSM.Common;

namespace HSM.DAL
{
    public class Database
    {
        private MySqlConnection con;
        private MySqlCommand cmd;
        private String strConn;
        public static int Static_count = 0;
        public int count = 0;
        private HttpContext objTrace = HttpContext.Current;

        public MySqlConnection Conn
        {
            get { return con; }
            set { con = value; }
        }

        public Database(string connectionString)
        {
            strConn = connectionString;
        }

        /// <summary>
        /// Overload for not providing connetion String.
        /// By default it will take connection string from web config file.
        /// </summary>
        public Database()
        {
            this.strConn = ConfigurationManager.AppSettings["connectionString"];
        }

        //return the connection string
        public string GetConString()
        {
            return strConn;
        }

        public MySqlDataReader SelectQry(string strSql)
        {
            MySqlDataReader dataReader;
            con = new MySqlConnection(strConn);

            try
            {
                con.Open();
                cmd = new MySqlCommand(strSql, con);
                dataReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);

                return dataReader;
            }
            catch (Exception)
            {
                CloseConnection();
                throw;
            }
        }

        public MySqlDataReader SelectQry(string sqlStr, MySqlParameter[] commandParameters)
        {
            MySqlDataReader dataReader = null;
            con = new MySqlConnection(strConn);

            try
            {
                con.Open();
                cmd = new MySqlCommand(sqlStr, con);
                foreach (MySqlParameter p in commandParameters)
                {
                    if ((p.Direction == ParameterDirection.InputOutput) && (p.Value == null))
                        p.Value = DBNull.Value;

                    cmd.Parameters.Add(p);
                }
                dataReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                cmd.Parameters.Clear();
                //CloseConnection();
            }
            return dataReader;
        }

        public MySqlDataReader SelectQry(MySqlCommand cmdParam)
        {
            MySqlDataReader dataReader = null;

            try
            {
                using (con = new MySqlConnection(strConn))
                {
                    con = new MySqlConnection(strConn);
                    cmdParam.Connection = con;
                    con.Open();
                    dataReader = cmdParam.ExecuteReader(CommandBehavior.CloseConnection);
                    cmdParam.Parameters.Clear();
                }
            }
            catch (Exception err)
            {
                cmdParam.Parameters.Clear();
                CloseConnection();

                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }

            return dataReader;
        }

        public DataSet SelectAdaptQry(string strSql)
        {
            DataSet dataSet = new DataSet();
            con = new MySqlConnection(strConn);

            try
            {
                MySqlDataAdapter adapter = new MySqlDataAdapter();
                adapter.SelectCommand = new MySqlCommand(strSql, con);
                adapter.Fill(dataSet);
            }
            catch (MySqlException exSql)
            {
                dataSet = null;

                var objErr = new ErrorClass(exSql, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                CloseConnection();
            }

            return dataSet;
        }

        public DataSet SelectAdaptQry(string sqlStr, MySqlParameter[] commandParameters)
        {
            DataSet dataSet = new DataSet();

            con = new MySqlConnection(strConn);
            MySqlDataAdapter adapter = new MySqlDataAdapter();
            try
            {
                adapter.SelectCommand = new MySqlCommand(sqlStr, con);

                foreach (MySqlParameter p in commandParameters)
                {
                    if ((p.Direction == ParameterDirection.InputOutput) && (p.Value == null))
                        p.Value = DBNull.Value;

                    adapter.SelectCommand.Parameters.Add(p);
                }
                adapter.Fill(dataSet);
                adapter.SelectCommand.Parameters.Clear();
            }
            catch (MySqlException exSql)
            {
                dataSet = null;

                var objErr = new ErrorClass(exSql, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                adapter.SelectCommand.Parameters.Clear();
                CloseConnection();
            }
            return dataSet;
        }

        public DataSet SelectAdaptQry(MySqlCommand cmdParam)
        {
            con = new MySqlConnection(strConn);
            DataSet dataSet = new DataSet();
            MySqlDataAdapter adapter = new MySqlDataAdapter();

            try
            {

                cmdParam.Connection = con;
                //con.Open();
                adapter.SelectCommand = cmdParam;
                adapter.Fill(dataSet);
            }
            catch (MySqlException exSql)
            {
                dataSet = null;

                var objErr = new ErrorClass(exSql, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                CloseConnection();
            }
            return dataSet;
        }

        public void CloseConnection()
        {
            try
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
        }

        public bool InsertQry(string strSql)
        {
            int intRetRows;
            con = new MySqlConnection(strConn);
            bool result = false;
            try
            {
                cmd = new MySqlCommand(strSql, con);
                con.Open();

                intRetRows = cmd.ExecuteNonQuery();
                if (intRetRows > 0)
                    result = true;
                else
                    result = false;
            }
            catch (Exception ex)
            {
                var objErr = new ErrorClass(ex, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                CloseConnection();
            }
            return result;
        }

        public bool InsertQry(string sqlStr, MySqlParameter[] commandParameters)
        {
            con = new MySqlConnection(strConn);
            bool result = false;

            try
            {
                cmd = new MySqlCommand(sqlStr, con);
                con.Open();

                foreach (MySqlParameter p in commandParameters)
                {
                    if ((p.Direction == ParameterDirection.InputOutput) && (p.Value == null))
                        p.Value = DBNull.Value;

                    cmd.Parameters.Add(p);
                }

                int retval = cmd.ExecuteNonQuery();

                if (retval > 0)
                    result = true;
                else
                    result = false;
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                cmd.Parameters.Clear();
                CloseConnection();
            }
            return result;
        }

        public bool InsertQry(MySqlCommand cmdParam)
        {
            con = new MySqlConnection(strConn);
            bool result = false;

            try
            {
                cmdParam.Connection = con;
                con.Open();

                int retval = cmdParam.ExecuteNonQuery();

                if (retval > 0)
                    result = true;
                else
                    result = false;
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                cmdParam.Parameters.Clear();
                CloseConnection();
            }
            return result;
        }

        public bool UpdateQry(string strSql)
        {
            int intRetRows;
            con = new MySqlConnection(strConn);
            bool result;
            try
            {
                cmd = new MySqlCommand(strSql, con);
                con.Open();
                intRetRows = cmd.ExecuteNonQuery();

                if (intRetRows > 0)
                    result = true;
                else
                    result = false;
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                CloseConnection();
            }
            return result;
        }

        public bool UpdateQry(string sqlStr, MySqlParameter[] commandParameters)
        {
            con = new MySqlConnection(strConn);
            bool result = false;

            try
            {
                cmd = new MySqlCommand(sqlStr, con);
                con.Open();

                foreach (MySqlParameter p in commandParameters)
                {
                    if ((p.Direction == ParameterDirection.InputOutput) && (p.Value == null))
                        p.Value = DBNull.Value;

                    cmd.Parameters.Add(p);
                }

                int retval = cmd.ExecuteNonQuery();

                if (retval > 0)
                    result = true;
                else
                    result = false;


            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                cmd.Parameters.Clear();
                CloseConnection();
            }
            return result;
        }

        public bool UpdateQry(MySqlCommand cmdParam)
        {
            con = new MySqlConnection(strConn);
            bool result = false;

            try
            {
                cmdParam.Connection = con;
                con.Open();

                int retval = cmdParam.ExecuteNonQuery();

                if (retval > 0)
                    result = true;
                else
                    result = false;
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                cmdParam.Parameters.Clear();
                CloseConnection();
            }
            return result;
        }

        public int UpdateQryRetRows(string strSql)
        {
            int intRetRows = 0;
            con = new MySqlConnection(strConn);

            try
            {
                cmd = new MySqlCommand(strSql, con);
                con.Open();

                intRetRows = cmd.ExecuteNonQuery();
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                CloseConnection();
            }
            return intRetRows;
        }

        public int UpdateQryRetRows(string sqlStr, MySqlParameter[] commandParameters)
        {
            con = new MySqlConnection(strConn);
            int intRetRows = 0;

            try
            {
                cmd = new MySqlCommand(sqlStr, con);
                con.Open();

                foreach (MySqlParameter p in commandParameters)
                {
                    if ((p.Direction == ParameterDirection.InputOutput) && (p.Value == null))
                        p.Value = DBNull.Value;

                    cmd.Parameters.Add(p);
                }

                intRetRows = cmd.ExecuteNonQuery();

            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                cmd.Parameters.Clear();
                CloseConnection();
            }
            return intRetRows;
        }

        public bool DeleteQry(string strSql)
        {
            bool result = false;
            int intRetRows;
            con = new MySqlConnection(strConn);

            try
            {
                cmd = new MySqlCommand(strSql, con);
                con.Open();

                intRetRows = cmd.ExecuteNonQuery();
                if (intRetRows > 0)
                {
                    result = true;
                }
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                CloseConnection();
            }

            return result;

        }

        public bool DeleteQry(string sqlStr, MySqlParameter[] commandParameters)
        {
            con = new MySqlConnection(strConn);
            bool result = false;

            try
            {
                cmd = new MySqlCommand(sqlStr, con);
                con.Open();

                foreach (MySqlParameter p in commandParameters)
                {
                    if ((p.Direction == ParameterDirection.InputOutput) && (p.Value == null))
                        p.Value = DBNull.Value;

                    cmd.Parameters.Add(p);
                }

                int retval = cmd.ExecuteNonQuery();

                if (retval > 0)
                    result = true;
                else
                    result = false;


            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();

            }
            finally
            {
                cmd.Parameters.Clear();
                CloseConnection();
            }
            return result;
        }

        public bool DeleteQry(MySqlCommand cmdParam)
        {
            con = new MySqlConnection(strConn);
            bool result = false;

            try
            {
                cmdParam.Connection = con;
                con.Open();

                int retval = cmdParam.ExecuteNonQuery();

                if (retval > 0)
                    result = true;
                else
                    result = false;
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                cmdParam.Parameters.Clear();
                CloseConnection();
            }
            return result;
        }

        public string ExecuteScalar(string strSql)
        {
            string val = "";

            MySqlConnection con;
            MySqlCommand cmd;

            string conStr = GetConString();

            con = new MySqlConnection(conStr);

            try
            {
                con.Open();
                cmd = new MySqlCommand(strSql, con);
                val = Convert.ToString(cmd.ExecuteScalar());
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                CloseConnection();
            }
            return val;
        }

        public string ExecuteScalar(string strSql, MySqlParameter[] commandParameters)
        {
            string val = "";
            con = new MySqlConnection(strConn);

            try
            {
                cmd = new MySqlCommand(strSql, con);
                con.Open();

                foreach (MySqlParameter p in commandParameters)
                {
                    if ((p.Direction == ParameterDirection.InputOutput) && (p.Value == null))
                        p.Value = DBNull.Value;

                    cmd.Parameters.Add(p);
                }
                val = Convert.ToString(cmd.ExecuteScalar());

            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                cmd.Parameters.Clear();
                CloseConnection();
            }
            return val;
        }

        /// <summary>
        /// Execute this function when passing sqlcomand 
        /// </summary>
        /// <param name="cmd"></param>
        /// <returns>returns first rows & first column value</returns>
        public string ExecuteScalar(MySqlCommand cmd)
        {
            string val = "";

            string conStr = GetConString();
            con = new MySqlConnection(conStr);
            try
            {
                con.Open();
                cmd.Connection = con;
                val = Convert.ToString(cmd.ExecuteScalar());
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                CloseConnection();
            }
            return val;
        }

        //using MySqlCommand
        public string GetInClauseValue(string input, string fieldName, MySqlCommand cmd)
        {
            string[] inputArr = input.Split(',');
            string[] parameters = new string[inputArr.Length];
            try
            {
                for (int i = 0; i < inputArr.Length; i++)
                {
                    cmd.Parameters.Add("@" + fieldName + i, MySqlDbType.VarChar, inputArr[i].Length).Value = inputArr[i].ToString();
                    parameters[i] = "@" + fieldName + i;
                }
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            return string.Join(",", parameters);
        }

        public string GetInClauseValue(string input, string fieldName, out MySqlParameter[] commandParameters)
        {
            string[] inputArr = input.Split(',');
            string[] parameters = new string[inputArr.Length];
            commandParameters = null;
            try
            {
                commandParameters = new MySqlParameter[inputArr.Length];

                for (int i = 0; i < inputArr.Length; i++)
                {
                    parameters[i] = "@" + fieldName + i;
                    commandParameters[i] = new MySqlParameter(parameters[i], inputArr[i]);
                    HttpContext.Current.Trace.Warn(parameters[i].ToString() + " : " + inputArr[i].ToString());
                }

                HttpContext.Current.Trace.Warn(commandParameters.Length.ToString());
            }
            catch (Exception err)
            {
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }

            return string.Join(",", parameters);
        }

        public MySqlParameter[] ConcatenateParams(MySqlParameter[] param1, MySqlParameter[] param2)
        {
            MySqlParameter[] param = null;

            if (param1 != null && param2 != null)
            {
                param = new MySqlParameter[param1.Length + param2.Length];

                for (int i = 0; i < param1.Length; i++)
                {
                    param[i] = param1[i];
                }

                for (int i = param1.Length; i < param.Length; i++)
                {
                    param[i] = param2[i - param1.Length];
                }

                for (int i = 0; i < param.Length; i++)
                {
                    HttpContext.Current.Trace.Warn("Param : " + i.ToString() + " : " + param[i]);
                }
            }
            else if (param1 != null)
                param = param1;
            else if (param2 != null)
                param = param2;

            return param;
        }

        public MySqlParameter[] ConcatenateParams(MySqlParameter[] param1, MySqlParameter[] param2, MySqlParameter[] param3)
        {
            //first join the first 2 params
            MySqlParameter[] paramRes1 = ConcatenateParams(param1, param2);
            return ConcatenateParams(paramRes1, param3);
        }

        public MySqlParameter[] ConcatenateParams(MySqlParameter[] param1, MySqlParameter[] param2, MySqlParameter[] param3,
                                                                    MySqlParameter[] param4)
        {
            //first join the first 2 params
            MySqlParameter[] paramRes1 = ConcatenateParams(param1, param2, param3);
            return ConcatenateParams(paramRes1, param4);
        }
        /// <summary>
        /// similar to method SelectAdaptQry(MySqlCommand cmdParam) but the parameters of the input MySqlCommand remain intact
        /// </summary>
        public DataSet SelectAdaptQryParamNC(MySqlCommand cmdParam)
        {
            con = new MySqlConnection(strConn);
            DataSet dataSet = new DataSet();
            MySqlDataAdapter adapter = new MySqlDataAdapter();

            try
            {
                cmdParam.Connection = con;
                //con.Open();
                adapter.SelectCommand = cmdParam;
                adapter.Fill(dataSet);
            }
            catch (MySqlException exSql)
            {
                dataSet = null;
                var objErr = new ErrorClass(exSql, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            catch (Exception err)
            {
                HttpContext.Current.Trace.Warn(err.Message + err.Source);
                var objErr = new ErrorClass(err, HttpContext.Current.Request.ServerVariables["URL"]);
                objErr.LogException();
            }
            finally
            {
                CloseConnection();
            }
            return dataSet;
        }

        //Added By Ranjeet ||For async || Used for Used car search
        public async Task<DataTable> AsyncGetDataTable(MySqlCommand cmd)
        {
            DataTable dt = new DataTable();
            var asyncConnectionString = new MySqlConnectionStringBuilder(ConfigurationManager.AppSettings["connectionString"])
            {
                //AsynchronousProcessing = true
            }.ToString();

            using (var conn = new MySqlConnection(asyncConnectionString))
            {
                try
                {
                    Static_count += 1;

                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;

                    await cmd.Connection.OpenAsync().ConfigureAwait(false);

                    using (var reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false))
                    {
                        //Thread.Sleep(2000);
                        dt.Load(reader);
                    }

                    cmd.Connection.Close();
                }
                catch (Exception ex)
                {
                    var objErr = new ErrorClass(ex, "AsyncDb sql: ");
                    objErr.LogException();
                }
            }
            return dt;
        }

        
    }
}
