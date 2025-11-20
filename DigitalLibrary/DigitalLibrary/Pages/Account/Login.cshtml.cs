using DigitalLibrary.Data.Repositories;
using DigitalLibrary.Models;
using DigitalLibrary.Utitlities;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Security.Claims;

namespace DigitalLibrary.Pages.Account
{
    public class LoginModel : PageModel
    {
        private readonly IUserRepository _repository;

        public LoginModel(IUserRepository repository)
        {
            _repository = repository;
        }
        [BindProperty]
        public LoginDto LoginDto { get; set; }
        public void OnGet()
        {
        }
        public async Task<IActionResult> OnPost()
        {
            if (ModelState.IsValid == false)
            {
                return Page();
            }
            LoginDto.Password = Md5Hasher.Hash(LoginDto.Password);
            var result = await _repository.LoginUser(LoginDto);

            if (result is null)
            {
                ModelState.AddModelError("","نام کاربری یا رمز عبور شما اشتباه است");
                return Page();
            }

            var claims = new List<Claim>
            {
                new(ClaimTypes.NameIdentifier, result.Id.ToString()),
                new(ClaimTypes.Name, result.FullName),
                new(ClaimTypes.MobilePhone, result.PhoneNumber),
                new(ClaimTypes.Role, result.RoleId.ToString())
            };
            var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            var principal = new ClaimsPrincipal(identity);

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal,
                new AuthenticationProperties
                {
                    IsPersistent = true,
                });

            return RedirectToPage("/Index");
        }
    }
}
