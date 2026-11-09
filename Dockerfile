FROM alpine:3.24.3
ARG TARGETARCH
ARG PB_VERSION=0.41.1

ENV TZ=Europe/Berlin

RUN apk add --no-cache unzip ca-certificates tzdata

ADD https://ganigeorgiev.com/meta/pocketbase/pocketbase/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_${TARGETARCH}.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /app/ && rm /tmp/pb.zip

EXPOSE 8080
CMD ["/app/pocketbase", "serve", "--http=0.0.0.0:8080"]
