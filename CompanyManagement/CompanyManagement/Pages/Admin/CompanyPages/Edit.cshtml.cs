using CompanyManagement.Models;
using CompanyManagement.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CompanyManagement.Pages.Admin.CompanyPages;

public class EditModel : PageModel
{
    private readonly ICompanyRepository _repo;

    public EditModel(ICompanyRepository repo)
    {
        _repo = repo;
    }

    [BindProperty]
    public Company Company { get; set; } = default!;

    public async Task<IActionResult> OnGetAsync(int? id)
    {
        if (id is null)
        {
            return NotFound();
        }

        var company = await _repo.Find(id.GetValueOrDefault());
        if (company is null)
        {
            return NotFound();
        }
        Company = company;
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

        await _repo.Update(Company);

        return RedirectToPage("./Index");
    }
}
