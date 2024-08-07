@echo off
REM https://github.com/OpenAPITools/openapi-generator

SET OUTPUT_DIRECTORY=${PWD}/out
SET INTERFACE_DIRECTORY=${PWD}/../..
SET INTERFACE_FILE=proxia-mes_connector_erp-service_v1.yaml
SET PACKAGE_NAME=PAG.Mes.Connector.ERPService.ControllerStub
SET INTERFACE_VERSION=1.0.9

powershell Remove-Item %OUTPUT_DIRECTORY% -Recurse -Force -ErrorAction SilentlyContinue
REM generate
powershell docker run --rm -v %OUTPUT_DIRECTORY%:/out -v %INTERFACE_DIRECTORY%:/specs openapitools/openapi-generator-cli:v5.3.0 generate -i specs/%INTERFACE_FILE% -o /out -g aspnetcore --additional-properties aspnetCoreVersion=5.0,buildTarget=library,operationModifier=abstract,packageName=%PACKAGE_NAME%,packageVersion=%INTERFACE_VERSION%,enumValueSuffix=,removeEnumValuePrefix=false || goto :error
REM build
powershell docker run -it --rm -p 5000:5000 -v %OUTPUT_DIRECTORY%:/out mcr.microsoft.com/dotnet/sdk:5.0 dotnet build -v q /out  || goto :error

echo SUCCESS!
goto :EOF

:error
echo ERROR!


