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
            param.Add("@Id", 0, DbType.Int32, direction: ParameterDirection.Output);
            param.Add("@Name", company.Name);
            param.Add("@Address", company.Address);
            param.Add("@City", company.City);
            param.Add("@State", company.State);
            param.Add("@PostalCode", company.PostalCode);

            await _db.ExecuteAsync("sp_AddCompany", param, commandType: CommandType.StoredProcedure);
            company.Id = param.Get<int>("Id");
            return company;
        }

        public async Task<Company> Find(int id)
        {
            return (await _db.QueryAsync<Company>("sp_GetCompany", new { Id = id }
            , commandType: CommandType.StoredProcedure)).SingleOrDefault();

        }

        public async Task<List<Company>> GetAll()
        {
            return (await _db.QueryAsync<Company>("sp_GetAllCompanies", commandType: CommandType.StoredProcedure)).ToList();
        }

        public async Task Remove(int id)
        {
            await _db.ExecuteAsync("sp_RemoveCompany", new { Id = id },
                commandType: CommandType.StoredProcedure);

        }

        public async Task<Company> Update(Company company)
        {
            var param = new DynamicParameters();
            param.Add("@Id", company.Id, DbType.Int32);
            param.Add("@Name", company.Name);
            param.Add("@Address", company.Address);
            param.Add("@City", company.City);
            param.Add("@State", company.State);
            param.Add("@PostalCode", company.PostalCode);

            await _db.ExecuteAsync("sp_UpdateCompany", param, commandType: CommandType.StoredProcedure);
            return company;
        }
    }
}
