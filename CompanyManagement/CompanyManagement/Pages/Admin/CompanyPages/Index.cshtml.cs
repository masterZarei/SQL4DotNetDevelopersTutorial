using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using CompanyManagement.Models;
using CompanyManagement.Data;

namespace CompanyManagement.Pages.Admin.CompanyPages;

public class IndexModel : PageModel
{
    private readonly AppDbContext _context;

    public IndexModel(AppDbContext context)
    {
        _context = context;
    }

    public IList<Company> Company { get; set; } = default!;

    public async Task OnGetAsync()
    {
        Company = await _context.Companies.ToListAsync();
    }
}
