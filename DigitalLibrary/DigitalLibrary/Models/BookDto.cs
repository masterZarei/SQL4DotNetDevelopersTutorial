namespace DigitalLibrary.Models
{
    public class BookDto
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string? Description { get; set; }
        public string? Author { get; set; }
        public string? FileUrl { get; set; }
        public string? ImageUrl { get; set; }
        public int? CategoryId { get; set; }
        public bool IsDeleted { get; set; }
        public string? CategoryTitle { get; set; }
    }
}
