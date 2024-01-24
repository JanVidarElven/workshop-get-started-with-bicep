targetScope = 'subscription'

//TODO use parameter: param location string = 'norwayeast'
//TODO use variable: var myRgName = 'rg-bicep-demo'

resource myRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-bicep-demo'
  location: 'norwayeast'
}
