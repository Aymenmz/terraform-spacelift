#!/bin/bash


# Update the package list
sudo apt-get update && \
# Install Docker dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
# Add the Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
# Update the package list (again)
sudo apt-get update && \
# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io && \
# Add the current user to the docker group
sudo usermod -aG docker $USER
