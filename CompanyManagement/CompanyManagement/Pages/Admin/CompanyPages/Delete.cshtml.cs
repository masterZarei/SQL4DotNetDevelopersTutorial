using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using CompanyManagement.Models;
using CompanyManagement.Data;

namespace CompanyManagement.Pages.Admin.CompanyPages;

public class DeleteModel : PageModel
{
    private readonly AppDbContext _context;

    public DeleteModel(AppDbContext context)
    {
        _context = context;
    }

    [BindProperty]
    public Company Company { get; set; } = default!;

    public async Task<IActionResult> OnGetAsync(int? id)
    {
        if (id is null)
        {
            return NotFound();
        }

        var company = await _context.Companies.FirstOrDefaultAsync(m => m.Id == id);
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

        var company = await _context.Companies.FindAsync(id);
        if (company != null)
        {
            Company = company;
            _context.Companies.Remove(Company);
            await _context.SaveChangesAsync();
        }

        return RedirectToPage("./Index");
    }
}
