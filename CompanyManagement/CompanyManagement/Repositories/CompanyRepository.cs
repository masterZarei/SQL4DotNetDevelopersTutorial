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
            _db = new SqlConnection(configuration.GetConnectionString("CompanyConnection"));
        }
        public async Task<Company> Add(Company company)
        {
            var param = new DynamicParameters();
            param.Add("@CompanyId", 0, DbType.Int32, direction: ParameterDirection.Output);
            param.Add("@Name", company.Name);
            param.Add("@Address", company.Address);
            param.Add("@State", company.State);
            param.Add("@City", company.City);
            param.Add("@PostalCode", company.PostalCode);

            _db.Execute("sp_AddCompany", param, commandType: CommandType.StoredProcedure);
            company.Id = param.Get<int>("@CompanyId");

            return company;
        }

        public async Task<Company> Find(int id)
        {
            return _db.Query<Company>("sp_GetCompany", new { CompanyId = id },
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
            var param = new DynamicParameters();
            param.Add("@Id",company.Id, DbType.Int32);
            param.Add("@Name", company.Name);
            param.Add("@Address", company.Address);
            param.Add("@State", company.State);
            param.Add("@City", company.City);
            param.Add("@PostalCode", company.PostalCode);

            _db.Execute("sp_UpdateCompany", param, commandType: CommandType.StoredProcedure);
            return company;

        }
    }
}
