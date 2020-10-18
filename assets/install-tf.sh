#!/bin/bash

cd '/tensorflow_src'
ln -s /usr/bin/python3 /usr/bin/python
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.0/extras/CUPTI/lib64
# Python path options
export PYTHON_BIN_PATH=$(which python3)
export PYTHON_LIB_PATH="$($PYTHON_BIN_PATH -c 'import site; print(site.getsitepackages()[0])')"

# Compilation parameters
export TF_NEED_CUDA=1
export TF_NEED_GCP=0
export TF_CUDA_COMPUTE_CAPABILITIES=5.2,6.1,7.0,7.5
export TF_NEED_HDFS=0
export TF_NEED_OPENCL=0
export TF_NEED_JEMALLOC=0
export TF_ENABLE_XLA=1
export TF_NEED_VERBS=0
export TF_CUDA_CLANG=0
export TF_DOWNLOAD_CLANG=0
export TF_NEED_MKL=0
export TF_DOWNLOAD_MKL=0
export TF_NEED_MPI=0
export TF_NEED_S3=0
export TF_NEED_KAFKA=0
export TF_NEED_GDR=0
export TF_NEED_OPENCL_SYCL=0
export TF_SET_ANDROID_WORKSPACE=0
export TF_NEED_AWS=0
export TF_NEED_IGNITE=0
export TF_NEED_ROCM=0

# Compiler parameters
export GCC_HOST_COMPILER_PATH=$(which gcc)

# Parameters for bazel compilation optimization
export CC_OPT_FLAGS="-march=native"

# CUDA and cuDNN parameters
export CUDA_TOOLKIT_PATH="/usr/local/cuda-10.0"
export CUDNN_INSTALL_PATH="/usr/include,/usr/lib/x86_64-linux-gnu" # A comma-separated path string that includes the location of header files and. so files, if different from the installation location of CUDA
export TF_CUDA_VERSION=10 # CUDA Version
export TF_CUDNN_VERSION=7 # cuDNN version, write 7 directly, if you know the specific version number, such as 7.6.1, can also be
export TF_NEED_TENSORRT=0
export TF_NCCL_VERSION=2 # NCCL version, similar to the cuDNN version
export NCCL_INSTALL_PATH="/usr/include,/usr/lib/x86_64-linux-gnu"

# Those two lines are important for the linking step.
export LD_LIBRARY_PATH="$CUDA_TOOLKIT_PATH/lib64:${LD_LIBRARY_PATH}"
ldconfig

./configure
bazel build -c opt --ram_utilization_factor 30 \
                   --jobs=2 \
                   --config=cuda \
                   --action_env="LD_LIBRARY_PATH=${LD_LIBRARY_PATH}" //tensorflow:libtensorflow_cc.so
