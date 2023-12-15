FROM mcr.microsoft.com/azure-cli:2.41.0

LABEL name="ci-tools" \
  version="1.0"


ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 20.10.0
ENV DOCKER_ARCH x86_64
ENV HELM_VERSION v2.16.3
ENV YAML_BIN_VERSION 3.2.1
ENV HELM3_VERSION v3.10.1

## Automated package installs
RUN apk update && \
  apk add --update --no-cache bash \
  jq \
  git \
  curl \
  nodejs \
  npm \
  # Open jdk is a dependency for trivy scanner. Rolling back to v11 as it's failing for npm grooy lint (Supported version v8-v14 for npm groovy lint) 
  openjdk11

## Manual Installations
## Helm3
RUN mkdir -p /opt && \
  wget -qO-  "https://get.helm.sh/helm-${HELM3_VERSION}-linux-amd64.tar.gz" | tar xvz && \
  mv linux-amd64/helm /usr/local/bin/helm3 
  
## YQ
RUN wget -O /usr/local/bin/yq "https://github.com/mikefarah/yq/releases/download/${YAML_BIN_VERSION}/yq_linux_amd64" && \
  chmod +x /usr/local/bin/yq
  
## Helm2
RUN wget -O helm.tgz https://get.helm.sh/helm-${HELM_VERSION}-linux-386.tar.gz && \
  tar --extract \
  --file helm.tgz \
  --strip-components 1 \
  --directory /usr/local/bin/ \
  ; \
  rm -f helm.tgz 
  
## Docker
RUN wget -O docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/${DOCKER_ARCH}/docker-${DOCKER_VERSION}.tgz" && \
  tar --extract \
  --file docker.tgz \
  --strip-components 1 \
  --directory /usr/local/bin/ \
  ; \
  rm -f docker.tgz 

## Kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
  mv kubectl /usr/local/bin && \
  chmod +x /usr/local/bin/kubectl 
  
## Trivy
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.18.3 && \
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py 

## Jfrog
RUN curl -fL https://getcli.jfrog.io | sh -s v2 2.51.1 && \
  mv jfrog /usr/local/bin/ 

# Lock the setuptools version to fix demjson installation
RUN pip install "setuptools<58.0.0"
RUN pip install wget 
RUN pip install requests 
RUN pip install simplejson
RUN pip install demjson

## Language Specific Package Manager Installs
RUN npm config set unsafe-perm=true && \
  npm update -g && \
  npm install -g artillery@2.0.0-2 \
  dockerfile_lint \
  audit-ci \
  yarn \
  npm@8.5.5 \
  swagger-cli \
  yaml-lint \
  yaml-schema-validator \
  allure-commandline \
  mocha \
  @wdio/cli \
  chai \
  npm-groovy-lint \
  tsc \
  nyc \
  eslint \
  mocha \
  supertest && \
  yarn global add audit-ci


COPY config/.npmrc /root/.npmrc
COPY config/jenkins-entrypoint.sh /opt/jenkins-entrypoint.sh
