FROM alpine:latest

ARG BUILDARCH
ARG PB_VERSION=0.28.1

RUN apk add --no-cache \
  unzip \
  ca-certificates \
  curl \
  wget

ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_${BUILDARCH}.zip /tmp/pb.zip

RUN unzip /tmp/pb.zip -d /app/
RUN rm /tmp/pb.zip

EXPOSE 8080

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl --fail http://localhost:8080/api/health || exit 1

ENTRYPOINT ["/app/pocketbase", "serve", "--http=0.0.0.0:8080"]
