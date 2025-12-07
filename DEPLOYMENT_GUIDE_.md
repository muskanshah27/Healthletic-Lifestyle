Healthletic Backend – Deployment Guide 

This document explains how the CI/CD pipeline works, how the application is deployed, and what is required to run and troubleshoot everything.

1. Project Overview

This project contains a Flask backend API that is:

Containerized using Docker

Pushed to Docker Hub

Automatically deployed to a Kubernetes cluster using Helm

Managed through a CI/CD pipeline created using GitHub Actions

The goal is to automate the entire deployment process from code push → running application in Kubernetes.
(note: here i have use hetzner server and created cluster using kubeadm)

2. Project Structure
healthletic-backend/
│
├── app/                 # Flask application code
│   ├── app.py
│   ├── requirements.txt
│
├── chart/               # Helm chart for Kubernetes deployment
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── deployment.yaml
│       ├── service.yaml
│       ├── hpa.yaml
│
├── Dockerfile           # Docker build instructions
├── deploy.sh            # Manual deployment script
├── .github/workflows/
│   └── deploy.yml       # CI/CD pipeline
└── DEPLOYMENT_GUIDE.md


3. How the CI/CD Pipeline Works

The CI/CD pipeline runs automatically on:

Push to main

Pull Request to main

The pipeline does the following:
Step 1: Build Stage

Pull the latest code

Create a version tag (v1, v2, v3…)

Login to Docker Hub

Build Docker image using the Dockerfile

Push the image to Docker Hub

The image name looks like:
muskanshah27/healthletic-backend:vX


Step 2: Deploy Stage

Load Kubernetes config from GitHub Secret

Install Helm

Deploy the application using:
helm upgrade --install healthletic-backend chart/

Wait for pods to start using:
kubectl rollout status deployment/healthletic-backend

Display pods and services
If everything runs correctly, GitHub Actions shows: Deployment Successful 


4. Required GitHub Secrets

You must add these secrets in your repository:

Secret Name	What It Contains
DOCKER_USERNAME	-Your Docker Hub username
DOCKER_PASSWORD -	Docker Hub Access Token
KUBECONFIG_CONTENT -	The full content of your Kubernetes kubeconfig file

These are needed so GitHub can:

Push images to Docker Hub

Connect to the Kubernetes cluster

Deploy via Helm

5. Helm Chart Overview

The application is deployed using a Helm chart which contains:

deployment.yaml

Defines the Deployment (pods, container image, ports, resources)

service.yaml

Exposes the service (LoadBalancer or ClusterIP)

hpa.yaml

Sets up autoscaling (min/max replicas)

values.yaml

Contains configurable settings like:
image:
  repository: muskanshah27/healthletic-backend
  tag: latest
replicaCount: 2
service:
  port: 80
These values are overridden during CI/CD deployment.

6. Manual Deployment Script

You can deploy manually using: ./deploy.sh <environment> <version>
ex:- ./deploy.sh production v5


The script:

Loads kubeconfig

Runs Helm upgrade

Shows rollout status

Lists pods and services

Useful for manual testing or rollback.


7. How to Test Your Deployment
Check pods
kubectl get pods -n (namespace)  # i have installed in default visible in my screenshot
<img width="822" height="146" alt="image" src="https://github.com/user-attachments/assets/0055d834-b410-4391-875e-e6d8f8b2d44e" />

Check services
kubectl get svc


Test API endpoint
curl http://<EXTERNAL-IP>/health

but here i'm using hetzner account not own by me so i'm not creating CCM where i need to add token
instaed by doing port forward i can get output
<img width="722" height="232" alt="image" src="https://github.com/user-attachments/assets/511f03e1-094c-459b-9a44-24bce2715178" />
<img width="722" height="232" alt="image" src="https://github.com/user-attachments/assets/4cd89f58-1eb0-417f-9cf8-a6933f3dbd43" />



follings are the screenshot of my assignment
my pippelien build
<img width="1818" height="669" alt="image" src="https://github.com/user-attachments/assets/420e0090-f9bc-4650-89d3-42f4e40cb59e" />

mu image build at docker hub
<img width="1848" height="699" alt="image" src="https://github.com/user-attachments/assets/8e72a8e2-81f0-41ae-853c-cc1d1acadda5" />


my pods running and after portforwarding that screen =shot is already atached above
