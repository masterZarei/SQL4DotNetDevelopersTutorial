using DigitalLibrary.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace DigitalLibrary.Data.Repositories
{
    public class CategoryRepository : ICategoryRepository
    {
        private readonly ISqlDataContext _dataContext;

        public CategoryRepository(ISqlDataContext dataContext)
        {
            _dataContext = dataContext;
        }
        private CategoryDto Map(SqlDataReader r) => new()
        {
            Id = r.GetInt32(r.GetOrdinal("Id")),
            Title = r.GetString(r.GetOrdinal("Title"))
        };
        public async Task<List<CategoryDto>> GetAllAsync()
        {
            return await _dataContext.ExecuteReaderAsync("sp_GetAllCategories", CommandType.StoredProcedure, Map);
        }
        public async Task<CategoryDto?> GetByIdAsync(int Id)
        {
            var list = await _dataContext.ExecuteReaderAsync("sp_GetCategoryById", CommandType.StoredProcedure, Map, new SqlParameter("@Id", Id));
            return list.FirstOrDefault();
        }
        public async Task<int> AddAsync(CategoryDto dto)
        {
            var result = await _dataContext.ExecuteScalarAsync("sp_AddCategory", CommandType.StoredProcedure, new SqlParameter("@Title", dto.Title));
            return Convert.ToInt32(result);
        }
        public async Task<int> UpdateAsync(CategoryDto dto)
        {
            return await _dataContext.ExecuteNonQueryAsync("sp_UpdateCategory", CommandType.StoredProcedure,
                new SqlParameter("@Id", dto.Id)
                , new SqlParameter("@Title", dto.Title));
        }
        public async Task<int> DeleteAsync(int Id)
        {
            return await _dataContext.ExecuteNonQueryAsync("sp_DeleteCategory", CommandType.StoredProcedure, new SqlParameter("@Id", Id));
        }
    }
}
