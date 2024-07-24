FROM alpine:3.17
ARG BUILDARCH
ARG PB_VERSION=0.22.18

RUN apk add --no-cache \
    unzip \
    ca-certificates \
    sqlite

ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_${BUILDARCH}.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /app/
RUN rm /tmp/pb.zip
EXPOSE 8080

ENV ORIGINS=""  # Default to allow all origins if no value is provided
CMD ["/app/pocketbase", "serve", "--http=0.0.0.0:8080", "--origins=${ORIGINS}"]
