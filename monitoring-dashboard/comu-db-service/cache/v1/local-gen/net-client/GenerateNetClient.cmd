@echo off
REM https://github.com/OpenAPITools/openapi-generator

SET PACKAGE_DIRECTORY=%USERPROFILE%/.nuget/packages
SET OUTPUT_DIRECTORY=${PWD}/out
SET INTERFACE_DIRECTORY=${PWD}/../..
SET INTERFACE_FILE=proxia-mes_monitoring-dashboard_comu-db-service_cache_v1.yaml
SET PACKAGE_NAME=PAG.Mes.MonitoringDashboard.ComuDbService.Cache.Client

REM clear output directory
powershell Remove-Item %OUTPUT_DIRECTORY% -Recurse -Force -ErrorAction SilentlyContinue
powershell New-Item -Path %OUTPUT_DIRECTORY% -ItemType "directory"

REM get interface version
powershell (Select-String -Path %INTERFACE_DIRECTORY%/%INTERFACE_FILE% -Pattern 'version:.+''(.+)''').Matches[0].Groups[1].Value > out/version
SET /P INTERFACE_VERSION=<out/version
echo Interface-Version: %INTERFACE_VERSION%

REM generate
powershell docker run --rm -v %OUTPUT_DIRECTORY%:/out -v %INTERFACE_DIRECTORY%:/specs openapitools/openapi-generator-cli:v5.3.0 generate -i specs/%INTERFACE_FILE% -o /out -g csharp-netcore --additional-properties targetFramework=net5.0,packageName=%PACKAGE_NAME%,packageVersion=%INTERFACE_VERSION%,enumValueSuffix=,removeEnumValuePrefix=false || goto :error
REM build
powershell docker run -it --rm -v %OUTPUT_DIRECTORY%:/out mcr.microsoft.com/dotnet/sdk:5.0 dotnet build --configuration Release /out/src/%PACKAGE_NAME%  || goto :error
REM Create and publish the Nuget package
powershell docker run -it --rm -v %OUTPUT_DIRECTORY%:/out mcr.microsoft.com/dotnet/sdk:5.0 dotnet pack /out/src/%PACKAGE_NAME%/%PACKAGE_NAME%.csproj --no-build --configuration Release  || goto :error
powershell docker run -it --rm -v %OUTPUT_DIRECTORY%:/out -v %PACKAGE_DIRECTORY%:/packages mcr.microsoft.com/dotnet/sdk:5.0 dotnet nuget push /out/src/%PACKAGE_NAME%/bin/Release/%PACKAGE_NAME%*.nupkg --source /packages  || goto :error

echo SUCCESS!
goto :EOF

:error
echo ERROR!



