#!/bin/bash
set -e

echo "🚀 Startar total ominstallation av Fordonsparkssystemet..."

docker system prune -a --volumes -f || true
sudo apt remove -y docker docker-engine docker.io containerd runc || true
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release git

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

rm -rf ~/fordonspark
cd ~
git clone https://github.com/xclamer69/fordonspark.git
cd fordonspark

docker compose up -d --build

echo "✅ Klart! Frontend på http://SERVER_IP:3000 | Backend på http://SERVER_IP:5000/api/ping"
