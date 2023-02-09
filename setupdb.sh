#!/usr/bin/env bash

## Configuration values
export DB_USERNAME=postgres
export DB_PASSWORD=postgres

# Can be replaced with docker and docker-compose
readonly CONTAINER_EXEC="podman"
readonly CONTAINER_COMPOSE_EXEC="podman-compose"
readonly SERVICE_NAME="postgres"

## Script code
function exec_in_container() {
    $CONTAINER_EXEC exec $SERVICE_NAME bash -c "$*"
}

$CONTAINER_COMPOSE_EXEC down
$CONTAINER_COMPOSE_EXEC up -d

exec_in_container apt-get update
exec_in_container apt-get install -y wget
exec_in_container wget http://linux.dell.com/dvdstore/ds21.tar.gz -O /tmp/ds21.tar.gz
exec_in_container wget http://linux.dell.com/dvdstore/ds21_postgresql.tar.gz -O /tmp/ds21_postgresql.tar.gz
exec_in_container tar -xvzf /tmp/ds21.tar.gz -C /tmp
exec_in_container tar -xvzf /tmp/ds21_postgresql.tar.gz -C /tmp
exec_in_container sed -i -e "s/SYSDBA=ds2/SYSDBA=$DB_USERNAME/" \
  -e "s/PGPASSWORD=\"ds2\"/PGPASSWORD=\"$DB_PASSWORD\"/" /tmp/ds2/pgsqlds2/pgsqlds2_create_all.sh
exec_in_container "cd /tmp/ds2/pgsqlds2 && bash pgsqlds2_create_all.sh"
