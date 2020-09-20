#!/usr/bin/env bash

# ../compile.sh
docker-compose run -w "/app" epios_eosio "./compile.sh"

node ./deploy.js testnet