using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace DigitalLibrary.Pages.Account.Admin.Categories
{
    public class IndexModel : PageModel
    {
        private readonly ICategoryRepository _repository;

        public IndexModel(ICategoryRepository repository)
        {
            _repository = repository;
        }
        public List<CategoryDto> CategoryDTO { get; set; }
        public async Task<IActionResult> OnGet()
        {
            CategoryDTO = await _repository.GetAllAsync();
            return Page();
        }
    }
}
