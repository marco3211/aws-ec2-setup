#!/bin/bash

# Update the package list
echo "Updating package list..."
sudo apt-get update

# Install software-properties-common to manage PPAs
echo "Installing software-properties-common..."
sudo apt-get install -y software-properties-common

# Add Ansible PPA
echo "Adding Ansible PPA..."
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Update the package list again after adding the PPA
echo "Updating package list after adding Ansible PPA..."
sudo apt-get update

# Install Ansible
echo "Installing Ansible..."
sudo apt-get install -y ansible

# Verify the installation
echo "Verifying Ansible installation..."
ansible --version

echo "Ansible and Ansible Playbook have been installed successfully."
