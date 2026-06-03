using CompanyManagement.Models;
using CompanyManagement.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CompanyManagement.Pages.Admin.EmployeePages;

public class DeleteModel : PageModel
{
    private readonly IEmployeeRepository _repo;

    public DeleteModel(IEmployeeRepository repo)
    {
        _repo = repo;
    }

    [BindProperty]
    public Employee Employee { get; set; } = default!;

    public async Task<IActionResult> OnGetAsync(int? id)
    {
        if (id is null)
        {
            return NotFound();
        }

        var employee = await _repo.Find(id.GetValueOrDefault());
        if (employee is null)
        {
            return NotFound();
        }
        else
        {
            Employee = employee;
        }

        return Page();
    }

    public async Task<IActionResult> OnPostAsync(int? id)
    {
        if (id is null)
        {
            return NotFound();
        }

        await _repo.Remove(id.GetValueOrDefault());

        return RedirectToPage("./Index");
    }
}
