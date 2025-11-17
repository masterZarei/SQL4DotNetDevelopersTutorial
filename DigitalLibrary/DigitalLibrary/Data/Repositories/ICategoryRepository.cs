using DigitalLibrary.Models;

namespace DigitalLibrary.Data.Repositories
{
    public interface ICategoryRepository
    {
        Task<int> AddAsync(CategoryDto dto);
        Task<int> DeleteAsync(int Id);
        Task<List<CategoryDto>> GetAllAsync();
        Task<CategoryDto?> GetByIdAsync(int Id);
        Task<int> UpdateAsync(CategoryDto dto);
    }
}