using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using DigitalLibrary.Utitlities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace DigitalLibrary.Pages.Account.Admin.Users
{
    public class EditModel : PageModel
    {
        private readonly IUserRepository _repository;

        public EditModel(IUserRepository repository)
        {
            _repository = repository;
        }
        [BindProperty]
        public UserCrudDto UserDto { get; set; }
        public async Task<IActionResult> OnGet(int Id)
        {
            if (Id <= 0)
            {
                return RedirectToPage("./Index");
            }
            var user = await _repository.GetByIdAsync(Id);
            if (user is null)
            {
                return RedirectToPage("./Index");
            }
            UserDto = new UserCrudDto()
            {
                Id = Id,
                FullName = user.FullName,
                PhoneNumber = user.PhoneNumber,
                RoleId = user.RoleId,
            };
            InitList();
            return Page();
        }
        public void InitList()
        {

            UserDto.UserRoles = new SelectList(
                new[]
                {
                    new { Id = 1, Title = "Admin" },
                    new { Id = 2, Title = "User" }
                },
                "Id",
                "Title",
                UserDto.RoleId
            );
        }
        public async Task<IActionResult> OnPost()
        {
            if (ModelState.IsValid == false)
            {
                InitList();
                return Page();
            }
            await _repository.UpdateAsync(new UserDto
            {
                Id = UserDto.Id,
                FullName = UserDto.FullName,
                PhoneNumber = UserDto.PhoneNumber,
                RoleId = Convert.ToInt32(UserDto.SelectedRole),
            });

            return RedirectToPage("./Index");
        }
    }
}
