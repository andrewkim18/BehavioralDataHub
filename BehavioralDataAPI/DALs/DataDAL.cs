using BehavioralDataAPI.Models;
using NuGet.Packaging.Signing;
using Org.BouncyCastle.Ocsp;
using System.Data.SqlClient;
using System.Reflection.PortableExecutable;
using System.Xml.Linq;

namespace BehavioralDataAPI.DALs
{
    public class DataDAL
    {
        SqlConnection conn;
        public DataDAL()
        {
            //probably some security stuff/db connection here
            string constr = @"Initial Catalog=healthDataHub;Integrated Security=True;Connect Timeout=30;Encrypt=False;";
            conn = new SqlConnection(constr);
        }

        public List<DataPoint> GetUserData(long id)
        {
            if (conn.State != System.Data.ConnectionState.Open)
            {
                conn.Close();
                conn.Open();
            }

            SqlCommand cmd;
            SqlDataReader dreader;
            string sql1 = "select * from Basic_Data where Participant = @IDNum;";
            string sql2 = "select * from Calorie_Data where Participant = @IDNum;";
            string sql3 = "select * from Heart_Rate_Data where Participant = @IDNum;";
            SqlParameter param = new SqlParameter("@IDNum", id);
            cmd = new SqlCommand(sql1, conn);
            cmd.Parameters.Add(param);
            dreader = cmd.ExecuteReader();
            if (!(dreader.HasRows))
            {
                return null;
            }
            List<DataPoint> ret = new List<DataPoint>();
            while (dreader.Read())
            {
                ret.Add(new DataPoint()
                {
                    UserId = (long)dreader.GetValue(1),
                    Name = "Height",
                    CollectionDate = dreader.GetString(2),
                    Value = (int)dreader.GetValue(3),

                });
                ret.Add(new DataPoint
                {
                    UserId = (long)dreader.GetValue(1),
                    Name = "Weight",
                    CollectionDate = dreader.GetString(2),
                    Value = (int)dreader.GetValue(4),
                });
            }
            //TODO sql queries that return list of all users
            dreader.Close();
            cmd.Dispose();
            cmd = new SqlCommand(sql2, conn);
            param = new SqlParameter("@IDNum", id);
            cmd.Parameters.Add(param);
            dreader = cmd.ExecuteReader();
            while (dreader.Read())
            {
                ret.Add(new DataPoint()
                {
                    UserId = (long)dreader.GetValue(1),
                    Name= "CaloriesBurned",
                    CollectionDate = dreader.GetString(2),
                    Value = (int)dreader.GetValue(3),

                });
            }
            dreader.Close();
            cmd.Dispose(); 
            cmd = new SqlCommand(sql3, conn);
            param = new SqlParameter("@IDNum", id);
            cmd.Parameters.Add(param);
            dreader = cmd.ExecuteReader();
            while (dreader.Read())
            {
                ret.Add(new DataPoint()
                {
                    UserId = (long)dreader.GetValue(1),
                    Name= "HeartRate",
                    CollectionDate = dreader.GetString(2),
                    Value = (int)dreader.GetValue(3),

                });
            }
            dreader.Close();
            cmd.Dispose();
            conn.Close();
            return ret;
            
        }

        public DataPoint GetUserAttribute(long id, string name)
        {
            if (conn.State != System.Data.ConnectionState.Open)
            {
                conn.Close();
                conn.Open();
            }

            SqlCommand cmd;
            SqlDataReader dreader;
            SqlParameter param;
            int idx = 0;
            string sql;
            DataPoint ret;
            if (name.Equals("Height") || name.Equals("Weight"))
            {
                sql = "select * from Basic_Data where Participant = @IDNum;";
                idx = name.Equals("Height") ? 3 : 4;
                param = new SqlParameter("@IDNum", id);
                cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add(param);
                dreader = cmd.ExecuteReader();
                if (!(dreader.HasRows))
                {
                    return null;
                }
                dreader.Read();
                ret = new DataPoint()
                {
                    UserId = (long)dreader.GetValue(1),
                    Name = name,
                    CollectionDate = dreader.GetString(2),
                    Value = (int)dreader.GetValue(idx),
                };

                dreader.Close();
                cmd.Dispose();
                conn.Close();
                return ret;
            }
            else if (name.Equals("HeartRate"))
            {
                sql = "select * from Heart_Rate_Data where Participant = @IDNum;";
                idx = 3;
            }
            else if (name.Equals("CaloriesBurned"))
            {
                sql = "select * from Calorie_Data where Participant = @IDNum;";
                idx = 3;
            }
            else
            {
                return null;
            }
            param = new SqlParameter("@IDNum", id);
            cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(param);
            dreader = cmd.ExecuteReader();
            if (!(dreader.HasRows))
            {
                return null;
            }
            dreader.Read();
            ret = new DataPoint()
            {
                UserId = (long)dreader.GetValue(1),
                Name = name,
                CollectionDate = dreader.GetString(2),
                Value = (int)dreader.GetValue(idx),
            };
            dreader.Close();
            cmd.Dispose();
            conn.Close();
            return ret;
        }

        public DataPoint PutUserAttribute(long id, DataPoint data)
        {
            if (data == null || data.Name == null)
            {
                return null;
            }
            if (conn.State != System.Data.ConnectionState.Open)
            {
                conn.Close();
                conn.Open();
            }

            SqlCommand cmd;
            SqlDataReader dreader;
            SqlDataAdapter d = new SqlDataAdapter();
            string sql;
            SqlParameter param;
            SqlParameter param2;
            if (data.Name.Equals("Height") || data.Name.Equals("Weight"))
            {
                sql = "select * from Basic_Data where Participant = @IDNum;";
                param = new SqlParameter("@IDNum", id);
                cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add(param);
                dreader = cmd.ExecuteReader();
                if ((dreader.HasRows))
                {
                    sql = data.Name.Equals("Height") ?
                    "update Basic_Data set Height=@value where Participant = @UserID;" :
                    "update Basic_Data set Weight=@value where Participant = @UserID;" ;
                } else
                {
                    sql = data.Name.Equals("Height") ?
                    "insert into Basic_Data values (1,@UserID,CAST(GETDATE() as date),@value,null);":
                    "insert into Basic_Data values (1,@UserID,CAST(GETDATE() as date),null,@value);";
                }
                dreader.Close();
                cmd.Dispose();
                cmd = new SqlCommand(sql, conn);
                param = new SqlParameter("@value", data.Value);
                param2 = new SqlParameter("@UserID", id);
                cmd.Parameters.Add(param2);
                cmd.Parameters.Add(param);
                d.InsertCommand = cmd;
                d.InsertCommand.ExecuteNonQuery();
                cmd.Dispose();
                conn.Close();
                return data;
            } else if (data.Name.Equals("HeartRate")) {
                sql = "insert into Heart_Rate_Data values (1,@UserID,GETDATE(),@value);";
                cmd = new SqlCommand(sql, conn);
                param2 = new SqlParameter("@UserID", id);
                param = new SqlParameter("@value", data.Value);
                cmd.Parameters.Add(param2);
                cmd.Parameters.Add(param);
                d.InsertCommand = cmd;
                d.InsertCommand.ExecuteNonQuery();
                cmd.Dispose();
                conn.Close();
                return data;
            } else if (data.Name.Equals("CaloriesBurned"))
            {
                sql = "insert into Calorie_Data values (1,@UserID,CAST(GETDATE() as date),@value);";
                cmd = new SqlCommand(sql, conn);
                param2 = new SqlParameter("@UserID", id);
                param = new SqlParameter("@value", data.Value);
                cmd.Parameters.Add(param2);
                cmd.Parameters.Add(param);
                d.InsertCommand = cmd;
                d.InsertCommand.ExecuteNonQuery();
                cmd.Dispose();
                conn.Close();
                return data;
            } else
            {
                return null;
            }
            
        }
    }
}
