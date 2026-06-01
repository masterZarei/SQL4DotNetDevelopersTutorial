using CompanyManagement.Data;
using CompanyManagement.Models;
using Dapper;
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
            return _db.Query<Company>("sp_GetCompany", new { Id = id },
                commandType: CommandType.StoredProcedure).SingleOrDefault();

        }

        public async Task<List<Company>> GetAll()
        {
            return [.. _db.Query<Company>("sp_GetAllCompanies",
                 commandType: CommandType.StoredProcedure)];

        }

        public async Task Remove(int id)
        {
            _db.Execute("sp_RemoveCompany", new { Id = id }, commandType: CommandType.StoredProcedure);
        }

        public async Task<Company> Update(Company company)
        {
            throw new NotImplementedException();

        }
    }
}
