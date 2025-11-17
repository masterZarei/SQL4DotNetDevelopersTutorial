using Microsoft.Data.SqlClient;
using System.Data;

namespace DigitalLibrary.Data
{
    public interface ISqlDataContext
    {
        Task<int> ExecuteNonQueryAsync(string cmdText, CommandType type, params SqlParameter[] parameters);
        Task<List<T>> ExecuteReaderAsync<T>(string cmdText, CommandType type, Func<SqlDataReader, T> map, params SqlParameter[] parameters);
        Task<object?> ExecuteScalarAsync(string cmdText, CommandType type, params SqlParameter[] parameters);
    }
}