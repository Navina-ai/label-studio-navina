#!/bin/bash

cd "$(dirname "$0")"

export DOCKER_BUILDKIT=1

IMAGE_NAME="label_studio_navina"
ECR_REPO="153975004783.dkr.ecr.us-east-1.amazonaws.com/${IMAGE_NAME}"
TAG="latest"

echo "Logging in to ECR..."
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 153975004783.dkr.ecr.us-east-1.amazonaws.com

aws ecr describe-repositories --repository-names "${IMAGE_NAME}" --region us-east-1 >/dev/null 2>&1 \
  || aws ecr create-repository --repository-name "${IMAGE_NAME}" --region us-east-1

echo "Building and pushing multi-architecture image to ECR..."
docker buildx create --use
docker buildx build --no-cache --platform linux/amd64,linux/arm64 \
    --provenance=false --sbom=false \
    -t ${ECR_REPO}:${TAG} \
    --push .
