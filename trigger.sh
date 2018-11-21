#! /usr/bin/env bash

set -e 

fly_target=$1

fly sp -t $fly_target  -c pipeline.yml -p redis -l creds.yml -l params.yml
fly -t $fly_target up -p redis
fly -t $fly_target trigger-job -j redis/prepare-deployment --watch
fly -t $fly_target trigger-job -j redis/deploy-redis --watch
