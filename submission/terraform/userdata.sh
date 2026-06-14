#!/bin/bash

set -e  # stop script if any command fails

# -------------------------------
# UPDATE SYSTEM
# -------------------------------
apt-get update -y

# -------------------------------
# INSTALL DOCKER
# -------------------------------
apt-get install -y docker.io

# -------------------------------
# ENABLE DOCKER SERVICE
# -------------------------------
systemctl enable docker
systemctl start docker

# -------------------------------
# ADD UBUNTU USER TO DOCKER GROUP
# -------------------------------
groupadd docker || true
usermod -aG docker ubuntu

# IMPORTANT: apply docker permissions for this script session
newgrp docker

# -------------------------------
# VERIFY DOCKER WORKS
# -------------------------------
docker version

# -------------------------------
# PULL IMAGES
# -------------------------------
docker pull saim2026/e-commercestore:frontend-service-v1
docker pull saim2026/e-commercestore:user-service-v1
docker pull saim2026/e-commercestore:product-service-v1
docker pull saim2026/e-commercestore:order-service-v1
docker pull saim2026/e-commercestore:cart-service-v1

# -------------------------------
# REMOVE OLD CONTAINERS IF THEY EXIST (SAFE RUN)
# -------------------------------
docker rm -f frontend user product order cart || true

# -------------------------------
# RUN CONTAINERS
# -------------------------------
docker run -d --name frontend -p 3000:3000 saim2026/e-commercestore:frontend-service-v1

docker run -d --name user -p 3001:3001 saim2026/e-commercestore:user-service-v1

docker run -d --name product -p 3002:3002 saim2026/e-commercestore:product-service-v1

docker run -d --name order -p 3003:3003 saim2026/e-commercestore:order-service-v1

docker run -d --name cart -p 3004:3004 saim2026/e-commercestore:cart-service-v1
