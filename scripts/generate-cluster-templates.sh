#!/bin/bash

source scripts/capi-vars.sh

clusterctl generate cluster $PROJECT_NAME > templates/capz-poc.yaml
