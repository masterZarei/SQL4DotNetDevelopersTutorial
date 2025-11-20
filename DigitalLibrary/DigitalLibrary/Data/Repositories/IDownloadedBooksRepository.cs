using DigitalLibrary.Models;

namespace DigitalLibrary.Data.Repositories;
public interface IDownloadedBooksRepository
{
    Task<int> AddAsync(DownloadedBookDto dto);
    Task<List<BookDto>> GetAllAsync(int UserId);
    Task<DownloadedBookDto?> GetByUserIdAndBookIdAsync(int UserId, int BookId);
}