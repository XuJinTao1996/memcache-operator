.PHONY: install image

IMAGE ?= memcached-operator
TAG ?= demo
REPO_URL ?= $(shell git remote get-url origin)
BRANCH ?= $(shell git branch --show-current)
COMMIT_REF ?= $(shell git show-ref --heads -s)
OPERATOR_RELEASE_VERSION ?= v0.12.0

install:
	- curl -LO https://github.com/operator-framework/operator-sdk/releases/download/${OPERATOR_RELEASE_VERSION}/operator-sdk-${OPERATOR_RELEASE_VERSION}-x86_64-linux-gnu
	- chmod +x operator-sdk-${OPERATOR_RELEASE_VERSION}-x86_64-linux-gnu 
	- sudo mkdir -p /usr/local/bin/ 
	- sudo cp operator-sdk-${OPERATOR_RELEASE_VERSION}-x86_64-linux-gnu /usr/local/bin/operator-sdk 
	- rm operator-sdk-${OPERATOR_RELEASE_VERSION}-x86_64-linux-gnu

image:
	- operator-sdk build --image-build-args REPO_URL=$(REPO_URL) --image-build-args BRANCH=$(BRANCH) --image-build-args COMMIT_REF=$(COMMIT_REF) -t $(IMG):$(TAG)