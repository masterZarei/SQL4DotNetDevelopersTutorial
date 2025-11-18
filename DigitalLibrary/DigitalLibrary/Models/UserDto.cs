namespace DigitalLibrary.Models
{
    public class UserDto
    {
        public int Id { get; set; }
        public string FullName { get; set; }
        public string Password { get; set; }
        public string PhoneNumber { get; set; }
        public int? RoleId { get; set; }
    }
}
