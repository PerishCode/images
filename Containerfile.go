ARG BASE_IMAGE=docker.io/library/golang:1.23-bookworm@sha256:167053a2bb901972bf2c1611f8f52c44d5fe7e762e5cab213708d82c421614db
FROM ${BASE_IMAGE}

ARG REVISION
ARG SOURCE

LABEL org.opencontainers.image.source=${SOURCE}
LABEL org.opencontainers.image.revision=${REVISION}
LABEL org.opencontainers.image.description="Public Go build environment"

RUN apt-get -o Acquire::ForceIPv4=true -o Acquire::http::Timeout=30 -o Acquire::Retries=3 update \
    && apt-get -o Acquire::ForceIPv4=true -o Acquire::http::Timeout=30 -o Acquire::Retries=3 install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        openssh-client \
        unzip \
        xz-utils \
    && rm -rf /var/lib/apt/lists/* \
    && go version
