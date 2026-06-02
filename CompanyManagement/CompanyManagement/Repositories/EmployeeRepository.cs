using CompanyManagement.Models;
using Dapper;
using Microsoft.Data.SqlClient;
using System.Data;

namespace CompanyManagement.Repositories;

public class EmployeeRepository : IEmployeeRepository
{
    private IDbConnection _db;
    public EmployeeRepository(IConfiguration configuration)
    {
        _db = new SqlConnection(configuration.GetConnectionString("CompanyConnection"));
    }
    public async Task<Employee> Add(Employee employee)
    {
        var sql = "INSERT INTO Employees (Name, Phone, Title, CompanyId) VALUES(@Name, @Phone, @Title, @CompanyId);"+
            "SELECT CAST(SCOPE_IDENTITY() as int)";
        var id = (await _db.QueryAsync<int>(sql, employee)).SingleOrDefault();
        employee.Id = id;
        return employee;

    }

    public async Task<Employee> Find(int id)
    {

        var sql = "SELECT * FROM Employees WHERE Id=@Id";
        return (await _db.QueryAsync<Employee>(sql,new {Id = id})).SingleOrDefault();
    }

    public async Task<List<Employee>> GetAll()
    {
        var sql = "SELECT * FROM Employees";
        return (await _db.QueryAsync<Employee>(sql)).ToList();

    }

    public async Task Remove(int id)
    {
        var sql = "DELETE FROM Employees WHERE Id=@Id";
        await _db.ExecuteAsync(sql, new {Id =  id});
    }

    public async Task<Employee> Update(Employee employee)
    {
        var sql = "UPDATE Employees SET Name=@Name, Title=@Title, Phone=@Phone, CompanyId=@CompanyId WHERE Id=@Id";
        await _db.ExecuteAsync(sql,employee);
        return employee;
    }
}