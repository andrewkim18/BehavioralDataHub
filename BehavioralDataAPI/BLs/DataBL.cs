using BehavioralDataAPI.DALs;
using BehavioralDataAPI.Models;

namespace BehavioralDataAPI.BLs
{
    public class DataBL
    {
        private DataDAL dataDAL;

        public DataBL()
        {
            dataDAL = new DataDAL();
        }

        public IEnumerable<DataPoint> GetUserData(long id)
        {
            List<DataPoint> res = dataDAL.GetUserData(id);

            return res;
        }

        public DataPoint GetUserAttribute(long id, string name)
        {
            DataPoint res = dataDAL.GetUserAttribute(id, name);

            return res;
        }

        public DataPoint PutUserAttribute(long id, DataPoint data)
        {
            //when we get to doing security stuff check authorization
            DataPoint res = dataDAL.PutUserAttribute(id, data);

            return res;
        }
    }
}
