using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace DigitalLibrary.Pages.Account.Admin.Books
{
    public class CreateModel : PageModel
    {
        private readonly IBookRepository _repository;
        private readonly ICategoryRepository _categoryRepository;

        public CreateModel(IBookRepository repository, ICategoryRepository categoryRepository)
        {
            _repository = repository;
            _categoryRepository = categoryRepository;
        }
        [BindProperty]
        public BookCrudDto BookDto { get; set; }

        public async Task<IActionResult> OnGet()
        {
            await InitList();
            return Page();
        }
        public async Task InitList()
        {
            var categories = await _categoryRepository.GetAllAsync();
            if (categories is not null && categories.Count > 0)
            {
                BookDto = new()
                {
                    BookCategories = new SelectList(categories, nameof(CategoryDto.Id), nameof(CategoryDto.Title))
                };
            }
        }
        public async Task<IActionResult> OnPost()
        {
            if(ModelState.IsValid == false)
            {
                await InitList();
                return Page();
            }
            if (BookDto.ImageUp is not null)
            {
                string saveDir = "wwwroot/Assets/Pictures";
                if (!Directory.Exists(saveDir))
                    Directory.CreateDirectory(saveDir);

                BookDto.ImageUrl = Guid.NewGuid().ToString() + Path.GetExtension(BookDto.ImageUp.FileName);
                string savepath = Path.Combine(Directory.GetCurrentDirectory(), saveDir, BookDto.ImageUrl);
                using var filestream = new FileStream(savepath, FileMode.Create);
                BookDto.ImageUp.CopyTo(filestream);
            }
            if (BookDto.FileUp is not null)
            {
                string saveDir = "wwwroot/Assets/Files";
                if (!Directory.Exists(saveDir))
                    Directory.CreateDirectory(saveDir);

                BookDto.FileUrl = Guid.NewGuid().ToString() + Path.GetExtension(BookDto.FileUp.FileName);
                string savepath = Path.Combine(Directory.GetCurrentDirectory(), saveDir, BookDto.FileUrl);
                using var filestream = new FileStream(savepath, FileMode.Create);
                BookDto.FileUp.CopyTo(filestream);
            }

            await _repository.AddAsync(new Models.BookDto
            {
                FileUrl = BookDto.FileUrl,
                ImageUrl = BookDto.ImageUrl,
                Author = BookDto.Author,
                Description = BookDto.Description,
                CategoryId = Convert.ToInt32(BookDto.SelectedCategory),
                Title = BookDto.Title
            });

            return RedirectToPage("./Index");
        }
    }
}
