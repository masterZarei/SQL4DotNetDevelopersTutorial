using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace DigitalLibrary.Pages.Account.Admin.Users
{
    public class DetailsModel : PageModel
    {
        private readonly IUserRepository _repository;

        public DetailsModel(IUserRepository repository)
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
            UserDto = new()
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

            UserDto.UserRoles = new SelectList
            (

                new[]
                {
                        new {Id = 1, Title="ادمین"},
                        new {Id = 2, Title="کاربر"},
                }
                , "Id", "Title", UserDto.RoleId
            );
        }
    }
}
