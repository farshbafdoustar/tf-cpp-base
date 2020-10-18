#!/usr/bin/env bash
cd packages
# Cloning TensorFlow to tensorflow_src folder from github
git clone https://github.com/tensorflow/tensorflow.git tensorflow_src
# Go to the version you need. Take r1.14 for example. Other versions may need to adjust your CUDA, CUDNN, NCCL, BAZEL versions accordingly.
cd tensorflow_src
git checkout r1.14


