using Microsoft.AspNetCore.Mvc.Rendering;

namespace DigitalLibrary.Models;

public class UserCrudDto : UserDto
{
    public string? SelectedRole { get; set; }
    public SelectList? UserRoles { get; set; }
}