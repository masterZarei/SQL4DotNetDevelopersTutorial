using Microsoft.AspNetCore.Mvc.Rendering;

namespace DigitalLibrary.Models;

public class BookCrudDto : BookDto
{
    public IFormFile? ImageUp { get; set; }
    public IFormFile? FileUp { get; set; }

    public string? SelectedCategory { get; set; }
    public SelectList? BookCategories { get; set; }
}
