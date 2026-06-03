using CompanyManagement.Models;
using CompanyManagement.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CompanyManagement.Pages.Admin.EmployeePages;

public class EditModel : PageModel
{
    private readonly IEmployeeRepository _repo;

    public EditModel(IEmployeeRepository repo)
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
        Employee = employee;
        return Page();
    }

    // To protect from overposting attacks, enable the specific properties you want to bind to.
    // For more details, see https://aka.ms/RazorPagesCRUD.
    public async Task<IActionResult> OnPostAsync()
    {
        if (!ModelState.IsValid)
        {
            return Page();
        }

        await _repo.Update(Employee);

        return RedirectToPage("./Index");
    }
}
