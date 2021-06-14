#!/bin/bash

echo "Generating resources"
swiftgen config run --config ./swiftgen.yml

echo "Generating resources for module Map"
swiftgen config run --config ./Modules/Map/swiftgen.yml