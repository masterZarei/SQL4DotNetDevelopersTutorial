namespace SqlForDevelopers.Models;
// رابطه یک به چند: User و Post
public class Post
{
    public int PostId { get; set; }
    public string Title { get; set; }
    public string Content { get; set; }

    public int UserId { get; set; }
    public User User { get; set; }  // Navigation property یک به چند

    public ICollection<PostTag> PostTags { get; set; }  // رابطه چند به چند با Tag
}