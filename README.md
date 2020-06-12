![Docker](https://github.com/medined/eureka-heartbeat/workflows/Docker/badge.svg)

# Eureka Heartbeat

This project provides a container that sends a Eureka heartbeat message every 30 seconds.

Every 30 seconds, a heartbeat message is sent to a specified Eureka server if a healthcheck
URL returns 200. The container loop endlessly.

This is not a sophisticated container but at only 8.67MB it is quite a bit smaller than a Spring Boot Sidecar container.

## Build Image

```bash
docker build -t medined/eureka-heartbeater .
```

## Run Container

```bash
docker run \
  -it \
  --rm=true \
  --env HEALTHCHECK_URL=http://172.17.0.2:5000/health \
  --env EUREKA_URL=http://172.17.0.3:8761 \
  --env SERVICE_NAME=HELLO-SERVICE \
  --env HOST_NAME=hello01 \
  medined/eureka-heartbeater
```

## Find Container IP Address

If you are running Eureka or a microservice inside Docker, you'll need to find its IP address for the heartbeat script. Using `localhost` or `127.0.0.1` will not work because the heartbeat container does not use host networking.

Use the following example to find the IP address. It this example the container name is `hello-service`.

```bash
docker inspect \
  -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \
  hello-service
```
