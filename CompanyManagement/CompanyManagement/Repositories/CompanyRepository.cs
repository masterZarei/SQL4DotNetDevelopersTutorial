using CompanyManagement.Data;
using CompanyManagement.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace CompanyManagement.Repositories
{
    public class CompanyRepository : ICompanyRepository
    {
      
        private IDbConnection _db;
        public CompanyRepository(IConfiguration configuration)
        {
            _db = new SqlConnection(configuration.GetConnectionString("ComapnyConnection"));
        }
        public async Task<Company> Add(Company company)
        {
            throw new NotImplementedException();
        }

        public async Task<Company> Find(int id)
        {
            throw new NotImplementedException();

        }

        public async Task<List<Company>> GetAll()
        {
            throw new NotImplementedException();

        }

        public async Task Remove(int id)
        {
            throw new NotImplementedException();

        }

        public async Task<Company> Update(Company company)
        {
            throw new NotImplementedException();

        }
    }
}
