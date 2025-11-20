using System.ComponentModel.DataAnnotations;

namespace DigitalLibrary.Models;

public class RegisterDto
{
    public string FullName { get; set; }

    [DataType(DataType.Password)]
    public string Password { get; set; }

    [DataType(DataType.Password)]
    [Compare("Password", ErrorMessage = "رمز عبور و تأیید رمز عبور مطابقت ندارند.")]
    public string ConfirmPassword { get; set; }
    public string PhoneNumber { get; set; }
}
