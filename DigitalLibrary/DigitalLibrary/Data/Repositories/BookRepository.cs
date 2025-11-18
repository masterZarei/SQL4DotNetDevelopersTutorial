using DigitalLibrary.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace DigitalLibrary.Data.Repositories
{
    public class BookRepository : IBookRepository
    {
        private readonly ISqlDataContext _dataContext;

        public BookRepository(ISqlDataContext dataContext)
        {
            _dataContext = dataContext;
        }
        private BookDto Map(SqlDataReader r)
         => new()
         {
             Id = r.GetInt32(r.GetOrdinal("Id")),
             Title = r.GetString(r.GetOrdinal("Title")),
             Description = r.IsDBNull(r.GetOrdinal("Description")) ? null : r.GetString(r.GetOrdinal("Description")),
             ImageUrl = r.IsDBNull(r.GetOrdinal("ImageUrl")) ? null : r.GetString(r.GetOrdinal("ImageUrl")),
             FileUrl = r.IsDBNull(r.GetOrdinal("FileUrl")) ? null : r.GetString(r.GetOrdinal("FileUrl")),
             Author = r.IsDBNull(r.GetOrdinal("Author")) ? null : r.GetString(r.GetOrdinal("Author")),
             CategoryId = r.IsDBNull(r.GetOrdinal("CategoryId")) ? null : (int?)r.GetInt32(r.GetOrdinal("CategoryId")),
             IsDeleted = r.GetBoolean(r.GetOrdinal("IsDeleted"))
         };
        public async Task<List<BookDto>> GetAllAsync()
        {
            return await _dataContext.ExecuteReaderAsync("sp_GetAllBooks", CommandType.StoredProcedure, Map);
        }
        public async Task<BookDto?> GetByIdAsync(int Id)
        {
            var list = await _dataContext.ExecuteReaderAsync("sp_GetBookById", CommandType.StoredProcedure, Map, new SqlParameter("@Id", Id));
            return list.FirstOrDefault();
        }
        public async Task<int> UpdateAsync(BookDto dto) => await _dataContext.ExecuteNonQueryAsync("sp_UpdateBook", CommandType.StoredProcedure,
                new SqlParameter("@Id", dto.Id),
                new SqlParameter("@Title", dto.Title),
                new SqlParameter("@Description", (object?)dto.Description ?? DBNull.Value),
                new SqlParameter("@ImageUrl", (object?)dto.ImageUrl ?? DBNull.Value),
                new SqlParameter("@FileUrl", (object?)dto.FileUrl ?? DBNull.Value),
                new SqlParameter("@Author", (object?)dto.Author ?? DBNull.Value),
                new SqlParameter("@CategoryId", (object?)dto.CategoryId ?? DBNull.Value));

        public async Task<int> AddAsync(BookDto dto)
        {
            var result = await _dataContext.ExecuteScalarAsync("sp_AddBook", CommandType.StoredProcedure,
                 new SqlParameter("@Id", dto.Id),
                new SqlParameter("@Title", dto.Title),
                new SqlParameter("@Description", (object?)dto.Description ?? DBNull.Value),
                new SqlParameter("@ImageUrl", (object?)dto.ImageUrl ?? DBNull.Value),
                new SqlParameter("@FileUrl", (object?)dto.FileUrl ?? DBNull.Value),
                new SqlParameter("@Author", (object?)dto.Author ?? DBNull.Value),
                new SqlParameter("@CategoryId", (object?)dto.CategoryId ?? DBNull.Value));

            return Convert.ToInt32(result);
        }
        public async Task<int> SoftDeleteAsync(int Id)
            => await _dataContext.ExecuteNonQueryAsync("sp_DeleteBook", CommandType.StoredProcedure, new SqlParameter("@Id", Id));
    }
}
