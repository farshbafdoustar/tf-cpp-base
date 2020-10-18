#!/bin/bash
# Usage:
#   ./run.sh 


CONTEXT="$(dirname "${BASH_SOURCE[0]}")"

NAME=tf-cpp-base
REPO=behnoosh/${NAME}
ARCH=amd64
TIME=$(date +%Y%m%d_%H%M)

TAG="${REPO}:r1.14-${ARCH}"

# Fail on first error.
set -e
#privileged to access host drivers
docker run --gpus device=0 -it --rm --name ${NAME} \
               --net=host \
               --privileged \
               --volume=/home/extra/autofeed/git/behnoosh/tf-cpp-base/packages/tensorflow_src:/tensorflow_src \
               --volume=/home/extra/autofeed/git/behnoosh/tf-cpp-base/packages/temp:/temp \
               --volume=/home/extra/autofeed/git/behnoosh/tf-cpp-base/packages/tf_test:/tf_test \
               ${TAG} /bin/bash

