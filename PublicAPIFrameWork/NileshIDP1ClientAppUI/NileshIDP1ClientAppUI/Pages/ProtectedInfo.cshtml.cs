using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace NileshIDP1ClientAppUI.Pages
{
    [Authorize]
    public class ProtectedInfoModel : PageModel
    {
        public void OnGet()
        {
        }
    }
}
