using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Security.Claims;

namespace DigitalLibrary.Pages.Account
{
    [Authorize]
    public class MyLibraryModel : PageModel
    {
        private readonly IDownloadedBooksRepository _repository;

        public MyLibraryModel(IDownloadedBooksRepository repository)
        {
            _repository = repository;
        }
        public List<BookDto> BookDto { get; set; }
        public async Task<IActionResult> OnGet()
        {
            int userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier));
            BookDto = await _repository.GetAllAsync(userId);
            return Page();
        }
    }
}
