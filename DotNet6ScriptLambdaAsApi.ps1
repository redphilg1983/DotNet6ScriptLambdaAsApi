[string]$filePath = Read-Host "Please enter full file path"

cd "$filePath"

[string]$projectName = Read-Host "Please enter the name of the project, for example TestRepo"



dotnet new sln --name $projectName

mkdir Lambda
cd Lambda
dotnet new webapi --name "$projectName.Lambda"
dotnet new classlib --name "$projectName.Lambda.Interface"
dotnet new classlib --name "$projectName.Lambda.ViewModel"
cd ..

mkdir Application
cd Application
dotnet new classlib --name "$projectName.Application"
dotnet new classlib --name "$projectName.Application.Infrastructure"
dotnet new classlib --name "$projectName.Application.Interface"
cd ..

mkdir Domain
cd Domain
dotnet new classlib --name "$projectName.Domain"
dotnet new classlib --name "$projectName.Domain.Infrastructure"
cd ..

mkdir Repository
cd Repository
dotnet new classlib --name "$projectName.Repository"
dotnet new classlib --name "$projectName.Repository.Infrastructure"
dotnet new classlib --name "$projectName.Repository.Interface"
cd ..

mkdir Test
cd Test
dotnet new nunit --name "$projectName.Application.Test"
dotnet new nunit --name "$projectName.Domain.Infrastructure.Test"
dotnet new nunit --name "$projectName.Domain.Test"
dotnet new nunit --name "$projectName.Lambda.Test"
dotnet new nunit --name "$projectName.Repository.Test"

cd ..

dotnet sln add Application\$projectName.Application\$projectName.Application.csproj
dotnet sln add Application\$projectName.Application.Infrastructure\$projectName.Application.Infrastructure.csproj
dotnet sln add Application\$projectName.Application.Interface\$projectName.Application.Interface.csproj

dotnet sln add Domain\$projectName.Domain\$projectName.Domain.csproj
dotnet sln add Domain\$projectName.Domain.Infrastructure\$projectName.Domain.Infrastructure.csproj

dotnet sln add Lambda\$projectName.Lambda\$projectName.Lambda.csproj
dotnet sln add Lambda\$projectName.Lambda.Interface\$projectName.Lambda.Interface.csproj
dotnet sln add Lambda\$projectName.Lambda.ViewModel\$projectName.Lambda.ViewModel.csproj

dotnet sln add Repository\$projectName.Repository\$projectName.Repository.csproj
dotnet sln add Repository\$projectName.Repository.Infrastructure\$projectName.Repository.Infrastructure.csproj
dotnet sln add Repository\$projectName.Repository.Interface\$projectName.Repository.Interface.csproj

dotnet sln add Test\$projectName.Application.Test\$projectName.Application.Test.csproj
dotnet sln add Test\$projectName.Domain.Infrastructure.Test\$projectName.Domain.Infrastructure.Test.csproj
dotnet sln add Test\$projectName.Domain.Test\$projectName.Domain.Test.csproj
dotnet sln add Test\$projectName.Lambda.Test\$projectName.Lambda.Test.csproj
dotnet sln add Test\$projectName.Repository.Test\$projectName.Repository.Test.csproj

dotnet add Application\$projectName.Application\$projectName.Application.csproj reference Application\$projectName.Application.Interface\$projectName.Application.Interface.csproj
dotnet add Application\$projectName.Application\$projectName.Application.csproj reference Repository\$projectName.Repository.Interface\$projectName.Repository.Interface.csproj

dotnet add Application\$projectName.Application.Infrastructure\$projectName.Application.Infrastructure.csproj reference Application\$projectName.Application\$projectName.Application.csproj
dotnet add Application\$projectName.Application.Infrastructure\$projectName.Application.Infrastructure.csproj reference Application\$projectName.Application.Interface\$projectName.Application.Interface.csproj
dotnet add Application\$projectName.Application.Infrastructure\$projectName.Application.Infrastructure.csproj reference Repository\$projectName.Repository.Infrastructure\$projectName.Repository.Infrastructure.csproj

dotnet add Application\$projectName.Application.Interface\$projectName.Application.Interface.csproj reference Domain\$projectName.Domain\$projectName.Domain.csproj
dotnet add Domain\$projectName.Domain\$projectName.Domain.csproj reference Domain\$projectName.Domain.Infrastructure\$projectName.Domain.Infrastructure.csproj

dotnet add Lambda\$projectName.Lambda\$projectName.Lambda.csproj reference Application\$projectName.Application.Infrastructure\$projectName.Application.Infrastructure.csproj
dotnet add Lambda\$projectName.Lambda\$projectName.Lambda.csproj reference Application\$projectName.Application.Interface\$projectName.Application.Interface.csproj
dotnet add Lambda\$projectName.Lambda\$projectName.Lambda.csproj reference Domain\$projectName.Domain\$projectName.Domain.csproj
dotnet add Lambda\$projectName.Lambda\$projectName.Lambda.csproj reference Lambda\$projectName.Lambda.Interface\$projectName.Lambda.Interface.csproj
dotnet add Lambda\$projectName.Lambda\$projectName.Lambda.csproj reference Lambda\$projectName.Lambda.ViewModel\$projectName.Lambda.ViewModel.csproj

dotnet add Lambda\$projectName.Lambda.Interface\$projectName.Lambda.Interface.csproj reference Lambda\$projectName.Lambda.ViewModel\$projectName.Lambda.ViewModel.csproj

dotnet add Repository\$projectName.Repository\$projectName.Repository.csproj reference Repository\$projectName.Repository.Interface\$projectName.Repository.Interface.csproj

dotnet add Repository\$projectName.Repository.Infrastructure\$projectName.Repository.Infrastructure.csproj reference Repository\$projectName.Repository\$projectName.Repository.csproj
dotnet add Repository\$projectName.Repository.Infrastructure\$projectName.Repository.Infrastructure.csproj reference Repository\$projectName.Repository.Interface\$projectName.Repository.Interface.csproj

dotnet add Repository\$projectName.Repository.Interface\$projectName.Repository.Interface.csproj reference Domain\$projectName.Domain\$projectName.Domain.csproj

dotnet add Test\$projectName.Application.Test\$projectName.Application.Test.csproj reference Application\$projectName.Application\$projectName.Application.csproj
dotnet add Test\$projectName.Application.Test\$projectName.Application.Test.csproj reference Application\$projectName.Application.Interface\$projectName.Application.Interface.csproj
dotnet add Test\$projectName.Application.Test\$projectName.Application.Test.csproj reference Domain\$projectName.Domain\$projectName.Domain.csproj
dotnet add Test\$projectName.Application.Test\$projectName.Application.Test.csproj reference Repository\$projectName.Repository.Interface\$projectName.Repository.Interface.csproj

dotnet add Test\$projectName.Domain.Infrastructure.Test\$projectName.Domain.Infrastructure.Test.csproj reference Domain\$projectName.Domain.Infrastructure\$projectName.Domain.Infrastructure.csproj

dotnet add Test\$projectName.Domain.Test\$projectName.Domain.Test.csproj reference Domain\$projectName.Domain\$projectName.Domain.csproj

dotnet add Test\$projectName.Lambda.Test\$projectName.Lambda.Test.csproj reference Lambda\$projectName.Lambda\$projectName.Lambda.csproj
dotnet add Test\$projectName.Lambda.Test\$projectName.Lambda.Test.csproj reference Lambda\$projectName.Lambda.Interface\$projectName.Lambda.Interface.csproj
dotnet add Test\$projectName.Lambda.Test\$projectName.Lambda.Test.csproj reference Lambda\$projectName.Lambda.ViewModel\$projectName.Lambda.ViewModel.csproj

dotnet add Test\$projectName.Repository.Test\$projectName.Repository.Test.csproj reference Domain\$projectName.Domain\$projectName.Domain.csproj
dotnet add Test\$projectName.Repository.Test\$projectName.Repository.Test.csproj reference Repository\$projectName.Repository\$projectName.Repository.csproj
dotnet add Test\$projectName.Repository.Test\$projectName.Repository.Test.csproj reference Repository\$projectName.Repository.Interface\$projectName.Repository.Interface.csproj

New-Item "Solution Items" -ItemType Directory

cd "Solution Items"

New-Item "docs" -ItemType Directory
New-Item ".gitignore" -ItemType File
New-Item "bitbucket-pipeline.yml" -ItemType File
New-Item "catalog-info.yaml" -ItemType File
New-Item "mkdocs.yaml" -ItemType File

cd "docs"

New-Item "assets" -ItemType Directory
New-Item "architecture.md" -ItemType File
New-Item "index.md" -ItemType File
New-Item "runbook.md" -ItemType File

cd ../..
cd Lambda\$projectName.Lambda
cd Controllers

'using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading.Tasks;
using Amazon.Lambda.Core;
using ' + $projectName + '.Lambda.ViewModel;
using ' + $projectName + '.Lambda.Interface.Proxy;
using Microsoft.Extensions.Logging;

namespace ' + $projectName + '.Lambda.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HealthCheckController : Controller
    {
        private readonly IHealthCheckProxy _healthCheckProxy;
        private readonly ILogger<HealthCheckController> _logger;

        public HealthCheckController(IHealthCheckProxy healthCheckProxy, ILogger<HealthCheckController> logger)
        {
            _healthCheckProxy = healthCheckProxy ?? throw new ArgumentNullException(nameof(healthCheckProxy));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        [HttpGet]
        [ProducesResponseType(typeof(HealthCheck), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> Get()
        {
            try
            {
                var healthCheck = await _healthCheckProxy.ReadAsync();
                return healthCheck == null ? (IActionResult)NotFound() : Ok(healthCheck);
            }
            catch (Exception exception)
            {
                return ActionResultFromException(@"Get", exception);
            }
        }

        private IActionResult ActionResultFromException(string method, Exception exception)
        {
            LambdaLogger.Log($"HealthCheck Controller {method} general exception; {exception.Message}");
            return StatusCode(StatusCodes.Status500InternalServerError, exception.Message);
        }
    }
}
' | Out-File HealthCheck.cs

cd ..
mkdir Proxy
cd Proxy
'using System;
using System.Threading.Tasks;
using ' + $projectName + '.Application.Interface;
using ' + $projectName + '.Lambda.Interface.Proxy;
using ' + $projectName + '.Lambda.ViewModel;
using AutoMapper;

namespace ' + $projectName + '.Lambda.Proxy
{
    public class HealthCheckProxy : IHealthCheckProxy
    {
        private readonly IHealthCheckApplication _healthCheckApplication;
        private readonly IMapper _mapper;

        public HealthCheckProxy(IMapper mapper, IHealthCheckApplication healthCheckApplication)
        {
            _mapper = mapper;
            _healthCheckApplication = healthCheckApplication ?? throw new ArgumentNullException(nameof(healthCheckApplication));
        }

        public async Task<HealthCheck> ReadAsync()
        {
            var healthCheck = await _healthCheckApplication.ReadAsync();
            var model = _mapper.Map<HealthCheck>(healthCheck);
            return model;
        }
    }
}
' | Out-File HealthCheckProxy.cs

cd ..

mkdir DependencyResolver
cd DependencyResolver
'using System.Diagnostics.CodeAnalysis;
using ' + $projectName + '.Application;
using ' + $projectName + '.Application.Infrastructure.Extensions;
using ' + $projectName + '.Application.Interface;
using ' + $projectName + '.Lambda.Interface.Proxy;
using ' + $projectName + '.Lambda.Proxy;
using Microsoft.Extensions.DependencyInjection;
using IHealthCheckProxy = ' + $projectName + '.Lambda.Interface.Proxy.IHealthCheckProxy;

namespace ' + $projectName + '.Lambda.DependencyResolver
{
    [ExcludeFromCodeCoverage]
    public static class IServiceCollectionExtension
    {
        public static IServiceCollection AddProxyServiceCollectionLibrary(this IServiceCollection services)
        {
            services.AddApplicationServiceCollectionLibrary();
            services.AddScoped<IHealthCheckProxy, HealthCheckProxy>();
            return services;
        }
    }
}
' | Out-File IServiceCollectionExtension.cs

cd ..

mkdir Mapping
cd Mapping
'using ' + $projectName + '.Domain;
using AutoMapper;

namespace ' + $projectName + '.Lambda.Mapping
{
    public class HealthCheckProfile : Profile
    {
        public HealthCheckProfile()
        {
            CreateMap<HealthCheck,  ' + $projectName + '.Lambda.ViewModel.HealthCheck>()
                .ReverseMap();
        }
    }
}
' | Out-File HealthCheckProvider.cs

cd ../../..
cd Application/$projectName.Application

'using System;
using System.Threading.Tasks;
using ' + $projectName + '.Application.Interface;
using ' + $projectName + '.Domain;
using ' + $projectName + '.Repository.Interface;

namespace ' + $projectName + '.Application
{
    public class HealthCheckApplication : IHealthCheckApplication
    {
        private readonly IHealthCheckProvider _healthCheckProvider;

        public HealthCheckApplication(IHealthCheckProvider healthCheckProvider)
        {
            _healthCheckProvider = healthCheckProvider ?? throw new ArgumentNullException(nameof(healthCheckProvider));
        }

        public async Task<HealthCheck> ReadAsync()
        {
            return await _healthCheckProvider.ReadAsync();
        }
    }
}
' | Out-File HealthCheckApplication.cs

cd ../..

cd Application/$projectName.Application.Infrastructure

mkdir Extensions
cd Extensions

'using System.Diagnostics.CodeAnalysis;
using System.Linq;
using ' + $projectName + '.Application.Interface;
using ' + $projectName + '.Repository.Infrastructure.Extensions;
using Microsoft.Extensions.DependencyInjection;

namespace ' + $projectName + '.Application.Infrastructure.Extensions
{
    [ExcludeFromCodeCoverage]
    public static class IServiceCollectionExtension
    {
        public static IServiceCollection AddApplicationServiceCollectionLibrary(this IServiceCollection services)
        {
            services.AddRepositoryServiceCollectionLibrary();
            services.AddScoped<IHealthCheckApplication, HealthCheckApplication>();
            return services;
        }
    }
}' | Out-File IServiceCollectionExtension.cs

cd ../../..
cd Application/$projectName.Application.Interface

'using System.Threading.Tasks;
using ' + $projectName + '.Domain;

namespace ' + $projectName + '.Application.Interface
{
    public interface IHealthCheckApplication
    {
        Task<HealthCheck> ReadAsync();
    }
}
' | Out-File IHealthCheckApplication.cs

cd ../..
cd Domain/$projectName.Domain

'using System;
using System.Diagnostics.CodeAnalysis;

namespace ' + $projectName + '.Domain
{
    [ExcludeFromCodeCoverage]
    public class HealthCheck
    {
        public HealthCheck(
            DateTime systemDateTime,
            bool canReachInternet)
        {
            SystemDateTime = systemDateTime;
            CanReachInternet = canReachInternet;
        }


        public DateTime SystemDateTime { get; }

        public bool CanReachInternet { get; }
    }
}
' | Out-File HealthCheck.cs

cd ../..
cd Lambda/$projectName.Lambda.Interface
mkdir Proxy
cd Proxy

'using ' + $projectName + '.Lambda.ViewModel;
using System.Threading.Tasks;

namespace ' + $projectName + '.Lambda.Interface.Proxy
{
    public interface IHealthCheckProxy
    {
        Task<HealthCheck> ReadAsync();
    }
}
' | Out-File IHealthCheckProxy.cs

cd ../../..
cd Lambda/$projectName.Lambda.ViewModel

'using System;
using System.ComponentModel.DataAnnotations;
using System.Diagnostics.CodeAnalysis;

namespace ' + $projectName + '.Lambda.ViewModel
{
    [ExcludeFromCodeCoverage]
    public class HealthCheck
    {

        [Required] public DateTime SystemDateTime { get; set; }

        [Required] public bool CanReachInternet { get; set; }
    }
}' | Out-File HealthCheck.cs

cd ../..
cd Repository/$projectName.Repository

'using System;
using System.Diagnostics.CodeAnalysis;
using System.Net;
using System.Net.NetworkInformation;
using System.Threading.Tasks;
using Microsoft.Extensions.Options;
using NodaTime;
using ' + $projectName + '.Domain;
using ' + $projectName + '.Repository.Interface;

namespace ' + $projectName + '.Repository
{
    [ExcludeFromCodeCoverage]
    public class HealthCheckProvider : IHealthCheckProvider
    {
        private readonly IClock _clock;

        public HealthCheckProvider(IClock clock)
        {
            _clock = clock;
        }

        public async Task<HealthCheck> ReadAsync()
        {
            var internetHealthCheckTask = await CanReachInternetAsync();

            return new HealthCheck(
                _clock.GetCurrentInstant().ToDateTimeUtc(),
                internetHealthCheckTask.Item1);
        }

        private async Task<Tuple<bool, string>> CanReachInternetAsync()
        {
            try
            {
                var baseAddress = @"8.8.8.8";

                var ping = new Ping();

                var pingStatus = await ping.SendPingAsync(IPAddress.Parse(baseAddress), 1000);

                return new Tuple<bool, string>(pingStatus?.Status == IPStatus.Success, $@"Internet Healthcheck {(pingStatus == null ? @"Undetermined" : pingStatus.Status.ToString())}");
            }
            catch (Exception exception)
            {
                return new Tuple<bool, string>(false, $@"Internet Healthcheck Error: {exception.Message}");
            }
        }
    }
}
' | Out-File HealthCheckProvider.cs

cd ../..
cd Repository/$projectName.Repository.Infrastructure

mkdir Extensions
cd Extensions

'using System.Diagnostics.CodeAnalysis;
using Microsoft.Extensions.DependencyInjection;
using NodaTime;
using ' + $projectName + '.Repository.Interface;

namespace ' + $projectName + '.Repository.Infrastructure.Extensions
{
    [ExcludeFromCodeCoverage]
    public static class IServiceCollectionExtension
    {
        public static IServiceCollection AddRepositoryServiceCollectionLibrary(this IServiceCollection services)
        {
            services.AddSingleton<IClock>(SystemClock.Instance);
            services.AddScoped<IHealthCheckProvider, HealthCheckProvider>();
            services.AddAutoMapper(typeof(HealthCheckProvider));
            return services;
        }
    }
}
' | Out-File IServiceCollectionExtension.cs

cd ../../..
cd Repository/$projectName.Repository.Interface

'using System.Threading.Tasks;
using  ' + $projectName + '.Domain;

namespace  ' + $projectName + '.Repository.Interface
{
    public interface IHealthCheckProvider
    {
        Task<HealthCheck> ReadAsync();
    }
}

' | Out-File IHealthCheckProvider.cs

cd ../..
cd Repository/$projectName.Repository

dotnet add package Microsoft.Extensions.Options
dotnet add package nodatime

cd ../..
cd Repository/$projectName.Repository.Infrastructure
dotnet add package Microsoft.Extensions.DependencyInjection
dotnet add package AutoMapper
dotnet add package AutoMapper.Extensions.Microsoft.DependencyInjection

cd ../..
cd Lambda/$projectName.Lambda
dotnet add package Microsoft.Extensions.DependencyInjection
dotnet add package AutoMapper
dotnet add package AutoMapper.Extensions.Microsoft.DependencyInjection
dotnet add package Amazon.Lambda.Core

Remove-Item Program.cs

'using Microsoft.Extensions.DependencyInjection;
using   ' + $projectName + '.Lambda.DependencyResolver;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddProxyServiceCollectionLibrary();
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
' | Out-File Program.cs