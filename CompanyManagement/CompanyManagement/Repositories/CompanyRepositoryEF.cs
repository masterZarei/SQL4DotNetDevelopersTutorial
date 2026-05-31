using CompanyManagement.Data;
using CompanyManagement.Models;
using Microsoft.EntityFrameworkCore;

namespace CompanyManagement.Repositories
{
    public class CompanyRepositoryEF : ICompanyRepository
    {
        private readonly AppDbContext _context;

        public CompanyRepositoryEF(AppDbContext context)
        {
            _context = context;
        }
        public async Task<Company> Add(Company company)
        {
            await _context.AddAsync(company);
            await _context.SaveChangesAsync();
            return company;
        }

        public async Task<Company> Find(int id)
        {
            return await _context.Companies.FindAsync(id);
        }

        public async Task<List<Company>> GetAll()
        {
            return await _context.Companies.ToListAsync();
        }

        public async Task Remove(int id)
        {
            var company = Find(id);
            if (company is not null)
            {
                _context.Remove(company);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<Company> Update(Company company)
        {
            _context.Update(company);
            await _context.SaveChangesAsync();
            return company;
        }
    }
}
