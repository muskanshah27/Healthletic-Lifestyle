# Healthletic Backend – Flask API with Automated CI/CD Deployment (Docker + GitHub Actions + Kubernetes + Helm)

The **Healthletic Backend** is a containerized Flask REST API that demonstrates modern DevOps practices using **Docker**, **GitHub Actions CI/CD**, and **Kubernetes (kubeadm on Hetzner)**.  
Every code push triggers a fully automated workflow:

➡️ Build Docker Image → Push to Docker Hub → Deploy to Kubernetes via Helm.

This project is part of an assignment demonstrating infrastructure automation, deployment pipelines, and Kubernetes management.

---

#  1. Project Brief

The Healthletic backend provides a simple Flask API endpoint (e.g., `/health`) but focuses mainly on:

- CI/CD automation using **GitHub Actions**
- Image packaging using **Docker**
- Automated deployment using **Helm** + **Kubernetes**
- Deployment visibility using rollout commands
- Running Kubernetes workloads on a Hetzner server created with **kubeadm**

This document explains how to set up the environment, deploy the project, and troubleshoot issues.

---

#  2. Getting Started / Setup Instructions

Below are **exact copy-paste commands** for setting up and running the project locally.

---

##  2.1 Clone the Repository


git clone https://github.com/muskanshah27/healthletic-backend.git
cd healthletic-backend

(reuired things)
2.2 Local Development Setup
python

2.3 Run Local Tests
If your test suite exists, run: pytest -v
(If tests folder is empty, keep this section for future development.)


2.4 Environment Variables (Optional)

Create a .env file (if your app grows later):
FLASK_ENV=development
PORT=5000


Load env variables:
export $(cat .env | xargs)


3. Usage Instructions
3.1 Triggering the CI/CD Pipeline

The CI/CD pipeline runs automatically on:

Pushing to main branch

Creating a Pull Request → main

Simply run:

git add .
git commit -m "update"
git push origin main


GitHub Actions will automatically:

Build Docker image

Push to Docker Hub

Deploy to Kubernetes using Helm

3.2 How to Monitor CI/CD Pipeline
GitHub Actions UI:
GitHub Repo → Actions → deploy.yml



You can see:

Image build logs

Helm deployment logs

Pod rollout status



3.3 How to Access Deployed Application

in my case Kubernetes LoadBalancer was not available (Hetzner without CCM), so i use port-forwarding:
kubectl port-forward deployment/healthletic-backend 8000:80


Then open:
http://127.0.0.1:8000/health (scrennshot are added in DGEPLOYMENT_GUIDE_.md)


3.4 View Kubernetes Logs
kubectl logs deployment/healthletic-backend

Check pod status:
kubectl get pods


Check service:
kubectl get svc


4. Contribution Guidelines (things things can be done, although i have added but adding to tell in know it)
4.1 Branching Strategy

main → production-ready code

feature/ → new features

fix/ → bug fixes

Example: git checkout -b feature/new-endpoint


4.2 Pull Request Process

Create a feature branch

Commit your changes

Push branch

Open a Pull Request

Reviewer approves

Code merges → CI/CD triggers automatically

4.3 Code Style Guidelines

Follow PEP8 for Python

Use meaningful variable names

Keep functions small and readable

Add comments where needed

4.4 Reporting Issues

Report issues via:
GitHub Repo → Issues → New Issue
Provide:

Description

Steps to reproduce

Logs/screenshots


5. Troubleshooting & Support

Issue: ImagePullBackOff

Cause: Wrong Docker tag or missing image.

Fix:docker pull muskanshah27/healthletic-backend:<tag>

Issue: Pods not starting (CrashLoopBackOff)

View logs: kubectl logs deployment/healthletic-backend

Issue: LoadBalancer shows <pending>

Hetzner cluster created via kubeadm does not support LoadBalancer unless CCM is installed.

Use:kubectl port-forward deployment/healthletic-backend 8000:80

Issue: Helm deployment failed
helm uninstall healthletic-backend
helm upgrade --install healthletic-backend chart/


Support

If you're stuck, you can:

Open a GitHub Issue

Contact the repository maintainer

Check Kubernetes logs

Re-run GitHub Actions pipeline to inspect logs

so in this way i have complete this project

