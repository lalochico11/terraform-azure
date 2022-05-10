#!/bin/bash
site=$(terraform output -json | jq -r '.url.value')
webapp=$(terraform output -json | jq -r '.name.value')
resourceGroup=$(terraform output -json | jq -r '.resource_group_name.value')

# Deploy code to "production" slot from GitHub.
# az webapp deployment source config --name $webapp --resource-group $resourceGroup \
#   --repo-url https://github.com/Azure-Samples/html-docs-hello-world \
#   --branch master --manual-integration

echo "Deploying Code to Staging Slot for Web App Service $webapp"
# Deploy code to "staging" slot from GitHub.
az webapp deployment source config --name $webapp --resource-group $resourceGroup \
  --slot staging --repo-url https://github.com/Azure-Samples/html-docs-hello-world \
  --branch master --manual-integration

# az webapp deployment source config --name my-app-hello-world \
#   --resource-group demo-resources --slot staging --repo-url https://github.com/Azure-Samples/html-docs-hello-world \
#   --branch master --manual-integration

echo "Swap Code from Staging Slot into Production for Web App Service $webapp"
# Swap the verified/warmed up staging slot into production.
az webapp deployment slot swap --name $webapp --resource-group $resourceGroup --slot staging

