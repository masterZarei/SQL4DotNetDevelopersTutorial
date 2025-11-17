using DigitalLibrary.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace DigitalLibrary.Data.Repositories
{
    public class RoleRepository : IRoleRepository
    {
        private readonly ISqlDataContext _dataContext;

        public RoleRepository(ISqlDataContext dataContext)
        {
            _dataContext = dataContext;
        }
        private RoleDto Map(SqlDataReader r) => new()
        {
            Id = r.GetInt32(r.GetOrdinal("Id")),
            Title = r.GetString(r.GetOrdinal("Title"))
        };
        public async Task<List<RoleDto>> GetAllAsync()
        {
            return await _dataContext.ExecuteReaderAsync("sp_GetAllRoles", CommandType.StoredProcedure, Map);
        }
        public async Task<RoleDto?> GetByIdAsync(int Id)
        {
            var list = await _dataContext.ExecuteReaderAsync("sp_GetRoleById", CommandType.StoredProcedure, Map, new SqlParameter("@Id", Id));
            return list.FirstOrDefault();
        }
        public async Task<int> AddAsync(RoleDto dto)
        {
            var result = await _dataContext.ExecuteScalarAsync("sp_AddRole", CommandType.StoredProcedure, new SqlParameter("@Title", dto.Title));
            return Convert.ToInt32(result);
        }
        public async Task<int> UpdateAsync(RoleDto dto)
        {
            return await _dataContext.ExecuteNonQueryAsync("sp_UpdateRole", CommandType.StoredProcedure,
                new SqlParameter("@Id", dto.Id)
                , new SqlParameter("@Title", dto.Title));
        }
        public async Task<int> DeleteAsync(int Id)
        {
            return await _dataContext.ExecuteNonQueryAsync("sp_DeleteRole", CommandType.StoredProcedure, new SqlParameter("@Id", Id));
        }
    }
}