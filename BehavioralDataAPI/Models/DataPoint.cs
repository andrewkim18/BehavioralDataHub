using BehavioralDataAPI.Models.Enums;

namespace BehavioralDataAPI.Models
{
    public class DataPoint
    {
        public long UserId {  get; set; } 
        public string? Name { get; set; }
        public int? Value { get; set; }
        public string? CollectionDate { get; set; }
        public CollectionType CollectionType { get; set; } 
    }
}
