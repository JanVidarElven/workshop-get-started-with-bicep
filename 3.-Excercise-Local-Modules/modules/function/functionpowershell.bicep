// Azure Functions - Bicep module
// Created by - Jan Vidar Elven

@description('The name of your application')
param applicationName string

@description('The name of your application')
param functionAppName string

@description('The environment (dev, test, prod, ...')
@maxLength(4)
param environment string = 'dev'

@description('The number of this specific instance')
@maxLength(3)
param instanceNumber string = '001'

@description('The Azure region where all resources in this module should be created')
param location string

@description('An array of NameValues that needs to be added as environment variables')
param environmentVariables array

@description('A list of tags to apply to the resources')
param resourceTags object

@description('The hosting app service plan id for the function app')
param appServicePlanId string

resource functionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  tags: resourceTags
  properties: {
    httpsOnly: true
    serverFarmId: appServicePlanId
    siteConfig: {
      appSettings: union(environmentVariables, [
        
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'powershell'
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ])
      ftpsState: 'FtpsOnly'
      minTlsVersion: '1.2'
    }
  }
  identity: {
    type: 'SystemAssigned'
  }  
}

output application_url string = functionApp.properties.hostNames[0]

