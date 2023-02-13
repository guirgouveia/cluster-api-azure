$resourceGroup=$args[0]
$automationAccount=$args[1]
$subscriptionID=$args[2]
$userAssignedOne=$args[3]

$output = Set-AzAutomationAccount `
    -ResourceGroupName $resourceGroup `
    -Name $automationAccount `
    -AssignUserIdentity "/subscriptions/$subscriptionID/resourcegroups/$resourceGroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/$userAssignedOne", `
        "/subscriptions/$subscriptionID/resourcegroups/$resourceGroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/$userAssignedTwo"

$output

















































