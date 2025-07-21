namespace SqlForDevelopers.Models;
public class User
{
    public int UserId { get; set; }
    public string Username { get; set; }

    public UserProfile Profile { get; set; }  // Navigation property یک به یک
    public ICollection<Post> Posts { get; set; }  // رابطه یک به چند با Post
}
