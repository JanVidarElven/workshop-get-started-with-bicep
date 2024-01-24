// Log Analytics Workspace - Bicep module
// Created by - Jan Vidar Elven

@description('The name of your application')
param orgIdentifier string = 'YourOrgIdentifier'

@description('The name of your application')
param applicationName string

@description('The environment (dev, test, prod, ...')
@maxLength(4)
param environment string = 'dev'

@description('The Azure region where all resources in this example should be created')
param location string

@description('A list of tags to apply to the resources')
param resourceTags object

resource logWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: 'log-ws-${orgIdentifier}-${applicationName}'
  location: location
  tags: resourceTags
  properties: {
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    publicNetworkAccessForIngestion: 'enabled'
    publicNetworkAccessForQuery: 'enabled'
    retentionInDays: 365
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
  }
}
