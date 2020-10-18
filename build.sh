#!/usr/bin/env bash
# Usage:
#   ./build.sh ./Dockerfile
DOCKERFILE=$1


CONTEXT="$(dirname "${BASH_SOURCE[0]}")"

REPO=behnoosh/tf-cpp-base
ARCH=amd64
TIME=$(date +%Y%m%d_%H%M)

TAG="${REPO}:master-${ARCH}"

# Fail on first error.
set -e
docker build --network=host -t ${TAG} -f ${DOCKERFILE} ${CONTEXT}
echo "Built new image ${TAG}"
