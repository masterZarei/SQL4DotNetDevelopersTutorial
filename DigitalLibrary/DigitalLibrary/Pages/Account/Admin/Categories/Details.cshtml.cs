using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace DigitalLibrary.Pages.Account.Admin.Categories
{
    public class DetailsModel : PageModel
    {
        private readonly ICategoryRepository _repository;

        public DetailsModel(ICategoryRepository repository)
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
    }
}
