using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace DigitalLibrary.Pages.Account.Admin.Categories
{
    public class DeleteModel : PageModel
    {
        private readonly ICategoryRepository _repository;

        public DeleteModel(ICategoryRepository repository)
        {
            _repository = repository;
        }
        [BindProperty]
        public CategoryDto CategoryDTO { get; set; }
        public async Task<IActionResult> OnGet(int Id)
        {
            if (Id <= 0)
            {
                return RedirectToPage("./Index");
            }
            CategoryDTO = await _repository.GetByIdAsync(Id);
            if (CategoryDTO is null)
            {
                return RedirectToPage("./Index");
            }
            return Page();
        }
        public async Task<IActionResult> OnPostAsync(int Id)
        {
            if (Id <= 0)
            {
                ModelState.AddModelError("","آیدی نامعتبر است");
                return Page();
            }
            var category = await _repository.GetByIdAsync(Id);

            if (category is null)
            {
                return RedirectToPage("./Index");
            }

            var result = await _repository.DeleteAsync(Id);

            return RedirectToPage("./Index");
        }
    }
}
