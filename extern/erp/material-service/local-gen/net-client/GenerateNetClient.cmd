REM https://github.com/OpenAPITools/openapi-generator

SET OUTPUT_DIRECTORY=${PWD}/out
SET INTERFACE_DIRECTORY=${PWD}/../../v1
SET INTERFACE_FILE=extern_erp_material-service_v1.yaml
SET PACKAGE_NAME=PAG.Mes.ERP.Material.Client
SET INTERFACE_VERSION=1.0.0

powershell Remove-Item %OUTPUT_DIRECTORY% -Recurse -force

powershell docker run --rm -v %OUTPUT_DIRECTORY%:/out -v %INTERFACE_DIRECTORY%:/specs openapitools/openapi-generator-cli generate -i specs/%INTERFACE_FILE% -o /out -g csharp-netcore --additional-properties targetFramework=net5.0,packageName=%PACKAGE_NAME%,packageVersion=%INTERFACE_VERSION%,enumValueSuffix=,removeEnumValuePrefix=false

