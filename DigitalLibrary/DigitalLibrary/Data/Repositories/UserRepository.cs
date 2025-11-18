using DigitalLibrary.Models;
using DigitalLibrary.Utitlities;
using Microsoft.Data.SqlClient;
using System.Data;

namespace DigitalLibrary.Data.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly ISqlDataContext _dataContext;

        public UserRepository(ISqlDataContext dataContext)
        {
            _dataContext = dataContext;
        }
        private UserDto Map(SqlDataReader r)
            => new UserDto
            {
                Id = r.GetInt32(r.GetOrdinal("Id")),
                FullName = r.GetString(r.GetOrdinal("FullName")),
                PhoneNumber = r.GetString(r.GetOrdinal("PhoneNumber")),
                RoleId = r.IsDBNull(r.GetOrdinal("RoleId")) ? null : (int?)r.GetInt32(r.GetOrdinal("RoleId"))
            };
        public async Task<List<UserDto>> GetAllAsync()
        {
            return await _dataContext.ExecuteReaderAsync("sp_GetAllUsers", CommandType.StoredProcedure, Map);
        }
        public async Task<UserDto?> GetByIdAsync(int Id)
        {
            var list = await _dataContext.ExecuteReaderAsync("sp_GetUserById", CommandType.StoredProcedure, Map, new SqlParameter("@Id", Id));
            return list.FirstOrDefault();
        }
        public async Task<int> AddAsync(UserDto dto)
        {
            var result = await _dataContext.ExecuteScalarAsync("sp_CreateUser", CommandType.StoredProcedure,
                 new SqlParameter("@FullName", dto.FullName),
                new SqlParameter("@PhoneNumber", dto.PhoneNumber),
                new SqlParameter("@Password", Md5Hasher.Hash(dto.Password)),
                new SqlParameter("@RoleId", dto.RoleId));
            return Convert.ToInt32(result);
        }
        public async Task<int> UpdateAsync(UserDto dto)
        {
            return await _dataContext.ExecuteNonQueryAsync("sp_UpdateUser", CommandType.StoredProcedure,
                new SqlParameter("@FullName", dto.FullName),
                new SqlParameter("@PhoneNumber", dto.PhoneNumber),
                new SqlParameter("@RoleId", dto.RoleId));
        }

        public async Task<int> SoftDeleteAsync(int Id)
              => await _dataContext.ExecuteNonQueryAsync("sp_DeleteUser", CommandType.StoredProcedure, new SqlParameter("@Id", Id));

        public async Task<UserDto?> LoginUser(LoginDto dto)
        {
            var result = await _dataContext.ExecuteReaderAsync("sp_LoginUser", CommandType.StoredProcedure, Map,
                new SqlParameter("@PhoneNumber", dto.PhoneNumber),
                new SqlParameter("@Password", Md5Hasher.Hash(dto.Password)));

            return result.FirstOrDefault();
        }
    }
}
