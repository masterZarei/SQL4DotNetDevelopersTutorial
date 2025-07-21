namespace SqlForDevelopers.Models;
public class UserProfile
{
    public int UserProfileId { get; set; }
    public string Bio { get; set; }

    public int UserId { get; set; }
    public User User { get; set; }  // Navigation property یک به یک
}