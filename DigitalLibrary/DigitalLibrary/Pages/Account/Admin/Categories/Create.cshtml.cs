using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace DigitalLibrary.Pages.Account.Admin.Categories
{
    public class CreateModel : PageModel
    {
        private readonly ICategoryRepository _repository;

        public CreateModel(ICategoryRepository repository)
        {
            _repository = repository;
        }
        [BindProperty]
        public CategoryDto CategoryDTO { get; set; }
        public void OnGet()
        {
        }
        public async Task<IActionResult> OnPostAsync()
        {
            if (ModelState.IsValid == false)
            {
                return Page();
            }
            await _repository.AddAsync(CategoryDTO);

            return RedirectToPage("./Index");
        }
    }
}
