// Search Service - Bicep module
// Created by - Jan Vidar Elven

@description('The name of the Search Service. It has to be unique.')
param searchServiceName string

@description('The environment (dev, test, prod, ...')
@maxLength(4)
param environment string = 'dev'

@description('The Azure region where all resources in this module should be created')
param location string = resourceGroup().location

@description('A list of tags to apply to the resources')
param resourceTags object

@description('Sku value for the Cognitive Search Service')
@allowed([
  'free'
  'basic'
  'standard'
])
param sku string = 'basic'

resource cognSearch 'Microsoft.Search/searchServices@2022-09-01' = {
  name: searchServiceName
  location: location
  tags: resourceTags
  properties: {
    replicaCount: 1
    partitionCount: 1
    hostingMode: 'default'
    publicNetworkAccess: 'enabled'
  }
  sku: {
    name: sku
  }
}
