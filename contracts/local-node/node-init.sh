#!/usr/bin/env bash
set -ex

cd ..

echo "Compiling contract"
./compile.sh

echo "Creating wallet with name eosio"
cleos wallet create --name default -f 123

echo "Importing private key for system eosio account"
cleos wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3

echo "Loading bios contract"
cleos set contract eosio $EOSIO_BUILD_DIR/contracts/eosio.bios -p eosio

cleos wallet import --private-key 5K4ftE2YLYc6VumsVW4C7RUCdS13MbaSxYbNDTHAhf6wCD9zHiQ

echo "Creating smart contract account"
cleos create account eosio main.epios EOS5NtdP7ofLYQG3Xwz7PQFHFR8yv1hK3t7AqZA3Bo4PDGnSbtHK5 EOS5NtdP7ofLYQG3Xwz7PQFHFR8yv1hK3t7AqZA3Bo4PDGnSbtHK5

echo "Creating project manager account"
cleos create account eosio mgr.epios EOS5NtdP7ofLYQG3Xwz7PQFHFR8yv1hK3t7AqZA3Bo4PDGnSbtHK5 EOS5NtdP7ofLYQG3Xwz7PQFHFR8yv1hK3t7AqZA3Bo4PDGnSbtHK5

echo "Creating country manager account"
cleos create account eosio crmgr.epios EOS5NtdP7ofLYQG3Xwz7PQFHFR8yv1hK3t7AqZA3Bo4PDGnSbtHK5 EOS5NtdP7ofLYQG3Xwz7PQFHFR8yv1hK3t7AqZA3Bo4PDGnSbtHK5

echo "Deploying contract"
cleos set contract main.epios ./src/epios -p main.epios

sleep 1

echo "Initializing test data"
./local-node/test-data-init.sh

