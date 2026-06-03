using CompanyManagement.Models;
using CompanyManagement.Repositories;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CompanyManagement.Pages.Admin.EmployeePages;

public class IndexModel : PageModel
{
    private readonly IEmployeeRepository _repo;

    public IndexModel(IEmployeeRepository repo)
    {
        _repo = repo;
    }

    public IList<Employee> Employee { get; set; } = default!;

    public async Task OnGetAsync()
    {
        Employee = await _repo.GetAll();
    }
}
