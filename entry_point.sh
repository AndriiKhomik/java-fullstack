#!/usr/bin/env bash

set -e

sleep 3

source variables.sh

./scripts/pgsql_restore.sh 2024-08-19.dump $POSTGRES_USER $POSTGRES_PASSWORD

gradle test

./scripts/pgsql_restore.sh 2024-08-19.dump $POSTGRES_USER $POSTGRES_PASSWORD

cd /usr/local/tomcat/bin

./catalina.sh run