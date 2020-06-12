#!/bin/bash

if [ -z $HEALTHCHECK_URL ]; then
  echo "Please supply the HEALTHCHECK_URL variable."
  exit
fi

if [ -z $EUREKA_URL ]; then
  echo "Please supply the EUREKA_URL variable."
  exit
fi

if [ -z $SERVICE_NAME ]; then
  echo "Please supply the SERVICE_NAME variable."
  exit
fi

if [ -z $HOST_NAME ]; then
  echo "Please supply the HOST_NAME variable."
  exit
fi

while [ 1 ]
do
  HTTP_CODE=$(curl --connect-timeout 2 --max-time 3 -s -o /dev/null -w "%{http_code}" $HEALTHCHECK_URL)
  NOW=$(date +"%Y-%m-%d %H:%M:%S")
  if [ $HTTP_CODE != 200 ]; then
    echo "$NOW HTTP response [$HTTP_CODE] from $HEALTHCHECK_URL"
  else
    echo "$NOW Sending heartbeat to $EUREKA_URL/eureka/apps/$SERVICE_NAME/$HOST_NAME"
    curl -X PUT $EUREKA_URL/eureka/apps/$SERVICE_NAME/$HOST_NAME
  fi
  sleep 30
done
