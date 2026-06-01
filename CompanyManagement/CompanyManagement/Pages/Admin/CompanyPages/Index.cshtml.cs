using CompanyManagement.Models;
using CompanyManagement.Repositories;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CompanyManagement.Pages.Admin.CompanyPages;

public class IndexModel : PageModel
{
    private readonly ICompanyRepository _repo;

    public IndexModel(ICompanyRepository repo)
    {
        _repo = repo;
    }

    public IList<Company> Company { get; set; } = default!;

    public async Task OnGetAsync()
    {
        Company = await _repo.GetAll();
    }
}
