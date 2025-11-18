using DigitalLibrary.Models;

namespace DigitalLibrary.Data.Repositories
{
    public interface IUserRepository
    {
        Task<int> AddAsync(UserDto dto);
        Task<List<UserDto>> GetAllAsync();
        Task<UserDto?> GetByIdAsync(int Id);
        Task<UserDto?> LoginUser(LoginDto dto);
        Task<int> SoftDeleteAsync(int Id);
        Task<int> UpdateAsync(UserDto dto);
    }
}