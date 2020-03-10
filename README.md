# drone-terraform

[![Build Status](http://beta.drone.io/api/badges/jmccann/drone-terraform/status.svg)](http://beta.drone.io/jmccann/drone-terraform)

Drone plugin to execute Terraform plan and apply. For the usage information and
a listing of the available options please take a look at [the docs](https://github.com/jmccann/drone-terraform/blob/master/DOCS.md).

## Changes

Added [yc command line](https://cloud.yandex.com/docs/cli/) into docker image to use it on terraform deployments.

Set **entrypoint.sh** as ENTRYPOINT in dockerfile to set and activate yc profile.

To correctly run image need to pass additional YC_SERVICE_ACCOUNT_KEY_FILE environment variable.

## Build

Build the binary with the following commands:

```bash
export GO111MODULE=on
go mod download
go test
go build
```

## Docker

Set required version in build argument terraform_version and in image tag (like 0.12.20 in example below)

Build the docker image with the following commands:

```bash
docker build --rm=true \
  -t cr.yandex/crpddgo40bv7rqr6iin4/drone-terraform:0.12.20 \
  --build-arg terraform_version=0.12.20 .
```

Push image into the repo:

```bash
docker push cr.yandex/crpddgo40bv7rqr6iin4/drone-terraform:0.12.20
```

## Usage

Execute from the working directory:

```bash
docker run --rm \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  cr.yandex/crpddgo40bv7rqr6iin4/drone-terraform:0.12.20 --plan
```
