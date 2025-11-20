using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Security.Claims;

namespace DigitalLibrary.Pages
{
    public class BookDetailsModel : PageModel
    {
        private readonly IBookRepository _repository;
        private readonly IUserRepository _userRepository;
        private readonly IDownloadedBooksRepository _downloadedBooksRepository;

        public BookDetailsModel(IBookRepository repository, IUserRepository userRepository, IDownloadedBooksRepository downloadedBooksRepository)
        {
            _repository = repository;
            _userRepository = userRepository;
            _downloadedBooksRepository = downloadedBooksRepository;
        }
        [BindProperty]
        public BookDto BookDto { get; set; }
        public async Task<IActionResult> OnGet(int Id)
        {
            if (Id <= 0)
            {
                return RedirectToPage("/Index");
            }
            BookDto = await _repository.GetByIdAsync(Id);
            if (BookDto is null)
            {
                return RedirectToPage("/Index");
            }
            return Page();
        }
        public async Task<IActionResult> OnPost()
        {
            if (User.Identity.IsAuthenticated == false)
            {
                return LocalRedirect("/Account/Login");
            }
            int userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier));

            var user = await _userRepository.GetByIdAsync(userId);

            if (user is null)
            {
                return RedirectToPage("/Index");
            }
            var check = await _downloadedBooksRepository.GetByUserIdAndBookIdAsync(userId, BookDto.Id);
            if (check is null)
            {
                await _downloadedBooksRepository.AddAsync(new DownloadedBookDto
                {
                    BookId = BookDto.Id,
                    UserId = userId
                });
            }

            return LocalRedirect($"/Assets/Files/{BookDto.FileUrl}");
        }
    }
}
