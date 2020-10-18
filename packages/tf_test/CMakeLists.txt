cmake_minimum_required(VERSION 3.7)
project(tf_detector_example)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g -Wall")

set(SOURCE_FILES main.cpp utils.cpp utils.h)
add_executable(tf_detector_example ${SOURCE_FILES})

# OpenCV libs
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})
target_link_libraries(tf_detector_example ${OpenCV_LIBS})


# ==================== PATHS TO SPECIFY! ==================== #

# The third-party library path required by TensorFlow. If eigen, absl, and protobuf are not explicitly specified, they may report no such file or directory error.
include_directories("/usr/local/include")
include_directories("/usr/local/include/eigen")
include_directories("/usr/local/include/eigen3")
include_directories("/usr/local/include/absl")
include_directories("/usr/local/include/protobuf/src")

# TensorFlow header file path
include_directories("/tensorflow_src")
include_directories("/tensorflow_src/bazel-genfiles/")
include_directories("/tensorflow_src/tensorflow/")
include_directories("/tensorflow_src/third-party/")
include_directories("/tensorflow_src/bazel-tensorflow_src/external/eigen_archive")
include_directories("/tensorflow_src/bazel-tensorflow_src/external/protobuf_archive/src")
include_directories("/tensorflow_src/bazel-tensorflow_src/external/com_google_absl")

# TensorFlow Dynamic Link Library Path
target_link_libraries(tf_detector_example "/tensorflow_src/bazel-bin/tensorflow/libtensorflow_cc.so")
target_link_libraries(tf_detector_example "/tensorflow_src/bazel-bin/tensorflow/libtensorflow_framework.so.1")
