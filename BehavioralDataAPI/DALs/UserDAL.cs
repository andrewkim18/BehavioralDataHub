using System;
using System.Data.SqlClient;
using System.Collections;
using BehavioralDataAPI.Models;
using BehavioralDataAPI.Models.Context;
using Microsoft.CodeAnalysis.Elfie.Diagnostics;
using static System.Runtime.InteropServices.JavaScript.JSType;


namespace BehavioralDataAPI.DALs
{
    public class UserDAL
    {
        SqlConnection conn;
        public UserDAL() {
            string constr = @"Initial Catalog=healthDataHub;Integrated Security=True;Connect Timeout=30;Encrypt=False;";
            conn = new SqlConnection(constr);
        }
        public List<User> GetAllUsers()
        {
            if (conn.State != System.Data.ConnectionState.Open)
            {
                conn.Close();
                conn.Open();
            }

            SqlCommand cmd;
            SqlDataReader dreader;
            string sql = "select * from Users;";
            cmd = new SqlCommand(sql, conn);
            dreader = cmd.ExecuteReader();
            List<User> ret = new List<User>();
            while (dreader.Read())
            {
                ret.Add(new User()
                {
                    Id = (long)dreader.GetValue(0),
                    Name = (string)dreader.GetValue(1),
                    Username = (string)dreader.GetValue(2),
                    Email = (string)dreader.GetValue(3),
                    Password = (string)dreader.GetValue(4)
                });
            }
            //TODO sql queries that return list of all users
            dreader.Close();
            cmd.Dispose();
            conn.Close();
            return ret;
        }

        public User GetUser(long id) 
        {
            if (conn.State != System.Data.ConnectionState.Open)
            {
                conn.Close();
                conn.Open();
            }

            SqlCommand cmd;
            SqlDataReader dreader;
            string sql = "select * from Users where UserID = @IDNum;";
            SqlParameter param = new SqlParameter("@IDNum", id);
            cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(param);
            dreader = cmd.ExecuteReader();
            dreader.Read();
            if (!(dreader.HasRows)) 
            {
                return null;
            }
            User ret =new User()
            {
                Id = (long)dreader.GetValue(0),
                Name = (string)dreader.GetValue(1),
                Username = (string)dreader.GetValue(2),
                Email = (string)dreader.GetValue(3),
                Password = (string)dreader.GetValue(4)
            };
            //TODO sql queries that retu users
            dreader.Close();
            cmd.Dispose();
            conn.Close();
            return ret;
        }
        public User GetUserByEmail(string email)
        {
            if (conn.State != System.Data.ConnectionState.Open)
            {
                conn.Close();
                conn.Open();
            }

            SqlCommand cmd;
            SqlDataReader dreader;
            string sql = "select * from Users where Email = @Email;";
            SqlParameter param = new SqlParameter("@Email", email);
            cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(param);
            dreader = cmd.ExecuteReader();
            dreader.Read();
            if (!(dreader.HasRows))
            {
                return null;
            }
            User ret = new User()
            {
                Id = (long)dreader.GetValue(0),
                Name = (string)dreader.GetValue(1),
                Username = (string)dreader.GetValue(2),
                Email = (string)dreader.GetValue(3),
                Password = (string)dreader.GetValue(4)
            };
            //TODO sql queries that retu users
            dreader.Close();
            cmd.Dispose();
            conn.Close();
            return ret;
        }

        public User CreateUser(long id, User user)
        {
            if (conn.State != System.Data.ConnectionState.Open)
            {
                conn.Close();
                conn.Open();
            }
            SqlCommand cmd;
            SqlParameter param;
            SqlDataAdapter d = new SqlDataAdapter();
            string sql = "insert into Users values (@UserID,@Name,@Username,@Email,@Password,0);";
            cmd = new SqlCommand(sql, conn);
            param = new SqlParameter("@UserID", id);
            cmd.Parameters.Add(param);
            param = new SqlParameter("@Name", user.Name);
            cmd.Parameters.Add(param);
            param = new SqlParameter("@Username", user.Username);
            cmd.Parameters.Add(param);
            param = new SqlParameter("@Email", user.Email);
            cmd.Parameters.Add(param);
            param = new SqlParameter("@Password", user.Password);
            cmd.Parameters.Add(param);
            d.InsertCommand = cmd;
            d.InsertCommand.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
            return user;
        }
    }
}