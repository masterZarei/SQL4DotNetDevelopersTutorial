using CompanyManagement.Models;
using CompanyManagement.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CompanyManagement.Pages.Admin.EmployeePages;

public class CreateModel : PageModel
{
    private readonly IEmployeeRepository _repo;

    public CreateModel(IEmployeeRepository repo)
    {
        _repo = repo;
    }

    public IActionResult OnGet()
    {
        return Page();
    }

    [BindProperty]
    public Employee Employee { get; set; } = default!;

    // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD.
    public async Task<IActionResult> OnPostAsync()
    {
        if (!ModelState.IsValid)
        {
            return Page();
        }

        await _repo.Add(Employee);

        return RedirectToPage("./Index");
    }
}
