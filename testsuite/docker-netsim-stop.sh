#! /bin/bash

source docker-functions.sh
export COMPOSE_OPTIONS='-f docker-compose.yml -f docker-compose.netsim.yml'
exec docker-compose ${COMPOSE_OPTIONS} down -v
exec docker-compose ${COMPOSE_OPTIONS} kill


