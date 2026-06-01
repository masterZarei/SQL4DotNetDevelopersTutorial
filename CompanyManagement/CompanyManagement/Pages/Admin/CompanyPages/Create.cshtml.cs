using CompanyManagement.Models;
using CompanyManagement.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CompanyManagement.Pages.Admin.CompanyPages;

public class CreateModel : PageModel
{
    private readonly ICompanyRepository _repo;

    public CreateModel(ICompanyRepository repo)
    {
        _repo = repo;
    }

    public IActionResult OnGet()
    {
        return Page();
    }

    [BindProperty]
    public Company Company { get; set; } = default!;

    // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD.
    public async Task<IActionResult> OnPostAsync()
    {
        if (!ModelState.IsValid)
        {
            return Page();
        }

        await _repo.Add(Company);

        return RedirectToPage("./Index");
    }
}
