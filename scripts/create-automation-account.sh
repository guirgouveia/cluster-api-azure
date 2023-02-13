#!/bin/bash 

source .env

az automation account create --automation-account-name "$PROJECT_NAME" --location "$LOCATION" --sku "Free" --resource-group "$RESOURCE_GROUP" --subscription "$SUBSCRIPTION_ID" --verbose
test="test"
# Assign User Assigned Identity to Automation Account using Azure REST API
URI="https://management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Automation/automationAccounts/$PROJECT_NAME\`?api-version=2020-01-13-preview"
FIRST_IDENTITY="/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.ManagedIdentity/userAssignedIdentities/firstIdentity"
body="$(jq --null-input \
  --arg firstIdentity "$FIRST_IDENTITY" \
  --arg userAssignedIdentity "$USER_ASSIGNED_IDENTITY_ID" \
  '{ "identity": {"type": "UserAssigned", "userAssignedIdentities": { ($firstIdentity): $userAssignedIdentity }}}' | tr '\n' ' ' | sed 's/"/\\"/g' | sed 's/\ //g')"
echo $body

TOKEN=`az account get-access-token --resource=https://management.azure.com --query accessToken --output tsv`
if [ $? != 0 ]; then
  echo "You need to be authenticated to Azure. Run az login."
fi

contentTypeHeader="-H 'Content-Type: application/json'"
authorizationBearer="-H 'Authorization: Bearer $TOKEN'"
set -x; 
curl -X PATCH "\'$URI\'" \
  -d $body  \
  -H "'Content-Type application/json'" \
  -H "'Authorization: Bearer '"$TOKEN"'"
set +x;
