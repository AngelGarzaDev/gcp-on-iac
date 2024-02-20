#!/bin/bash

terraform apply

ansible-playbook playbook.yaml -i hosts 