using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace DigitalLibrary.Pages.Account.Admin.Books
{
    public class IndexModel : PageModel
    {
        private readonly IBookRepository _repository;

        public IndexModel(IBookRepository repository)
        {
            _repository = repository;
        }
        public List<BookDto> BookDto { get; set; }
        public async Task<IActionResult> OnGet()
        {
            BookDto = await _repository.GetAllAsync();
            return Page();
        }
    }
}
