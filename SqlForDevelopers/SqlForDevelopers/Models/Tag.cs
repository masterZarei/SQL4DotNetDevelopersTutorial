namespace SqlForDevelopers.Models;
// رابطه چند به چند: Post و Tag با جدول واسط PostTag
public class Tag
{
    public int TagId { get; set; }
    public string Name { get; set; }

    public ICollection<PostTag> PostTags { get; set; }
}