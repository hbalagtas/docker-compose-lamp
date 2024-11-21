#!/bin/bash

# MySQL credentials
MYSQL_PASSWORD="docker"

# Execute MySQL commands
mysql -u root -p"${MYSQL_PASSWORD}" -e "DROP DATABASE IF EXISTS docker; CREATE DATABASE docker;"
mysql -u root -p"${MYSQL_PASSWORD}" docker < /docker-entrypoint-initdb.d/docker.sql

