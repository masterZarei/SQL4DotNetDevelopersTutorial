using System.Security.Cryptography;
using System.Text;
namespace DigitalLibrary.Utitlities
{

    public static class Md5Hasher
    {
        /// <summary>
        /// هش کردن یک رشته با MD5
        /// </summary>
        public static string Hash(string input)
        {
            if (string.IsNullOrWhiteSpace(input))
                return string.Empty;

            using var md5 = MD5.Create();
            var inputBytes = Encoding.UTF8.GetBytes(input);
            var hashBytes = md5.ComputeHash(inputBytes);

            // تبدیل نتیجه به Hex
            var sb = new StringBuilder();
            foreach (var b in hashBytes)
                sb.Append(b.ToString("x2"));

            return sb.ToString();
        }

        /// <summary>
        /// مقایسه مقدار ورودی با هش ذخیره‌شده
        /// </summary>
        public static bool Verify(string input, string hashed)
        {
            if (hashed is null) return false;

            var hashedInput = Hash(input);
            return StringComparer.OrdinalIgnoreCase.Equals(hashedInput, hashed);
        }
    }

}
