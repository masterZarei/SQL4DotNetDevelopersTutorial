using DigitalLibrary.Models;

namespace DigitalLibrary.Data.Repositories
{
    public interface IBookRepository
    {
        Task<int> AddAsync(BookDto dto);
        Task<List<BookDto>> GetAllAsync();
        Task<BookDto?> GetByIdAsync(int Id);
        Task<int> SoftDeleteAsync(int Id);
        Task<int> UpdateAsync(BookDto dto);
    }
}