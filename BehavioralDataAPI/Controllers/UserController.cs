using BehavioralDataAPI.BLs;
using Microsoft.AspNetCore.Mvc;
using BehavioralDataAPI.Models;

namespace BehavioralDataAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private UserBL userBL;
        

        public UserController() 
        { 
            userBL = new UserBL();
        }
        
        [HttpGet]
        public ActionResult<IEnumerable<User>> GetAllUsers() //TODO update return types, error handling
        {
            //once there's a functional access layer, these will be async
            //structure should match GetUser but have a try/catch around it
            try
            {
                var result = userBL.GetAllUsers();
                

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

        [HttpGet("id/{id}")]
        public ActionResult<User> GetUser(long id) 
        {
            try
            {
                var result = userBL.GetUser(id);

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

        [HttpGet("email/{email}")]
        public ActionResult<User> GetUserByEmail(string email)
        {
            //todo 
            try
            {
                var result = userBL.GetUserByEmail(email);

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

        [HttpPost("id/{id}")]
        public ActionResult CreateUser(long id, User user)
        {
            try
            {
                var result = userBL.CreateUser(id, user);
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
