[string]$filePath = Read-Host "Please enter full file path"

cd "$filePath"

[string]$projectName = Read-Host "Please enter the name of the project, for example AO.LastMile.Test"



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
dotnet add Test\$projectName.Application.Test\$projectName.Application.Test.csproj reference Lambda\$projectName.Lambda\$projectName.Lambda.csproj

dotnet add Test\$projectName.Domain.Infrastructure.Test\$projectName.Domain.Infrastructure.Test.csproj reference Domain\$projectName.Domain.Infrastructure\$projectName.Domain.Infrastructure.csproj

dotnet add Test\$projectName.Domain.Test\$projectName.Domain.Test.csproj reference Domain\$projectName.Domain\$projectName.Domain.csproj

dotnet add Test\$projectName.Lambda.Test\$projectName.Lambda.Test.csproj reference Lambda\$projectName.Lambda\$projectName.Lambda.csproj

dotnet add Test\$projectName.Repository.Test\$projectName.Repository.Test.csproj reference Domain\$projectName.Domain\$projectName.Domain.csproj

dotnet add Test\$projectName.Repository.Test\$projectName.Repository.Test.csproj reference Repository\$projectName.Repository\$projectName.Repository.csproj

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
using ' + $projectName + '.Lambda.DependencyResolver;

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


'' | Out-File serverless.yml

'using System.Diagnostics.CodeAnalysis;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;

namespace ' + $projectName + '.Lambda
{
    /// <summary>
    /// This class extends from APIGatewayProxyFunction which contains the method FunctionHandlerAsync which is the 
    /// actual Lambda function entry point. The Lambda handler field should be set to
    /// 
    ///  ' + $projectName + '.Lambda:: ' + $projectName + '.Lambda.LambdaEntryPoint::FunctionHandlerAsync
    /// </summary>  
    [ExcludeFromCodeCoverage]
    public class LambdaEntryPoint :

        // The base class must be set to match the AWS service invoking the Lambda function. If not Amazon.Lambda.AspNetCoreServer
        // will fail to convert the incoming request correctly into a valid ASP.NET Core request.
        //
        // API Gateway REST API                         -> Amazon.Lambda.AspNetCoreServer.APIGatewayProxyFunction
        // API Gateway HTTP API payload version 1.0     -> Amazon.Lambda.AspNetCoreServer.APIGatewayProxyFunction
        // API Gateway HTTP API payload version 2.0     -> Amazon.Lambda.AspNetCoreServer.APIGatewayHttpApiV2ProxyFunction
        // Application Load Balancer                    -> Amazon.Lambda.AspNetCoreServer.ApplicationLoadBalancerFunction
        // 
        // Note: When using the AWS::Serverless::Function resource with an event type of "HttpApi" then payload version 2.0
        // will be the default and you must make Amazon.Lambda.AspNetCoreServer.APIGatewayHttpApiV2ProxyFunction the base class.

        Amazon.Lambda.AspNetCoreServer.APIGatewayProxyFunction
    {
        /// <summary>
        /// The builder has configuration, logging and Amazon API Gateway already configured. The startup class
        /// needs to be configured in this method using the UseStartup<>() method.
        /// </summary>
        /// <param name="builder"></param>
        protected override void Init(IWebHostBuilder builder)
        {
            builder
                .UseStartup<Program>();
        }

        /// <summary>
        /// Use this override to customize the services registered with the IHostBuilder. 
        /// 
        /// It is recommended not to call ConfigureWebHostDefaults to configure the IWebHostBuilder inside this method.
        /// Instead customize the IWebHostBuilder in the Init(IWebHostBuilder) overload.
        /// </summary>
        /// <param name="builder"></param>
        protected override void Init(IHostBuilder builder)
        {
        }
    }
}

' | Out-File LambdaEntryPoint.cs

'using System.Diagnostics.CodeAnalysis;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;

namespace ' + $projectName + '.Lambda
{
    [ExcludeFromCodeCoverage]
    public class LocalEntryPoint
    {
        public static void Main(string[] args)
        {
            BuildWebHost(args).Run();
        }

        public static IWebHost BuildWebHost(string[] args)
        {
            return WebHost.CreateDefaultBuilder(args)
                .UseStartup<Program>()
                .Build();
        }
    }
}
' | Out-File LocalEntryPoint.cs

dotnet add package Amazon.Lambda.AspNetCoreServer

cd ../..

cd Test/$projectName.Lambda.Test

mkdir Controllers

cd Controllers

'using System;
using ' + $projectName + '.Lambda.Controllers;
using ' + $projectName + '.Lambda.Interface.Proxy;
using ' + $projectName + '.Lambda.ViewModel;
using Faker;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using NUnit.Framework;

namespace ' + $projectName + '.Lambda.Test.Controllers
{
    public class HealthCheckControllerTests
    {
        private HealthCheckController _healthCheckController;
        private Mock<IHealthCheckProxy> _mockHealthCheckProxy;
        private Mock<ILogger<HealthCheckController>> _mockLogger;

        [SetUp]
        public void SetUp()
        {
            ClearMockInvocations();
        }

        [OneTimeSetUp]
        public void OneTimeSetUp()
        {
            _mockHealthCheckProxy = new Mock<IHealthCheckProxy>();
            _mockLogger = new Mock<ILogger<HealthCheckController>>();
            _healthCheckController = new HealthCheckController(_mockHealthCheckProxy.Object, _mockLogger.Object);
        }

        [TearDown]
        public void TearDown()
        {
            ClearMockInvocations();
        }

        [OneTimeTearDown]
        public void OneTimeTearDown()
        {
        }

        private void ClearMockInvocations()
        {
            _mockHealthCheckProxy.Invocations.Clear();
        }

        [Test]
        public void When_Instantiating_Given_HealthCheckProxy_IsNull_Throws_ArgumentNullException()
        {
            // Arrange
            HealthCheckController healthCheckController = null;
            ClearMockInvocations();

            // Act
            Assert.Throws<ArgumentNullException>(delegate { healthCheckController = new HealthCheckController(null, _mockLogger.Object); });

            // Assert
            Assert.That(healthCheckController, Is.Null);
        }

        [Test]
        public void When_Instantiating_Given_Logger_IsNull_Throws_ArgumentNullException()
        {
            // Arrange
            HealthCheckController healthCheckController = null;
            ClearMockInvocations();

            // Act
            Assert.Throws<ArgumentNullException>(delegate { healthCheckController = new HealthCheckController(_mockHealthCheckProxy.Object, null); });

            // Assert
            Assert.That(healthCheckController, Is.Null);
        }

        [Test]
        public void When_HttpGet_Given_HealthCheckProxy_ThrowsException_Returns_Status500InternalServerError()
        {
            // Arrange     
            IActionResult actionResult = null;
            _mockHealthCheckProxy.Setup(proxy => proxy.ReadAsync())
                                 .Throws<InvalidOperationException>();
            ClearMockInvocations();

            // Act                                                                                                              
            Assert.DoesNotThrow(delegate { actionResult = _healthCheckController.Get().Result; });

            // Assert                                                                          
            Assert.That(actionResult, Is.Not.Null);
            Assert.That(actionResult.GetType(), Is.EqualTo(typeof(ObjectResult)));
            Assert.That(((ObjectResult)actionResult).StatusCode.GetValueOrDefault(200), Is.EqualTo(500));
            _mockHealthCheckProxy.Verify(userProxy => userProxy.ReadAsync(), Times.Once);
            _mockHealthCheckProxy.VerifyNoOtherCalls();
        }

        [Test]
        public void When_HttpGet_Given_HealthCheckProxy_Returns_Null_Returns_Status404NotFound()
        {
            // Arrange                      
            IActionResult actionResult = null;
            _mockHealthCheckProxy.Setup(proxy => proxy.ReadAsync());
            ClearMockInvocations();

            // Act
            Assert.DoesNotThrow(delegate { actionResult = _healthCheckController.Get().Result; });

            // Assert                                        
            Assert.That(actionResult, Is.Not.Null);
            Assert.That(actionResult.GetType(), Is.EqualTo(typeof(NotFoundResult)));
            _mockHealthCheckProxy.Verify(userProxy => userProxy.ReadAsync(), Times.Once);
            _mockHealthCheckProxy.VerifyNoOtherCalls();
        }

        [Test]
        public void When_HttpGet_Given_HealthCheckProxy_Returns_HealthCheck_Returns_Status200Ok()
        {
            // Arrange      
            var viewModelObject = new HealthCheck
                                  {
                                      SystemDateTime = DateTime.Now
                                  };
            IActionResult actionResult = null;
            _mockHealthCheckProxy.Setup(proxy => proxy.ReadAsync())
                                 .ReturnsAsync(viewModelObject);
            ClearMockInvocations();

            // Act
            Assert.DoesNotThrow(delegate { actionResult = _healthCheckController.Get().Result; });

            // Assert                                        
            Assert.That(actionResult, Is.Not.Null);
            Assert.That(actionResult.GetType(), Is.EqualTo(typeof(OkObjectResult)));
            Assert.That(((OkObjectResult)actionResult).Value.GetType(), Is.EqualTo(typeof(HealthCheck)));
            _mockHealthCheckProxy.Verify(userProxy => userProxy.ReadAsync(), Times.Once);
            _mockHealthCheckProxy.VerifyNoOtherCalls();
        }
    }
}
' | Out-File HealthCheckControllerTests.cs

cd ..
dotnet add package Moq
dotnet add package faker.net
dotnet add package microsoft.net.test.sdk
dotnet add package AutoMapper

mkdir Mapping
cd Mapping

'using System.Reflection;
using AutoMapper;
using NUnit.Framework;

namespace ' + $projectName + '.Test.Mapping
{
    public class ProfileTests
    {
        private IMapper _mapper;

        [OneTimeSetUp]
        public void Initialise()
        {
            var assembly = typeof(ProfileTests).GetTypeInfo().Assembly;

            var config = new MapperConfiguration(opts => { opts.AddMaps(assembly); });
            _mapper = config.CreateMapper();
        }

        [OneTimeTearDown]
        public void Destroy()
        {
        }

        [Test]
        public void Given_AutoMapper_AssertConfigurationIsValid()
        {
            _mapper.ConfigurationProvider.AssertConfigurationIsValid();
        }
    }
}
' | Out-File ProfileTests.cs

cd ..
mkdir Proxy
cd Proxy

'using System;
using System.Reflection;
using System.Threading.Tasks;
using ' + $projectName + '.Lambda.Proxy;
using ' + $projectName + '.Lambda.ViewModel;
using ' + $projectName + '.Application.Interface;
using AutoMapper;
using Faker;
using Microsoft.Extensions.Logging;
using Moq;
using NUnit.Framework;

namespace ' + $projectName + '.Test.Proxy
{
    public class HealthCheckProxyTests
    {
        private const HealthCheckProxy HealthCheckProxy = (HealthCheckProxy?)null;
        private const HealthCheck HealthCheck = (HealthCheck?)null;
        private HealthCheckProxy _healthCheckProxy;
        private IMapper _mapper;
        private Mock<IHealthCheckApplication> _mockHealthCheckApplication;

        [OneTimeSetUp]
        public void Initialise()
        {
            var assembly = typeof(HealthCheckProxy).GetTypeInfo().Assembly;

            var config = new MapperConfiguration(opts => { opts.AddMaps(assembly); });
            _mapper = config.CreateMapper();
            _mockHealthCheckApplication = new Mock<IHealthCheckApplication>();
            _healthCheckProxy = new HealthCheckProxy(_mapper, _mockHealthCheckApplication.Object);
        }

        [SetUp]
        public void SetUp()
        {
            ClearMockInvocations();
        }

        [OneTimeTearDown]
        public void Destroy()
        {
        }

        [TearDown]
        public void TearDown()
        {
            ClearMockInvocations();
        }

        private void ClearMockInvocations()
        {
            _mockHealthCheckApplication.Invocations.Clear();
        }

        [Test]
        public void When_Instantiating_Given_HealthCheckApplication_IsNull_Throws_ArgumentNullException()
        {
            ClearMockInvocations();

            // Arrange
            HealthCheckProxy healthCheckProxy = HealthCheckProxy;
            // Act
            Assert.Throws<ArgumentNullException>(delegate { healthCheckProxy = new HealthCheckProxy(_mapper, null); });

            // Assert
            Assert.IsNull(healthCheckProxy);
        }
        [Test]
        public void When_Instantiating_Given_InputParameters_AreValid_Returns_Proxy()
        {
            ClearMockInvocations();

            // Arrange
            HealthCheckProxy healthCheckProxy = HealthCheckProxy;
            // Act
            Assert.DoesNotThrow(delegate { healthCheckProxy = new HealthCheckProxy(_mapper, _mockHealthCheckApplication.Object); });

            // Assert
            Assert.IsNotNull(healthCheckProxy);
        }

        [Test]
        public void When_ReadAsync_Given_HealthCheckApplication_ReturnsNull_ReturnsNull()
        {
            _mockHealthCheckApplication.Setup(healthCheckApplication => healthCheckApplication.ReadAsync())
                                       .Returns(Task.FromResult<Domain.HealthCheck>(null));
            ClearMockInvocations();

            // Arrange                                     
            HealthCheck viewModel = HealthCheck;
            // Act
            Assert.DoesNotThrow(delegate { viewModel = _healthCheckProxy.ReadAsync().Result; });

            // Assert   
            _mockHealthCheckApplication.Verify(healthCheckApplication => healthCheckApplication.ReadAsync(), Times.Once);
            _mockHealthCheckApplication.VerifyNoOtherCalls();
            Assert.That(viewModel, Is.Null);
        }

        [Test]
        public void When_ReadAsync_Given_HealthCheckApplication_ReturnsDomainObjects_ReturnsViewModel()
        {
            // Arrange 
            ClearMockInvocations();
            var environment = Lorem.GetFirstWord();
            var systemDateTime = DateTime.UtcNow.AddMinutes(RandomNumber.Next());
            _mockHealthCheckApplication.Setup(healthCheckApplication => healthCheckApplication.ReadAsync())
                                       .Returns(Task.FromResult(new Domain.HealthCheck(
                                           systemDateTime, true)));

            HealthCheck viewModel = HealthCheck;
            // Act
            Assert.DoesNotThrow(delegate { viewModel = _healthCheckProxy.ReadAsync().Result; });

            // Assert   
            _mockHealthCheckApplication.Verify(healthCheckApplication => healthCheckApplication.ReadAsync(), Times.Once);
            _mockHealthCheckApplication.VerifyNoOtherCalls();
            Assert.That(viewModel, Is.Not.Null);
            Assert.That(viewModel.SystemDateTime, Is.EqualTo(systemDateTime));
        }
    }
}
' | Out-File HealthCheckProxyTests.cs

cd ../../..
cd Test/$projectName.Application.Test

dotnet add package Moq
dotnet add package NUnit
dotnet add package Faker

'using System;
using System.Threading.Tasks;
using ' + $projectName + '.Application;
using ' + $projectName + '.Repository.Interface;
using ' + $projectName + '.Domain;
using NUnit.Framework;
using Moq;

namespace ' + $projectName + '.Application.Test
{
    public class HealthCheckApplicationTests
    {
        private HealthCheckApplication _healthCheckApplication;
        private Mock<IHealthCheckProvider> _mockHealthCheckProvider;

        [SetUp]
        public void SetUp()
        {
        }

        [OneTimeSetUp]
        public void OneTimeSetUp()
        {
            _mockHealthCheckProvider = new Mock<IHealthCheckProvider>();
            _healthCheckApplication = new HealthCheckApplication(_mockHealthCheckProvider.Object);
        }

        [TearDown]
        public void TearDown()
        {
            ClearMockInvocations();
        }

        [OneTimeTearDown]
        public void Destroy()
        {
        }

        private void ClearMockInvocations()
        {
            _mockHealthCheckProvider.Invocations.Clear();
        }

        [Test]
        public void When_Instantiating_Given_HealthCheckProvider_IsNull_Throws_ArgumentNullException()
        {
            // Arrange            
            ClearMockInvocations();
            HealthCheckApplication? healthCheckApplication = (HealthCheckApplication?)null;

            // Act
            Assert.Throws<ArgumentNullException>(delegate {
                healthCheckApplication = new HealthCheckApplication(healthCheckProvider: null);
            });

            // Assert
            Assert.That(healthCheckApplication, Is.Null);
            _mockHealthCheckProvider.VerifyNoOtherCalls();
        }

        [Test]
        public void When_ReadAsync_Given_HealthCheckProvider_ReturnsNull_ReturnsNull()
        {
            // Arrange    
            ClearMockInvocations();
            HealthCheck? healthCheck = (HealthCheck?)null;
            _mockHealthCheckProvider.Setup(healthCheckProvider => healthCheckProvider.ReadAsync())
                               .Returns(Task.FromResult<HealthCheck>(null));
            // Act
            Assert.DoesNotThrowAsync(async () => healthCheck = await _healthCheckApplication.ReadAsync());
            // Assert                          
            _mockHealthCheckProvider.Verify(target => target.ReadAsync(), Times.Once);
            _mockHealthCheckProvider.VerifyNoOtherCalls();
            Assert.That(healthCheck, Is.Null);
        }

        [Test]
        public void When_ReadAsync_Given_HealthCheckProvider_ReturnsHealthCheck_ReturnsHealthCheck()
        {
            var systemDateTime = DateTime.Now;
            var canReachInternet = true;
            ClearMockInvocations();
            _mockHealthCheckProvider.Setup(healthCheckProvider => healthCheckProvider.ReadAsync())
                                    .Returns(Task.FromResult(
                                        new HealthCheck(systemDateTime, canReachInternet)));
            // Arrange                                     
            HealthCheck? healthCheck = null;
            // Act
            Assert.DoesNotThrowAsync(async () => healthCheck = await _healthCheckApplication.ReadAsync());

            // Assert                          
            _mockHealthCheckProvider.Verify(target => target.ReadAsync(), Times.Once);
            _mockHealthCheckProvider.VerifyNoOtherCalls();
            Assert.That(healthCheck, Is.Not.Null);
            Assert.That(healthCheck.SystemDateTime, Is.EqualTo(systemDateTime));
            Assert.That(healthCheck.CanReachInternet, Is.EqualTo(canReachInternet));
        }
	}
}
' | Out-File HealthCheckApplicationTests.cs

cd ../..
cd Test/$projectName.Repository.Test

'using System;
using ' + $projectName + '.Domain;
using ' + $projectName + '.Repository.Interface;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Moq;
using NodaTime;
using NUnit.Framework;

namespace ' + $projectName + '.Repository.Test
{
    public class HealthCheckProviderTests
    {
        private Mock<IClock> _mockClock;

        [OneTimeSetUp]
        public void OneTimeSetUp()
        {
            _mockClock = new Mock<IClock>();
        }

        [SetUp]
        public void SetUp()
        {
            ClearMockInvocations();
        }

        [OneTimeTearDown]
        public void OneTimeTearDown()
        {
        }

        [TearDown]
        public void TearDown()
        {
            ClearMockInvocations();
        }

        [Test]
        public void When_Instantiating_Given_InputParameters_AreNotNull_Returns_Provider()
        {
            //Arrange 
            ClearMockInvocations();
            HealthCheckProvider healthCheckProvider = null;
            //Act
            Assert.DoesNotThrow(delegate
                                {
                                    healthCheckProvider = new HealthCheckProvider(
                                        _mockClock.Object);
                                });
            //Assert                                    
            Assert.That(healthCheckProvider,
                Is.Not.Null);
        }

        private void ClearMockInvocations()
        {
            _mockClock.Invocations.Clear();
        }
    }
}
' | Out-File HealthCheckProviderTests.cs

dotnet add package Moq
dotnet add package faker.net
dotnet add package microsoft.net.test.sdk
dotnet add package AutoMapper
dotnet add package Microsoft.Extensions.Logging
dotnet add package Microsoft.Extensions.Options
dotnet add package nodatime

cd ../..
cd Lambda/$projectName.Lambda

'{
  "Information": [
    "This file provides default values for the deployment wizard inside Visual Studio and the AWS Lambda commands added to the .NET Core CLI.",
    "To learn more about the Lambda commands with the .NET Core CLI execute the following command at the command line in the project root directory.",
    "dotnet lambda help",
    "All the command line options for the Lambda command can be specified in this file."
  ],
  "profile": "default",
  "region": "eu-west-1",
  "configuration": "Release",
  "framework": "net6.0",
  "s3-prefix": " ' + $projectName + '/",
  "template": "serverless.template",
  "template-parameters": ""
}' | Out-File aws-lambda-tools-default.json