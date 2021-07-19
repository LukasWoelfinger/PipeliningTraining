# Setup your demo Pipeline for Microsoft eShopOnWeb

This demo scripts support you to quickly setup your own demo infrastructure for DevOps pipelining trainings without maintain the code. The application deployed is the eShopOnWeb architectural demo from Microsoft. The first version of the demo pipeline deploys the applicaiton with in memory database. Due to this only the Azure WebApplication service is required with its dependencies (app services plan).

## How-To: Install your environment

1. Fork the required projects to your gitHub:
   - [PipelineTraining](https://github.com/LukasWoelfinger/PipeliningTraining)
   - [eShopOnWeb tested](https://github.com/LukasWoelfinger/eShopOnWeb) Or the original [eShopOnWeb original](https://github.com/dotnet-architecture/eShopOnWeb)
2. Create a new demo project
3. Create a new YAML pipeline from gitHub
   - Connect the project to your gitHub
   - Grant access to both project repositories
   - Select YAML file from Demos/MS_eShopOnWeb/eWebShop_CICD.yml
4. Update YAML file repository connection information (see todos in YAML)
5. Setup variables mentioned in YAML file
   | Variable | example value |
   |-----|-----|
   | location | 'westeurope' |
   | tf*rgstorage | 'rg-Storage'|
   | tf_storageaccount | 'terraformstatestorage'|
   | tf_storagecontainer | 'terraform'|
   | tf_applicationname | 'lwpulterraformweb'|
   | tf_environmentname | 'Test' or 'Dev' #REMARK: prefix "tf*" required to prevent web.config manipulations from dotnet build CLI (parameter --environmentname exists here to setup ASPNETCORE_ENVIRONMENT)|
   | tf_storagekey | 'WillBeSetWhileRuntime' <-- DO NOT store the real key here! It will be determined by the pipeline itself at runtime.# BuildConfiguration: e.g. debug|
   | configuration | debug # Remark this will set the --configuration parameter of dotnet CLI (hidden feature)|
   | subscriptionid | GUID of subscription|
6. Run the pipeline
