using CompanyManagement.Models;
using CompanyManagement.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace CompanyManagement.Pages.Admin.EmployeePages;

public class EditModel : PageModel
{
    private readonly IEmployeeRepository _repo;
    private readonly ICompanyRepository _companyRepository;

    public EditModel(IEmployeeRepository repo, ICompanyRepository companyRepository)
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
    [BindProperty]
    public Employee Employee { get; set; } = default!;
    public IEnumerable<SelectListItem> CompanyList { get; set; }

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
        await InitList();
        Employee = employee;
        return Page();
    }

    // To protect from overposting attacks, enable the specific properties you want to bind to.
    // For more details, see https://aka.ms/RazorPagesCRUD.
    public async Task<IActionResult> OnPostAsync()
    {
        if (!ModelState.IsValid)
        {
            await InitList();
            return Page();
        }

        await _repo.Update(Employee);

        return RedirectToPage("./Index");
    }
}
