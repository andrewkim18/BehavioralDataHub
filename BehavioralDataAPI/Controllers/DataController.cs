using BehavioralDataAPI.BLs;
using BehavioralDataAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace BehavioralDataAPI.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class DataController : ControllerBase
    {
        private DataBL dataBL;

        public DataController()
        {
            dataBL = new DataBL();
        }

        [HttpGet("/user/data/{id}/{name}")]
        public ActionResult<DataPoint> GetUserAttribute(long id, string name)
        {
            try
            {
                var result = dataBL.GetUserAttribute(id, name);

                if (result == null)
                {
                    return NotFound();
                }

                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [HttpPost("/user/data/{id}")]
        public ActionResult PutUserAttribute(long id, DataPoint data)
        {
            try
            {
               
                var result = dataBL.PutUserAttribute(id,data);
                //note result here should return the data point
                //var result = Ok();

                if (result == null)
                {
                    return NotFound();
                }

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [HttpGet("/user/data/{id}")]
        public ActionResult<IEnumerable<DataPoint>> GetUserData(long id)
        {
            try
            {
                var result = dataBL.GetUserData(id);
                

                if (result == null)
                {
                    return NotFound();
                }

                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
    }
}

