FROM alpine:latest

ARG BUILDARCH
ARG PB_VERSION=0.27.0

RUN apk add --no-cache \
  unzip \
  ca-certificates

ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_${BUILDARCH}.zip /tmp/pb.zip

RUN unzip /tmp/pb.zip -d /app/
RUN rm /tmp/pb.zip

EXPOSE 8080

ENTRYPOINT ["/app/pocketbase", "serve", "--http=0.0.0.0:8080"]
