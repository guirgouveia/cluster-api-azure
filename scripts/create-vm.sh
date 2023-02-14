#!/bin/bash
#

function installAzureCLI {
  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
}

function installDocker { 
  sudo apt-get remove docker docker-engine docker.io containerd run
  sudo apt-get update
  sudo apt-get install \
      ca-certificates \
      curl \
      gnupg \
      lsb-release
  sudo mkdir -m 0755 -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}



source scripts/capi-vars.sh

if [ -x "$(command -v docker)" ]; then
  echo "Skipping docker installation."
else
  installDocker
fi

az vm create --name $PROJECT_NAME \ 
  --resource-group $PROJECT_NAME \
  --admin-username grgouveia \
  --assign-identity $USER_ASSIGNED_IDENTITY_ID \
  --authentication-type ssh \
  --size $AZURE_CONTROL_PLANE_MACHINE_TYPE \
  --ssh-key-values ~/.ssh/guirgouveia.pub \
  --image UbuntuLTS \
  --location $AZURE_LOCATION

