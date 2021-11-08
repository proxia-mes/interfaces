REM https://github.com/OpenAPITools/openapi-generator

SET OUTPUT_DIRECTORY=${PWD}/out
SET INTERFACE_DIRECTORY=${PWD}/../../v1
SET INTERFACE_FILE=xi-mes_monitoring-dashboard_gui-service_v1.yaml
SET PACKAGE_NAME=@proxia-mes/monitoring-dashboard-gui-service-api

powershell Remove-Item %OUTPUT_DIRECTORY% -Recurse -force

powershell docker run --rm -v %OUTPUT_DIRECTORY%:/out -v %INTERFACE_DIRECTORY%:/specs openapitools/openapi-generator-cli generate -i specs/%INTERFACE_FILE% -o /out -g typescript-angular --additional-properties npmName=%PACKAGE_NAME%,stringEnums=true

