ygvygvczvbwerg#!/bin/bash

# Create a user and group for the CI/CD process
groupadd mygroup
useradd -g mygroup myuser

# Install Docker and Docker Compose
apt-get update
apt-get install -y docker.io docker-compose

# Configure Docker to run without sudo
usermod -aG docker myuser

# Set up a private Docker registry
docker run -d -p 5000:5000 --restart=always --name registry registry:2

# Enable Docker registry API v2
echo '{ "insecure-registries": ["18.206.172.224:5000"] }' > /etc/docker/daemon.json
systemctl restart docker

# Provide necessary permissions for the registry
chown -R myuser:mygroup /var/lib/docker

# Print Docker and Docker Compose versions
echo "Docker version: $(docker --version)"
echo "Docker Compose version: $(docker-compose --version)"

