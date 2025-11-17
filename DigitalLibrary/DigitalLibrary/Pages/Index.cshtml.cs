using DigitalLibrary.Data.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Threading.Tasks;

namespace DigitalLibrary.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        private readonly IRoleRepository roleRepository;

        public IndexModel(ILogger<IndexModel> logger, IRoleRepository roleRepository)
        {
            _logger = logger;
            this.roleRepository = roleRepository;
        }

        public async Task<IActionResult> OnGet()
        {
            var list = await roleRepository.GetAllAsync();

            return Page();
        }
    }
}
