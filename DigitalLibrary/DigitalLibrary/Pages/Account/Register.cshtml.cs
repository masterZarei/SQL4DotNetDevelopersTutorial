using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using DigitalLibrary.Utitlities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace DigitalLibrary.Pages.Account
{
    public class RegisterModel : PageModel
    {
        private readonly IUserRepository _repository;

        public RegisterModel(IUserRepository repository)
        {
            _repository = repository;
        }
        [BindProperty]
        public RegisterDto RegisterDto { get; set; }
        public void OnGet()
        {
        }
        public async Task<IActionResult> OnPost()
        {
            if (ModelState.IsValid == false)
            {
                return Page();
            }
            var result = await _repository.AddAsync(new UserDto
            {
                FullName = RegisterDto.FullName,
                Password = Md5Hasher.Hash(RegisterDto.Password),
                PhoneNumber = RegisterDto.PhoneNumber,
                RoleId = SD.UserEndUser
            });
            if (result == 0)
            {
                ModelState.AddModelError("", "کاربری با این شماره همراه در وب سایت موجود است");
                return Page();
            }

            return RedirectToPage("./Login");
        }
    }
}
