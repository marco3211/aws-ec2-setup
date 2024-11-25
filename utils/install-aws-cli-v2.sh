#!/bin/bash

# Update the package list
echo "Updating package list..."
sudo apt-get update

# Install required dependencies
echo "Installing required dependencies..."
sudo apt-get install -y unzip curl

# Download the AWS CLI V2 installation package
echo "Downloading AWS CLI V2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the package
echo "Unzipping AWS CLI V2 package..."
unzip awscliv2.zip

# Run the install script
echo "Installing AWS CLI V2..."
sudo ./aws/install

# Verify the installation
echo "Verifying AWS CLI V2 installation..."
aws --version

# Clean up
echo "Cleaning up..."
rm -rf awscliv2.zip aws

echo "AWS CLI V2 installation completed successfully."
