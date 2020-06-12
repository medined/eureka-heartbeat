FROM alpine:latest

RUN apk add curl && \
    addgroup -S heartbeater && \
    adduser -S heartbeater -G heartbeater

COPY ./heartbeat.sh /usr/local/bin/heartbeat.sh
CMD [ "sh","/usr/local/bin/heartbeat.sh" ]
