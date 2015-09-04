#!/usr/bin/env bash

declare -i build

build=$(< .build)
build=build+1
echo "Build:1."${build}

docker build -t 01alchemist/django-host:1.${build} .
docker build -t 01alchemist/django-host:latest .

echo "Build Number : 1."${build}

echo ${build} > .build