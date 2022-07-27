#!/bin/bash
app=$1
mode=$2

if [ -z "$DOCKER_COMMONS_PATH" ]
then
  docker_commons_path="$HOME/docker-commons"
else
  docker_commons_path=$DOCKER_COMMONS_PATH
fi

app_found=false

for entry in "$docker_commons_path"/*
do
    app_name=$(echo "$entry" | awk '{n=split($0,a,"/"); print a[n]}')

    if [ "$app_name" == "$app" ]; then
      app_found=true
      break
    fi
done

if [ "$app_found" == false ]; then
  echo "💥 app '$app' not found in docker commons."
  exit 1
fi

file_path="$docker_commons_path/$app/docker-compose.yml"

if [ "$mode" == "up" ]
then
    docker compose -f $file_path up -d
elif [ "$mode" == "down" ]
then
    docker compose -f $file_path down
else
    echo "💥 option '$mode' not supported."
fi