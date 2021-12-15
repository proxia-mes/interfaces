REM https://github.com/OpenAPITools/openapi-generator

SET OUTPUT_DIRECTORY=${PWD}/out
SET INTERFACE_DIRECTORY=${PWD}/..
SET INTERFACE_FILE=proxia-mes_comu-db_change-events_v1.yaml
SET PACKAGE_NAME=PAG.Mes.ComuDb.ChangeEvents
SET INTERFACE_VERSION=1.0.0

powershell Remove-Item %OUTPUT_DIRECTORY% -Recurse -force

powershell docker run --rm -v %OUTPUT_DIRECTORY%:/out -v %INTERFACE_DIRECTORY%:/specs openapitools/openapi-generator-cli:v5.3.0 generate -i specs/%INTERFACE_FILE% -o /out -g csharp-netcore --additional-properties targetFramework=net5.0,packageName=%PACKAGE_NAME%,packageVersion=%INTERFACE_VERSION%,enumValueSuffix=,removeEnumValuePrefix=false

