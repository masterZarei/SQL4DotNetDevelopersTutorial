using CompanyManagement.Models;
using CompanyManagement.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CompanyManagement.Pages.Admin.CompanyPages;

public class DetailsModel : PageModel
{
    private readonly ICompanyRepository _repo;

    public DetailsModel(ICompanyRepository repo)
    {
        _repo = repo;
    }

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
}
