#!/bin/bash

# Retrieve IP addresses from Terraform
TEST_SERVER_IP=$(terraform output -raw test_server_ip)
PROD_SERVER_IP=$(terraform output -raw prod_server_ip)

# Create Ansible inventory file
cat <<EOL > inventory_file.yml
all:
  hosts:
    test_server:
      ansible_host: $TEST_SERVER_IP
      ansible_user: ubuntu
    prod_server:
      ansible_host: $PROD_SERVER_IP
      ansible_user: ubuntu
EOL
