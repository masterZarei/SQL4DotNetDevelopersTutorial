using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace DigitalLibrary.Pages.Account.Admin.Books
{
    public class DetailsModel : PageModel
    {
        private readonly IBookRepository _repository;
        private readonly ICategoryRepository _categoryRepository;

        public DetailsModel(IBookRepository repository, ICategoryRepository categoryRepository)
        {
            _repository = repository;
            _categoryRepository = categoryRepository;
        }
        [BindProperty]
        public BookCrudDto BookDto { get; set; }
        public async Task<IActionResult> OnGet(int Id)
        {
            if (Id <= 0)
            {
                return RedirectToPage("./Index");
            }
            var Book = await _repository.GetByIdAsync(Id);
            if (Book is null)
            {
                return RedirectToPage("./Index");
            }
            BookDto = new BookCrudDto
            {
                Id = Id,
                FileUrl = Book.FileUrl,
                ImageUrl = Book.ImageUrl,
                Author = Book.Author,
                Description = Book.Description,
                CategoryId = Book.CategoryId,
                Title = Book.Title,
            };
            await InitList();
            return Page();
        }

        public async Task InitList()
        {
            var categories = await _categoryRepository.GetAllAsync();
            if (categories is not null && categories.Count > 0)
                BookDto.BookCategories = new SelectList(categories, nameof(CategoryDto.Id), nameof(CategoryDto.Title), BookDto.CategoryId);



        }
    }
}
