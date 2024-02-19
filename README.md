# gcp-on-iac
My GCP homelab defined by Terraform and Ansible. 

Currently Terraform will provision a Debian Spot VM with a L4 GPU; access is restricted only to my client IP. Ansible installs NVIDIA proprietary driver. 

## How to use
Create new project on GCP or use existing project.

Create Service Account with Editor permissions and download Key as credentials.json

Run ```run-iac.sh```

## Result

You will have a Debian 11 VM with a GPU and NVIDIA driver installed, ready for ML workloads.

## To Do

Create variables for: project name, client IP

![GCP drawio](https://github.com/AngelGarzaDev/gcp-on-iac/assets/70922156/5f2e0fd1-e917-4bfd-a35b-054b039e0ae9)
