// Application Insights - Bicep module
// Created by - Jan Vidar Elven

@description('The name of your application')
param applicationName string

@description('The environment (dev, test, prod, ...')
@maxLength(4)
param environment string = 'dev'

@description('The Azure region where all resources in this module should be created')
param location string

@description('A list of tags to apply to the resources')
param resourceTags object

@description('The number of this specific instance')
@maxLength(3)
param instanceNumber string = '001'

@description('The name of the application insights to create. Max 24 characters.')
param appInsightsResourceName string

resource appInsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: appInsightsResourceName
  location: location
  tags: resourceTags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    SamplingPercentage: json('100.0')
    IngestionMode: 'ApplicationInsights'
  }
}

output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey

