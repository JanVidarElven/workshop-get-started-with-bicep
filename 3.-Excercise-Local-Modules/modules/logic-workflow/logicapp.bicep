// Logic App - Bicep module
// Created by - Jan Vidar Elven

@description('The name of your application')
param orgIdentifier string = 'YourOrgIdentifier'

@description('The name of your Logic App')
param logicAppName string

@description('The Azure region where all resources in this module should be created')
param location string

@description('A list of tags to apply to the resources')
param resourceTags object

var frequency = 'Day'
var interval = '5'
var type = 'recurrence'
var workflowSchema = 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'

resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: logicAppName
  location: location
  tags: resourceTags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    definition: {
      '$schema': workflowSchema
      contentVersion: '1.0.0.0'
      parameters: {
        '$connections': {
          defaultValue: {}
          type: 'Object'
        }
      }
      triggers: {
        recurrence: {
          type: type
          recurrence: {
            frequency: frequency
            interval: interval
          }
        }
      }
      actions: {   
      }
    }
    parameters: {
      '$connections': {
        value: {
        }
      }
    }    
  }
}

