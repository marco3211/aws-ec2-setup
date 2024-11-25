#!/bin/bash

# Update the package list and install prerequisites
echo "Updating package list and installing prerequisites..."
sudo apt-get update -y
sudo apt-get install -y gnupg software-properties-common curl

# Add the HashiCorp GPG key
echo "Adding HashiCorp GPG key..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add the HashiCorp repository
echo "Adding HashiCorp repository..."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update the package list again
echo "Updating package list..."
sudo apt-get update -y

# Install Terraform
echo "Installing Terraform..."
sudo apt-get install -y terraform

# Verify the installation
echo "Verifying Terraform installation..."
terraform -version

echo "Terraform installation completed successfully."
