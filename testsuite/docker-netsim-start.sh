#! /bin/bash

source docker-functions.sh

exec dump COMPOSE_PROJECT_NAME
exec dump JBOSS_IMAGE_START_CMD
exec dump DOCKER_MACHINE_HOST_IP
exec export COMPOSE_HTTP_TIMEOUT=300 
export COMPOSE_OPTIONS='-f docker-compose.yml -f docker-compose.netsim.yml'
exec dump COMPOSE_OPTIONS
exec dump COMPOSE_HTTP_TIMEOUT
exec docker-compose ${COMPOSE_OPTIONS} kill
#[ "$1" != "--no-pull" ] && exec docker-compose pull --ignore-pull-failures
[ "$1" != "--no-pull" ] && exec docker-compose ${COMPOSE_OPTIONS} pull
exec docker-compose ${COMPOSE_OPTIONS} build --pull
exec docker-compose ${COMPOSE_OPTIONS} up --force-recreate -d
exec docker-compose ${COMPOSE_OPTIONS} logs -f

