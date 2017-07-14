FROM elixir:1.3.4
MAINTAINER Travis Truman <trumant@gmail.com>

ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV PATH /opt/google-cloud-sdk/bin:$PATH

USER root

# Install google-cloud-sdk
RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-jessie main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
  apt-get update -y && \
  apt-get install -y jq git make curl google-cloud-sdk kubectl && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/*

# Install Docker
RUN curl -L -o /tmp/docker-17.05.0-ce.tgz https://get.docker.com/builds/Linux/x86_64/docker-17.05.0-ce.tgz && \
  tar -xz -C /tmp -f /tmp/docker-17.05.0-ce.tgz && \
  mv /tmp/docker/* /usr/bin

# Install Helm
RUN wget http://storage.googleapis.com/kubernetes-helm/helm-v2.5.0-linux-amd64.tar.gz -P /tmp
RUN tar -zxvf /tmp/helm-v2.5.0-linux-amd64.tar.gz -C /tmp && mv /tmp/linux-amd64/helm /bin/helm && rm -rf /tmp