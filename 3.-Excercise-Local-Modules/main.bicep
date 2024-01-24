
targetScope = 'subscription'

// If an environment is set up (dev, test, prod...), it is used in the application name
param environment string = 'dev'
param applicationName string = 'azure-openai'
param location string = 'westeurope'

// Organization identifier to be used in naming resources
param orgIdentifier string = 'yourorgname'

var defaultTags = {
  Environment: environment
  Application: applicationName
  Dataclassification: 'Confidential'
  Costcenter: 'Operations'
  Criticality: 'Normal'
  Service: 'YourOrg Open AI'
  Deploymenttype: 'Bicep'
  Owner: 'Jan Vidar Elven'
  Business: 'Evidi AS'
}

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${orgIdentifier}-${applicationName}'
  location: location
  tags: defaultTags
}

// Build a storage account name based on the application name with a max length of 24 characters
var storageName = '${orgIdentifier}sa${take(replace(applicationName, 'azure-', ''),14)}copilot'

module blobStorage 'modules/storage-blob/storage.bicep' = {
  name: 'storage'
  scope: resourceGroup(rg.name)
  params: {
    location: location
    applicationName: applicationName
    environment: environment
    resourceTags: defaultTags
    storageName: storageName
  }
}

// Create a Container in the Storage Account for Data
module blobContainer 'modules/storage-blob/container.bicep' = {
  name: 'container'
  scope: resourceGroup(rg.name)
  params: {
    storageAccountName: blobStorage.outputs.storageAccountName
    containerName: 'documents'
  }
}

// Build another OpenAI Service in Central Sweden to Support GPT-4
module openAIServiceSwe 'modules/cognitive-service/ai-service.bicep' = {
  name: 'openai-swe'
  scope: resourceGroup(rg.name)
  params: {
    location: 'swedencentral'
    cognitiveServiceName: 'openai-${orgIdentifier}-copilot-swe'
    environment: environment
    resourceTags: defaultTags
  }
}

// Build a Search Service
module searchService 'modules/cognitive-search/search-service.bicep' = {
  name: 'search'
  scope: resourceGroup(rg.name)
  params: {
    searchServiceName: 'srch-${orgIdentifier}-copilot-documents'
    location: location
    environment: environment
    resourceTags: defaultTags
    sku: 'basic'
  }
}
