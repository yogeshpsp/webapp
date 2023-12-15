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

