#! /bin/bash
docker compose down
rm -fr data/mysql/*
docker compose up -d --build  --force-recreate --no-deps
