#!/bin/bash
#
source scripts/install-requirements.sh
source scripts/capi-vars.sh

if [ -x "$(command -v docker)" ]; then
  echo "Skipping docker installation because it's already installed."
else
  installDocker
fi

if [ -x "$(command -v az)" ]; then
  echo "Skipping Azure CLI installation because it's already installed."
else
  installAzureCLI
fi

az vm create --name $PROJECT_NAME \ 
  --resource-group $PROJECT_NAME \
  --admin-username grgouveia \
  --assign-identity $USER_ASSIGNED_IDENTITY_ID \
  --authentication-type ssh \
  --size $AZURE_CONTROL_PLANE_MACHINE_TYPE \
  --ssh-key-values ~/.ssh/guirgouveia.pub \
  --image UbuntuLTS \
  --location $AZURE_LOCATION \
  --role Contributor \
  --scope $SUBSCRIPTION_ID


