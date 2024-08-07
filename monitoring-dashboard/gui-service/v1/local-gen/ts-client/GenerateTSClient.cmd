@echo off
REM https://github.com/OpenAPITools/openapi-generator

SET OUTPUT_DIRECTORY=${PWD}/out
SET INTERFACE_DIRECTORY=${PWD}/../..
SET INTERFACE_FILE=proxia-mes_monitoring-dashboard_gui-service_v1.yaml
SET PACKAGE_NAME=@proxia-mes/monitoring-dashboard-gui-service-api

REM clear output directory
powershell Remove-Item %OUTPUT_DIRECTORY% -Recurse -Force -ErrorAction SilentlyContinue
powershell New-Item -Path %OUTPUT_DIRECTORY% -ItemType "directory"

REM get interface version
powershell (Select-String -Path %INTERFACE_DIRECTORY%/%INTERFACE_FILE% -Pattern 'version:.+''(.+)''').Matches[0].Groups[1].Value > out/version
SET /P INTERFACE_VERSION=<out/version
echo Interface-Version: %INTERFACE_VERSION%

REM generate
powershell docker run --rm -v %OUTPUT_DIRECTORY%:/out -v %INTERFACE_DIRECTORY%:/specs openapitools/openapi-generator-cli:v6.0.1 generate -i specs/%INTERFACE_FILE% -o /out -g typescript-angular --additional-properties npmName=%PACKAGE_NAME%,stringEnums=true

REM Create and publish the npm package to global
cd out
call npm install --all --force
call npm run build
cd dist
call npm pack

