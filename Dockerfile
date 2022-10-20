FROM ubuntu:22.04 AS builder
 
ARG KUSTOMIZE_VERSION=v4.5.7
 
RUN apt-get update -y && \
    apt-get install -y \
        curl \
        gpg && \
    apt-get clean && \
    curl -o /tmp/kustomize.tar.gz -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz && \
    tar -xvf /tmp/kustomize.tar.gz -C /usr/local/bin && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM quay.io/argoproj/argocd:v2.4.14

COPY --from=builder /usr/local/bin/kustomize /usr/local/bin/kustomize
