using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace DigitalLibrary.Pages.Account.Admin.Books
{
    public class DeleteModel : PageModel
    {
        private readonly IBookRepository _repository;

        public DeleteModel(IBookRepository repository)
        {
            _repository = repository;
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
        public async Task<IActionResult> OnPost(int Id)
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
            await _repository.SoftDeleteAsync(Id);
            return RedirectToPage("./Index");
        }
    }
}
