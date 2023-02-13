#!/bin/bash
export AZURE_SUBSCRIPTION_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Create an Azure Service Principal and paste the output here
export AZURE_TENANT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export AZURE_CLIENT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export AZURE_CLIENT_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Base64 encode the variables
export AZURE_SUBSCRIPTION_ID_B64="$(echo -n "$AZURE_SUBSCRIPTION_ID" | base64 | tr -d '\n')"
export AZURE_TENANT_ID_B64="$(echo -n "$AZURE_TENANT_ID" | base64 | tr -d '\n')"
export AZURE_CLIENT_ID_B64="$(echo -n "$AZURE_CLIENT_ID" | base64 | tr -d '\n')"
export AZURE_CLIENT_SECRET_B64="$(echo -n "$AZURE_CLIENT_SECRET" | base64 | tr -d '\n')"

# Settings needed for AzureClusterIdentity used by the AzureCluster
export AZURE_CLUSTER_IDENTITY_SECRET_NAME="cluster-identity-secret"
export CLUSTER_IDENTITY_NAME="cluster-identity"
export AZURE_CLUSTER_IDENTITY_SECRET_NAMESPACE="default"

export AZURE_CONTROL_PLANE_MACHINE_TYPE=Standard_B2s
export AZURE_LOCATION=brazilsouth
export AZURE_NODE_MACHINE_TYPE=Standard_B2s
export KUBERNETES_VERSION=1.24.6

export PROJECT_NAME=capz-poc

# Replace standard env variables with the .env file 
source .env
