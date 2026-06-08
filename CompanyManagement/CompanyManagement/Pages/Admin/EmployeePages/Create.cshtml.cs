using CompanyManagement.Models;
using CompanyManagement.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace CompanyManagement.Pages.Admin.EmployeePages;

public class CreateModel : PageModel
{
    private readonly IEmployeeRepository _repo;
    private readonly ICompanyRepository _companyRepository;

    public CreateModel(IEmployeeRepository repo, ICompanyRepository companyRepository)
    {
        _repo = repo;
        _companyRepository = companyRepository;
    }
    private async Task InitList()
    {
        var companies = await _companyRepository.GetAll();
        CompanyList = companies.Select(i => new SelectListItem
        {
            Text = i.Name,
            Value = i.Id.ToString()
        });
    } 
    public async Task<IActionResult> OnGet()
    {
        await InitList();
        return Page();
    }

    [BindProperty]
    public Employee Employee { get; set; } = default!;
    public IEnumerable<SelectListItem> CompanyList { get; set; }

    // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD.
    public async Task<IActionResult> OnPostAsync()
    {
        if (!ModelState.IsValid)
        {
            await InitList();
            return Page();
        }

        await _repo.Add(Employee);

        return RedirectToPage("./Index");
    }
}
