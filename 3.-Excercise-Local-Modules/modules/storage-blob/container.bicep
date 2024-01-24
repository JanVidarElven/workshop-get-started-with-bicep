// Blob Container for Storage Accounts - Bicep module
// Created by - Jan Vidar Elven

@description('The name of your Storage Account to Create a Container')
param storageAccountName string

@description('The name of your Storage Container')
param containerName string

resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = {
  name: '${storageAccountName}/default/${containerName}'
}
