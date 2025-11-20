using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace DigitalLibrary.Pages.Account.Admin.Users
{
    public class IndexModel : PageModel
    {
        private readonly IUserRepository _repository;

        public IndexModel(IUserRepository repository)
        {
            _repository = repository;
        }
        public List<UserDto> UserDto { get; set; }
        public async Task<IActionResult> OnGet()
        {
            UserDto = await _repository.GetAllAsync();
            return Page();
        }
    }
}
