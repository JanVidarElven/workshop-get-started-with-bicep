// AI Service - Bicep module
// Created by - Jan Vidar Elven

@description('The name of the AI Service. It has to be unique.')
param cognitiveServiceName string

@description('The environment (dev, test, prod, ...')
@maxLength(4)
param environment string = 'dev'

@description('The Azure region where all resources in this module should be created')
param location string

@description('A list of tags to apply to the resources')
param resourceTags object

@description('Sku value for the Cognitive Service')
@allowed([
  'S0'
])
param sku string = 'S0'

@description('Kind of Cognitive Service')
@allowed([
  'OpenAI'
  'CognitiveServices'
  'ComputerVision'
  'CustomVision.Training'
  'CustomVision.Prediction'
  'Face'
  'FormRecognizer'
  'SpeechServices'
  'LUIS'
  'QnAMaker'
  'TextAnalytics'
  'TextTranslation'
  'AnomalyDetector'
  'ContentModerator'
  'Personalizer'
])
param kind string = 'OpenAI'

resource cognitiveService 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: cognitiveServiceName
  location: location
  tags: resourceTags
  sku: {
    name: sku
  }
  kind: kind

  properties: {
    customSubDomainName: cognitiveServiceName
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }  
}
