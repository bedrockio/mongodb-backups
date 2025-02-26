#!/bin/sh

set -e

# Install required dependencies
apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg \
    curl

# Ensure GPG is installed before using it
command -v gpg >/dev/null 2>&1 || { echo "Installing GPG..."; apt-get install -y gnupg; }

# Add the Google Cloud SDK repo key (dearmor format for Ubuntu 22.04+)
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

# Add the official Google Cloud SDK repository
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
    | tee /etc/apt/sources.list.d/google-cloud-sdk.list

# Update and install Google Cloud SDK
apt-get update && apt-get install -y google-cloud-cli