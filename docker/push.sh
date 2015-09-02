#!/usr/bin/env bash

declare -i build

build=$(< .build)
echo "Pushing Build:1."${build}

docker push 01alchemist/django-host:1.${build}
docker push 01alchemist/django-host:latest
