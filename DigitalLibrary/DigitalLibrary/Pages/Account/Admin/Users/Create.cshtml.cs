using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using DigitalLibrary.Utitlities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace DigitalLibrary.Pages.Account.Admin.Users
{
    public class CreateModel : PageModel
    {
        private readonly IUserRepository _repository;

        public CreateModel(IUserRepository repository)
        {
            _repository = repository;
        }
        [BindProperty]
        public UserCrudDto UserDto { get; set; }
        public async Task<IActionResult> OnGet()
        {
            InitList();
            return Page();
        }
        public void InitList()
        {
            UserDto = new()
            {
                UserRoles = new SelectList
                (

                    new[]
                    {
                        new {Id = 1, Title="ادمین"},
                        new {Id = 2, Title="کاربر"},
                    }
                    , "Id", "Title"
                )
            };
        }
        public async Task<IActionResult> OnPost()
        {
            if (ModelState.IsValid == false)
            {
                InitList();
                return Page();
            }
            await _repository.AddAsync(new UserDto
            {
                FullName = UserDto.FullName,
                Password = Md5Hasher.Hash(UserDto.Password),
                PhoneNumber = UserDto.PhoneNumber,
                RoleId = Convert.ToInt32(UserDto.SelectedRole),
            });

            return RedirectToPage("./Index");
        }
    }
}
