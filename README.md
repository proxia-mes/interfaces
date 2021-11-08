# Interfaces

The goal of the "proxia-mes/interfaces" repository is the complete documentation of all interfaces inside the new PROXIA-MES architecture. 

# Service types

There are two types of services inside the PROXIA-MES architecture:

+ Asynchronous service (currently not available)
+ Synchronous service

## Asynchronous service

Asynchronous service communication is based on the central Message Broker of the PROXIA-MES architecture. An asynchronous service sends a message with JSON data to a queue/topic of the message broker.  
Two kind of communications are possible:

### 1:1	producer/consumer

A producer sends a message to a queue on the message broker, which is asynchronously fetched by exact one receiver. Data is delivered only in one direction.

### 1:N	publish/subscribe

A publisher sends a message to a queue on the message broker, which is asynchronously fetched by more receivers who has subscribed to this message type. Data is delivered only in one direction.

## Synchronous service

A synchronous service is a HTTP REST service. A client (service consumer) calls a HTTP URL and get immediately response from a service provider. Data can be delivered in both directions.

# Repo directory structure

Complete example structure:

    └───interfaces                                                                   
        ├───...                                                                     
        ├───.github
        │       configuration_configuration-service_v1.yml      
        │       connector_erp-service_v1.yml    
        │       extern_erp_mes-service_v1.yml
        │       ...                                                                 
        ├───configuration                                                                     
        │   └───...                                                                 
        ├───connector                                                                     
        │   ├───...                                                                 
        │   ├───erp-service                                                           
        │   │   └───v1         
        │   │       ├───local-gen                                                  
        │   │       │        GenerateNetController.cmd    
        │   │       └───test                                                     
        │   │              proxia-mes_connector_erp-service_v1.postman_collection.json          
        │   │              nightly-build.postman_environment.json                   
        │   │       proxia-mes_connector_erp-service_v1.yaml             
        │   └───...                                                         
        ├───extern   
        │   ├───...
        │   ├───erp
        │   │   ├───mes-service
        │   │   │   └───v1 
        │   │   │   │   └───local-gen                                                  
        │   │   │   │            GenerateNetClient.cmd                                                      
        │   │   │   │       proxia-mes_connector_erp-service_v1.yaml             
        │   │   └───material-service
        │   │       └───...                                                          
        │   └───...                                                          
        ├───monitoring-dashboard                                                                     
        │   └───...                                                                  
        └───...                                                                    

# Level 0: "interfaces"

On the highest level in the "interfaces" git repository is called "interfaces".

# Level 1: Modules

On the first directory level the internal service providing modules are listed (e.g. connector, monitoring-dashboard, configuration, ...). This are the interfaces that the PROXIA-MES provides for internal use or for external consumer.

    └───interfaces                                                                   
        ├───...                                                                     
        ├───connector                                                                       
        │   └───...                                                                 
        ├───monitoring-dashboard                                                                     
        │   └───...                                                                 
        ├───extern                                                                     
        └───...

##extern directory
All external modules called by our PROXIA-MES system are described in this directory.

## Naming convention
No naming convention, only lowercase with dash

# Level 2: Services

On the second level the provided services are listed (e.g. erp-service, ...).

A service is the REST service provider, which provides different endpoints.

## Naming convention
A service name consist of two parts: An individual, freely selectable service name(lowercase and dash) and the suffix "-service":

`<service-name>-service`

e.g. `gui-service` 

Directory structure:

    └───interfaces                                                                   
        ├───monitoring-dashboard                                                                     
        │   ├───...                                                                 
        │   ├───gui-service                                                           
        │   ├───cache-service                                                          
        │   ├───mes-service                                                        
        │   ├───...                                                                 

# Level 3: Version

On the third level the MAJOR version of a service is notated.

Even if "interfaces" is a git repository, we are not using git versioning for the major version, if a service has a new version of the service is created as directory (v1→v2).

Note: All non-breaking-change (minor or bugfix) are documented inside the OpenAPISpec-Definition at the version tag (see Versioning)

## Naming convention
At any context a service is versioned by a prefix lowercase "v" and an integer number:
v<versionNumber>

e.g. v1 or v2

    └───interfaces                                                                   
        ├───asdm                                                                     
        │   ├───gui-service                                                           
        │   │   └───v1                                                               
        │   │   └───v2                                                               
        │   ├───cache-service                                                          
        │   │   └───v1

# Level 4: Service definitions

Inside the version folder the service definition has to be placed.

A service definition is done by an OpenAPI-Spec yaml document.

## Naming convention
The yaml filename must contain the module name, the service name and the version, separated by underscore:

`<scope>_<moduleName>_<serviceName>_<version>.yaml`

e.g. `proxia-mes_monitoring-dashboard_gui-service_v1.yaml`

### `<scope>`

The scope specifies if the services where provided by the PROXIA-MES system or a external system.
Possible values are "proxia-mes" or "extern"

### `<moduleName>`

Name of the module, must be the same as the directory name of the module


### `<serviceName>`

Name of the service, must be the same as the directory name of the service


### `<version>`

Version of the service, must be the same as the directory name of the version

### `.yaml`

The OpenAPI-Spec must have the extension ".yaml"

## "test" directory
Parallel to the definition of the service must be a directory containing the test specifications for all internal services. For external services a directory can be created for all the testing specifications but it is optional.

### Postman tests
For testing a service a tool called Postman is used. Postman test specifications are stored in the json-format.

#### Naming convention
Spec files:

`<scope>_<moduleName>_<serviceName>_<version>.postman_collection.json`

e.g. `proxia-mes_connector_erp-service_v1.postman_collection.json`

The json filenames are equal to the OpenAPI-Spec yaml filenames, followed by ".postman_collection.json"

Environment files:

`<action-name>.postname_environment.json`

e.g. nightly-build.postman_environment.json

The GitHub Action Name used this environment (see [CI/CD](#CI/CD))

## "local-gen" directory
There can be a "local-gen" directory for running the OpenAPI generator process locally for tests (see [Local](#Local))

# CI/CD

## OpenAPI Generator
With the OpenApiSpec Controllers and Clients can be created with the OpenAPI Generator:
https://github.com/OpenAPITools/openapi-generator

The generator generates for all endpoints suitable controller or an api classes and it generates model classes for all datastructures defined in the OpenAPI-Spec.
So now code has to be written by hand for doing a rest communication no matter if it is a service provider or a service consumer.
This saves a lot of time when the service interface is changing.

It is possible to generate Controller and Clients for different programming languages and platforms, e.g.

###C#-Controllers:
https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/aspnetcore.md

###C#-Clients
https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/csharp-netcore.md

###TS-Angular-Clients
https://github.com/OpenAPITools/openapi-generator/blob/master/docs/generators/typescript-angular.md

##Use Generator

### GitHub Actions

The generator is called inside GitHub Workflows called Actions. GitHub Actions are well documented:
https://docs.github.com/en/actions

####.github/workflows

For every OpenAPI-Spec in the interfaces directory a GitHub Action Job can be created for generating the classes.
This is done by storing a GitHub Action yaml in the directory '.github/workflows'.

#### Naming convention
`<scope>_<moduleName>_<serviceName>_<version>.yml`

e.g. `proxia-mes_connector_erp-service_v1.yml`

The GitHub Action filename is equal to the OpenAPI-Spec yaml filename.

#### Description
How GitHub Action is working and how the exact build is working can be seen in the existing Action Scripts.

#### Rules
##### GitHub Action Name
The display name specified in the GitHub Actions files must follow the naming convention:

`name: <scope>_<moduleName>_<serviceName>_<version>`

e.g. `name: proxia-mes_connector_erp-service_v1`

### Use the generated Artifacts
Once a Artifact is generated (for C# the (.dll) libs, is added to the GitHub Nuget Repository, for Typescript the npm-package ist added to the GitHub npm registry), you can use this libs as any other resource.

#### 1. C# .Net
Add nuget resource to your .NET project

    dotnet nuget add source --username <USERNAME> --password <PERSONAL_ACCESS_TOKEN> --store-password-in-clear-text --name github "https://nuget.pkg.github.com/proxia-mes/index.json"

Reference you generated lib in your *.csproj file:

    <PackageReference Include="PAG.Mes.Connector.ERPService.ControllerStub" Version="1.0.8" />
    <PackageReference Include="PAG.Mes.Extern.ERP.Client" Version="1.0.5" />

Run `dotnet restore`


#### 2. Typescript

Login to GitHub npm registry:

    npm config set strict-ssl false
    npm login --scope=@proxia-mes --registry=https://npm.pkg.github.com
    Username: <USERNAME>
    Password: <PERSONAL_ACCESS_TOKEN>
    Email: (this IS public) info@proxia.com
    Logged in as <USERNAME> to scope @proxia-mes on https://npm.pkg.github.com/.`

Reference your package in the package.json:
    
        "@proxia-mes/monitoring-dashboard-gui-service-api": "^1.0.24",

Run `npm install`


### Local
The artifact of a GitHub Action run is directly stored to the corresponding online GitHub Repository (e.g. Nuget repository or npm registry).
For controlling and testing the generation process and have a look at the generated sources, it is possible to run the generation local on your machine to see what happens.

#### local-gen
You can place a local generation script in the local-gen directories:

    └───interfaces                                                                   
        ├───...                                                                     
        ├───connector                                                                     
        │   ├───...                                                                 
        │   ├───erp-service                                                           
        │   │   └───v1         
        │   │       ├───local-gen                                                  
        │   │       │        GenerateNetController.cmd    
        │   │       └───test                                                     
        │   │              proxia-mes_connector_erp-service_v1.postman_collection.json          
        │   │              nightly-build.postman_environment.json                   
        │   │       proxia-mes_connector_erp-service_v1.yaml             
        │   └───...                                                         

There a several examples now available which generates the Code with a Docker Build environment.

!!! Please don't check in your local generated source code.

# OpenAPI Specification

The OpenAPI Specification is well documented at: https://swagger.io/specification/

As editor with SwaggerUI support, you can either use: https://editor.swagger.io/

Or your IDE has an integrated OpenAPI support, e.g. Rider or Visual Studio Code

## Rules

### Naming conventions

####  1. Title
The title of an internal API should always follow the naming convention:
`PROXIA-MES <Module name> <Service name> API`

e.g. 
`PROXIA-MES Monitoring-Dashboard GUI-Service API`

####  2. Description
If no text description available use title

####  3. Version
A OpenAPI Spec has always semantic versioning, e.g. 1.0.1

#### 4. Server URL
Because some tools have problems with relative URLs it is recommend to specify an absolute URL with dummy localhost and no https. 
This is not a problem because the URL of the specification is not a binding part.

Naming convention: 

`http://localhost:8080/proxia-mes/<module-name>/<service-name>/<version-number>`

#### Example

    openapi: 3.0.3
    info:
      title: PROXIA-MES Monitoring-Dashboard GUI-Service API
      description: PROXIA-MES Monitoring-Dashboard GUI-Service API
      version: '1.0.25'
    servers:
      - url: "http://localhost:8080/proxia-mes/monitoring-dashboard/gui-service/v1"

### Inheritance, schema combination
Avoid `oneOf`, `anyOf`, `allOf`, `not`!!!

https://swagger.io/docs/specification/data-models/oneof-anyof-allof-not/

This elements are very critical since the first days (beginning with JsonSchema 1.0.0). Tool support is not available and if then the implementation is quit buggie.

### Separate api and model
Because of the tooling support, it is recommend to separate the api and the model.
So in your endpoint-definition just place reference to the model and do not specify model data in the "paths" section.

    paths:
      "/dashboards":
        get:
          tags:
            - dashboard
          summary: returns all dashboards for a user
          parameters:
            - name: userId
              in: query
              required: true
              style: form
              schema:
                $ref: "#/components/schemas/userId"
          responses:
            '200':
              description: OK
              content:
                application/json:
                  schema:
                    $ref: "#/components/schemas/dashboards"
            '204':
              description: No Content
              content: { }
            '400':
              description: Bad Request
              content: { }
            '401':
              description: Unauthorized
              content: { }
            '403':
              description: Forbidden
              content: { }
            '500':
              description: Internal Server Error
              content: { }

