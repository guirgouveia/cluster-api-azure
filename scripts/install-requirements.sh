
function installKubectl {
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
}

function installCAPI {
  curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/v1.3.3/clusterctl-linux-amd64 -o clusterctl
  sudo install -o root -g root -m 0755 clusterctl /usr/local/bin/clusterctl
}

function installAzureCLI {
  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
}

function installDocker { 
  sudo apt-get -y remove docker docker-engine docker.io containerd run
  sudo apt-get update -y
  sudo apt-get install -y \
      ca-certificates \
      curl \
      gnupg \
      lsb-release
  sudo mkdir -m 0755 -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update -y
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  sudo apt-get update -y 
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
 sudo usermod -aG docker $USER

}
