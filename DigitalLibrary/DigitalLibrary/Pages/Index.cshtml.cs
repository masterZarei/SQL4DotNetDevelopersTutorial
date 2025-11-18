using DigitalLibrary.Data.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Threading.Tasks;

namespace DigitalLibrary.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        private readonly IBookRepository bookRepository;

        public IndexModel(ILogger<IndexModel> logger, IBookRepository bookRepository)
        {
            _logger = logger;
            this.bookRepository = bookRepository;
        }

        public async Task<IActionResult> OnGet()
        {
            var list = await bookRepository.GetAllAsync();

            return Page();
        }
    }
}
