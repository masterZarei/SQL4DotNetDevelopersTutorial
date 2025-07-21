using Microsoft.AspNetCore.Mvc.RazorPages;
using SqlForDevelopers.Data;
using SqlForDevelopers.Models;

namespace SqlForDevelopers.Pages
{
    public class IndexModel : PageModel
    {
        private readonly AppDbContext _context;

        public IndexModel(AppDbContext context)
        {
            _context = context;
        }

        public void OnGet()
        {
            var posts = _context.Posts.ToList();
        }
    }
}
