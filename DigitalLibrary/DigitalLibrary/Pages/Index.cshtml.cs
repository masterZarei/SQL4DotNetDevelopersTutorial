using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace DigitalLibrary.Pages
{
    public class IndexModel : PageModel
    {
        private readonly IBookRepository _bookRepository;

        public IndexModel(IBookRepository bookRepository)
        {
            _bookRepository = bookRepository;
        }
        public List<BookDto> BookDto { get; set; }
        public async Task<IActionResult> OnGet()
        {
            //YAGNI => You Ain't Gonna Need It
            BookDto = await _bookRepository.GetAllAsync();

            return Page();
        }
    }
}
