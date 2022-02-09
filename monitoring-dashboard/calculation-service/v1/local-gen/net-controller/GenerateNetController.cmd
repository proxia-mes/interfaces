REM https://github.com/OpenAPITools/openapi-generator

SET OUTPUT_DIRECTORY=${PWD}/out
SET INTERFACE_DIRECTORY=${PWD}/../..
SET INTERFACE_FILE=proxia-mes_monitoring-dashboard_calculation-service_v1.yaml
SET PACKAGE_NAME=PAG.Mes.MonitoringDashboard.CalculationService.ControllerStub
SET INTERFACE_VERSION=1.0.0

powershell Remove-Item %OUTPUT_DIRECTORY% -Recurse -force

powershell docker run --rm -v %OUTPUT_DIRECTORY%:/out -v %INTERFACE_DIRECTORY%:/specs openapitools/openapi-generator-cli:v5.3.0 generate -i specs/%INTERFACE_FILE% -o /out -g aspnetcore --additional-properties aspnetCoreVersion=5.0,newtonsoftVersion=5.0.10,buildTarget=library,operationModifier=abstract,packageName=%PACKAGE_NAME%,packageVersion=%INTERFACE_VERSION%

