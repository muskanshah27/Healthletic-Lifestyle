# Healthletic Backend – Deployment Guide & CI/CD Documentation

Healthletic Backend is a Flask-based REST API that is automatically built, containerized, and deployed to a Kubernetes cluster using Docker, GitHub Actions, and Helm.

This repository demonstrates a complete CI/CD workflow:
➡️ Push Code → GitHub Actions builds Docker image → Deploys to Kubernetes cluster (Hetzner via kubeadm)

---

📁 Project Structure

<img width="496" height="670" alt="image" src="https://github.com/user-attachments/assets/012f7994-1c73-4e09-9339-425101adc85d" />
 
 
 Architecture Overview
<img width="440" height="326" alt="image" src="https://github.com/user-attachments/assets/440827b0-2bec-45de-b50e-76f865ac901a" />



---

## 🔧 Tech Stack

| Component | Technology |
|----------|------------|
| Backend | Python Flask |
| Image Build | Docker |
| CI/CD | GitHub Actions |
| Deployment | Helm |
| Kubernetes | kubeadm (Hetzner server) |
| Autoscaling | Horizontal Pod Autoscaler |
| Networking | Port-forward (No CCM/LoadBalancer) |

---

## ⚙️ CI/CD Pipeline Explained

GitHub Actions pipeline (`deploy.yml`) triggers on:

- Push to **main**
- Pull Request to **main**

### 1️ Build Stage

- Checkout source code  
- Generate version tag (`v1`, `v2`, `v3`…)  
- Login to Docker Hub  
- Build Docker image  
- Push to Docker Hub:


### 2️ Deploy Stage

- Load kubeconfig from GitHub Secrets  
- Install Helm  
- Deploy using:


helm upgrade --install healthletic-backend chart/
Wait for rollout

Display pods & services

If successful → Deployment Completed



 Required GitHub Secrets
Secret	Description
DOCKER_USERNAME	Docker Hub username
DOCKER_PASSWORD	Docker Hub Access Token
KUBECONFIG_CONTENT	Entire kubeconfig file content

These are required to:

Push Docker images

Connect CI/CD pipeline to Kubernetes cluster

Deploy Helm charts automatically


# Helm Chart Overview
deployment.yaml

Defines:

Container image

Number of replicas

Resources

Ports

service.yaml

Defines the service (ClusterIP / LoadBalancer).

As Hetzner CCM was not used, LoadBalancer has no external IP → use port-forwarding.

hpa.yaml

Auto-scaling config:

minimum replicas

maximum replicas

CPU target %

values.yaml

Default values:
image:
  repository: muskanshah27/healthletic-backend
  tag: latest

replicaCount: 2

service:
  port: 80


CI/CD overrides the tag dynamically.


Manual Deployment (Optional)

To deploy manually:

./deploy.sh production v5


The script:

Loads kubeconfig

Runs Helm upgrade

Shows rollout status

Displays pods & services




Testing the Deployment
View running pods
kubectl get pods

View services
kubectl get svc

Port-forward service (since no external IP)
kubectl port-forward deployment/healthletic-backend 8000:80

Test API
curl http://127.0.0.1:8000/health


All the screenshot are mentioned in - DEPLOYMENT_GUIDE_.md


This project demonstrates end-to-end CI/CD deployment.
