REM https://github.com/OpenAPITools/openapi-generator

SET OUTPUT_DIRECTORY=${PWD}/out
SET INTERFACE_DIRECTORY=${PWD}/../../v1
SET INTERFACE_FILE=monitoring-dashboard-gui-service-v1.yaml
SET PACKAGE_NAME=PAG.Mes.MonitoringDashboard.GuiService.ControllerStub
SET INTERFACE_VERSION=1.0.1

powershell Remove-Item %OUTPUT_DIRECTORY% -Recurse -force

powershell docker run --rm -v %OUTPUT_DIRECTORY%:/out -v %INTERFACE_DIRECTORY%:/specs openapitools/openapi-generator-cli generate -i specs/%INTERFACE_FILE% -o /out -g aspnetcore --additional-properties aspnetCoreVersion=5.0,buildTarget=library,operationModifier=abstract,packageName=%PACKAGE_NAME%,packageVersion=%INTERFACE_VERSION%

