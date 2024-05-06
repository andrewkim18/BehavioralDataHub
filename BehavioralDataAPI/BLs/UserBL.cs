using BehavioralDataAPI.DALs;
using BehavioralDataAPI.Models;

namespace BehavioralDataAPI.BLs
{
    public class UserBL
    {

        private UserDAL userDAL;

        public UserBL() 
        { 
            userDAL = new UserDAL();
        }

        public  List<User> GetAllUsers()
        {
            List<User> users = userDAL.GetAllUsers();
            return users;
        }

        public User GetUser(long id)
        {
            return userDAL.GetUser(id);
        }

        public User GetUserByEmail(string email)
        {
            return userDAL.GetUserByEmail(email);
        }

        public User CreateUser(long id, User user)
        {
            return userDAL.CreateUser(id, user);
        }
    }
}
