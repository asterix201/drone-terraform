# Docker image for the Drone Terraform plugin
#
#     docker build -t jmccann/drone-terraform:latest .
FROM golang:1.13-alpine AS builder

RUN apk add --no-cache git

WORKDIR /tmp/drone-terraform

COPY go.mod go.mod
COPY go.sum go.sum
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -tags netgo -o /go/bin/drone-terraform

FROM alpine:3.11

RUN apk add --no-cache \
    ca-certificates \
    git \
    wget \
    curl \
    bash \
    openssh-client \
    openssl

ARG terraform_version
RUN wget -q https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip -O terraform.zip && \
  unzip terraform.zip -d /bin && \
  rm -f terraform.zip

RUN curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -i /bin/yandex-cloud -n

COPY --from=builder /go/bin/drone-terraform /bin/
COPY entrypoint.sh /bin/entrypoint.sh

ENTRYPOINT ["/bin/entrypoint.sh"]

# ENTRYPOINT ["/bin/drone-terraform"]
