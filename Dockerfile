FROM alpine:latest

ARG BUILDARCH
ARG PB_VERSION=0.41.1

RUN apk add --no-cache \
  unzip \
  ca-certificates \
  curl \
  wget

# PocketBase moved from GitHub to ganigeorgiev.com (v0.41.0+).
# Versions up to v0.40.6 are only on the archived GitHub repository.
RUN FILE="pocketbase_${PB_VERSION}_linux_${BUILDARCH}.zip" && \
  curl -fsSL -o /tmp/pb.zip "https://ganigeorgiev.com/meta/pocketbase/pocketbase/download/v${PB_VERSION}/${FILE}" || \
  curl -fsSL -o /tmp/pb.zip "https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/${FILE}" && \
  unzip /tmp/pb.zip -d /app/ && \
  rm /tmp/pb.zip

EXPOSE 8080

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl --fail http://localhost:8080/api/health || exit 1

ENTRYPOINT ["/app/pocketbase", "serve", "--http=0.0.0.0:8080"]
