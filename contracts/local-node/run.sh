#!/usr/bin/env bash
set -ex

EOS_NODE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# remove all data files from previous run
rm -rf $EOS_NODE_DIR/data
rm -rf ~/eosio-wallet/default.wallet

nodeos -e -p eosio --config-dir $EOS_NODE_DIR/config --data-dir $EOS_NODE_DIR/data --plugin eosio::chain_api_plugin --plugin eosio::history_api_plugin --plugin eosio::http_plugin --http-server-address=0.0.0.0:8888 --delete-all-blocks --contracts-console
