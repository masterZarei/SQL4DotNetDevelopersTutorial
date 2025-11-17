using DigitalLibrary.Models;

namespace DigitalLibrary.Data.Repositories
{
    public interface IRoleRepository
    {
        Task<int> AddAsync(RoleDto dto);
        Task<int> DeleteAsync(int Id);
        Task<List<RoleDto>> GetAllAsync();
        Task<RoleDto?> GetByIdAsync(int Id);
        Task<int> UpdateAsync(RoleDto dto);
    }
}