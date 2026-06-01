using CompanyManagement.Models;
using CompanyManagement.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CompanyManagement.Pages.Admin.CompanyPages;

public class DeleteModel : PageModel
{
    private readonly ICompanyRepository _repo;

    public DeleteModel(ICompanyRepository repo)
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
        else
        {
            Company = company;
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
