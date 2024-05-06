using Microsoft.EntityFrameworkCore;

namespace BehavioralDataAPI.Models.Context
{
    public class UserContext : DbContext
    {
        public UserContext(DbContextOptions<UserContext> options) : base(options)
        { 
        }

        public DbSet<User> Users { get; set; } = null!;
        public DbSet<DataPoint> UserData { get; set; } = null!;
    }
}
