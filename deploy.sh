#!/bin/bash
set -e

ENV=$1
VERSION=$2

if [ -z "$ENV" ] || [ -z "$VERSION" ]; then
  echo "Usage: ./deploy.sh <environment> <version>"
  exit 1
fi

echo "Deploying version $VERSION to $ENV environment..."

# Ensure kubeconfig path exists
mkdir -p ~/.kube
echo "$KUBECONFIG_CONTENT" > ~/.kube/config

IMAGE_REPOSITORY="muskanshah27/healthletic-backend"

helm upgrade --install healthletic-backend chart/ \
  --set image.repository=$IMAGE_REPOSITORY \
  --set image.tag=$VERSION \
  --wait

kubectl get pods
kubectl get svc
