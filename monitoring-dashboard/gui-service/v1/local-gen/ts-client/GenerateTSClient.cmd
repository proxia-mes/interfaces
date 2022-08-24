@echo off
REM https://github.com/OpenAPITools/openapi-generator

SET OUTPUT_DIRECTORY=${PWD}/out
SET INTERFACE_DIRECTORY=${PWD}/../..
SET INTERFACE_FILE=proxia-mes_monitoring-dashboard_gui-service_v1.yaml
SET PACKAGE_NAME=@proxia-mes/monitoring-dashboard-gui-service-api

powershell Remove-Item %OUTPUT_DIRECTORY% -Recurse -Force -ErrorAction SilentlyContinue
REM generate
powershell docker run --rm -v %OUTPUT_DIRECTORY%:/out -v %INTERFACE_DIRECTORY%:/specs openapitools/openapi-generator-cli:v6.0.1 generate -i specs/%INTERFACE_FILE% -o /out -g typescript-angular --additional-properties npmName=%PACKAGE_NAME%,stringEnums=true

