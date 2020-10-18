FROM nvidia/cuda:10.0-cudnn7-devel


# setup environment
ENV INITSYSTEM off
ENV QEMU_EXECVE 1
ENV TERM "xterm"
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONIOENCODING UTF-8
ENV BAZEL_VERSION 0.26.1
ENV DEBIAN_FRONTEND noninteractive

#RUN apt-get update \ 
#    && apt-get install -y software-properties-common
#RUN add-apt-repository ppa:graphics-drivers/ppa

# copy dependencies file
COPY dependencies-apt.txt /tmp/
COPY dependencies-py.txt /tmp/

# install apt dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    $(awk -F: '/^[^#]/ { print $1 }' /tmp/dependencies-apt.txt | uniq) \
  && rm -rf /var/lib/apt/lists/*


# remove dependencies files
RUN rm /tmp/dependencies*

WORKDIR /tmp

RUN wget "https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh"

RUN chmod +x "bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh"
RUN "./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh"

#RUN git clone https://github.com/tensorflow/tensorflow.git /tensorflow_src
#WORKDIR /tensorflow_src
#RUN git checkout r1.14

COPY ./assets/install-tf.sh /tmp
RUN chmod +x /tmp/install-tf.sh
#RUN bash  /tmp/install-tf.sh

ENV TMP /temp

# setup entrypoint
COPY ./assets/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]


LABEL maintainer="Mahmoud Farshbaf (Mahmoud@Farshbaf.Net)"
