using System.ComponentModel.DataAnnotations;

namespace DigitalLibrary.Models;

public class RegisterDto
{
    public string FullName { get; set; }

    [DataType(DataType.Password)]
    public string Password { get; set; }

    [DataType(DataType.Password)]
    [Compare(nameof(Password), ErrorMessage = "رمز عبور و تایید رمز عبور باهمدیگر همخوانی ندارند.")]
    public string ConfirmPassword { get; set; }

    public string PhoneNumber { get; set; }
}
