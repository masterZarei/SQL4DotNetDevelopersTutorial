using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace DigitalLibrary.Pages.Account.Admin.Books
{
    public class DeleteModel : PageModel
    {
        private readonly IBookRepository _repository;

        public DeleteModel(IBookRepository bookRepository)
        {
            _repository = bookRepository;
        }
        [BindProperty]
        public BookDto BookDto { get; set; }
        public async Task<IActionResult> OnGet(int Id)
        {
            if (Id <= 0)
            {
                return RedirectToPage("./Index");
            }
            BookDto = await _repository.GetByIdAsync(Id);
            if (BookDto is null)
            {
                return RedirectToPage("./Index");
            }
            return Page();
        }
        public async Task<IActionResult> OnPostAsync(int Id)
        {
            if (Id <= 0)
            {
                ModelState.AddModelError("", "آیدی نامعتبر است");
                return Page();
            }
            var category = await _repository.GetByIdAsync(Id);

            if (category is null)
            {
                return RedirectToPage("./Index");
            }

            var result = await _repository.SoftDeleteAsync(Id);

            return RedirectToPage("./Index");
        }
    }
}
