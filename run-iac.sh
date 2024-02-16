#!/bin/bash

terraform apply

ansible-playbook mlworkloads.yaml -i hosts 