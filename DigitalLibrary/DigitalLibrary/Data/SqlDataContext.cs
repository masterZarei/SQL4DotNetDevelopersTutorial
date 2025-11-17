using Microsoft.Data.SqlClient;
using System.Data;

namespace DigitalLibrary.Data
{
    public class SqlDataContext : ISqlDataContext
    {
        private readonly IConfiguration _config;

        public SqlDataContext(IConfiguration config)
        {
            _config = config;
        }

        private SqlConnection CreateConnection()
            => new SqlConnection(_config.GetConnectionString("DefaultConnection"));

        public async Task<int> ExecuteNonQueryAsync(string cmdText, CommandType type, params SqlParameter[] parameters)
        {
            await using var conn = CreateConnection();
            await using var cmd = new SqlCommand(cmdText, conn) { CommandType = type };
            if (parameters?.Length > 0) cmd.Parameters.AddRange(parameters);
            await conn.OpenAsync();
            return await cmd.ExecuteNonQueryAsync();
        }
        public async Task<object?> ExecuteScalarAsync(string cmdText, CommandType type, params SqlParameter[] parameters)
        {
            await using var conn = CreateConnection();
            await using var cmd = new SqlCommand(cmdText, conn) { CommandType = type };
            if (parameters?.Length > 0) cmd.Parameters.AddRange(parameters);
            await conn.OpenAsync();
            return await cmd.ExecuteScalarAsync();
        }
        public async Task<List<T>> ExecuteReaderAsync<T>(string cmdText, CommandType type, Func<SqlDataReader, T> map, params SqlParameter[] parameters)
        {
            var list = new List<T>();
            await using var conn = CreateConnection();
            await using var cmd = new SqlCommand(cmdText, conn) { CommandType = type };
            if (parameters?.Length > 0) cmd.Parameters.AddRange(parameters);
            await conn.OpenAsync();
            await using var reader = await cmd.ExecuteReaderAsync();
            while (await reader.ReadAsync())
            {
                list.Add(map(reader));
            }
            return list;
        }

    }
}
