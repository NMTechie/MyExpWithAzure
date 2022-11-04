using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authentication.OpenIdConnect;
using Microsoft.Identity.Web;
using Microsoft.IdentityModel.Logging;
using System.Configuration;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddAuthentication(authOptions =>

/*{
    authOptions.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
    authOptions.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
   } JWTAuthentication Scheme */

/* This the openid connect authentication scheme */
    {
        authOptions.DefaultScheme = OpenIdConnectDefaults.AuthenticationScheme;
        authOptions.DefaultChallengeScheme = OpenIdConnectDefaults.AuthenticationScheme;
    }
).AddMicrosoftIdentityWebApp(msIdentityOptions =>
{
    msIdentityOptions.Instance = "https://login.microsoftonline.com/";
    msIdentityOptions.TenantId = "487e96a3-dfb8-4878-9097-20d0073be88b";
    msIdentityOptions.ClientId = "0fed675c-bdd8-4f90-adab-5030f9b3e855";
});

var app = builder.Build();



// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    IdentityModelEventSource.ShowPII = true;
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapRazorPages();

app.Run();
