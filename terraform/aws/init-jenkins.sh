#!/bin/bash

# Update and install dependencies
sudo yum update -y
sudo yum install -y wget curl git

# Install Java first (required for Jenkins)
echo "Installing Java..."
sudo amazon-linux-extras enable corretto11  # Enable Corretto 11
sudo yum install -y java-17-amazon-corretto

# Install Jenkins
echo "Installing Jenkins..."
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y  # Ensure Jenkins repository is up to date
sudo yum install -y jenkins

# Install Docker
echo "Installing Docker..."
sudo yum install -y docker
sudo service docker start
sudo systemctl enable docker

# Add Jenkins to Docker group
sudo usermod -a -G docker jenkins

# Start Jenkins service
echo "Starting Jenkins..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Install kubectl
echo "Installing kubectl..."
sudo curl -LO https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.2/2024-11-15/bin/linux/amd64/kubectl
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Output completion message
echo "Jenkins, Docker, Git, and kubectl have been successfully installed and started."
