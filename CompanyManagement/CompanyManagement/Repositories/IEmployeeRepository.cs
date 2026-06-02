using CompanyManagement.Models;

namespace CompanyManagement.Repositories;

public interface IEmployeeRepository
{
    Task<Employee> Find(int id);
    Task<List<Employee>> GetAll();
    Task<Employee> Add(Employee company);
    Task<Employee> Update(Employee company);

    Task Remove(int id);
}
