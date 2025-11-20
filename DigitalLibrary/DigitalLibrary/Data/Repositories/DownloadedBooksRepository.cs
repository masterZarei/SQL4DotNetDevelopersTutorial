using DigitalLibrary.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace DigitalLibrary.Data.Repositories;

public class DownloadedBooksRepository : IDownloadedBooksRepository
{
    private readonly ISqlDataContext _dataContext;

    public DownloadedBooksRepository(ISqlDataContext dataContext)
    {
        _dataContext = dataContext;
    }
    private DownloadedBookDto Map(SqlDataReader r) => new()
    {
        Id = r.GetInt32(r.GetOrdinal("Id")),
        BookId = r.GetInt32(r.GetOrdinal("BookId")),
        UserId = r.GetInt32(r.GetOrdinal("UserId")),
    };
    public async Task<List<DownloadedBookDto>> GetAllAsync(int UserId)
    {
        return await _dataContext.ExecuteReaderAsync("sp_GetAllDownloadedBooksByUserId", CommandType.StoredProcedure, Map, new SqlParameter("@Id", UserId));
    }
    public async Task<DownloadedBookDto?> GetByUserIdAndBookIdAsync(int UserId, int BookId)
    {
        var list = await _dataContext.ExecuteReaderAsync("GetDownloadedBook", CommandType.StoredProcedure, Map
            , new SqlParameter("@UserId", UserId)
            , new SqlParameter("@BookId", BookId)
            );
        return list.FirstOrDefault();
    }
    public async Task<int> AddAsync(DownloadedBookDto dto)
    {
        var result = await _dataContext.ExecuteScalarAsync("sp_AddDownloadedBook", CommandType.StoredProcedure,
            new SqlParameter("@UserId", dto.UserId),
            new SqlParameter("@BookId", dto.BookId)
            );
        return Convert.ToInt32(result);
    }
}
