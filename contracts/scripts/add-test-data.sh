#!/usr/bin/env bash

node ./add-test-data.js testnet

printf '\nCountries:\n'
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"country"}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows

printf '\nProject managers:\n'
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"manager"}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows

printf "\nCountry managers:\n"
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"counmanager"}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows

printf "\nLabs:\n"
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"lab"}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows

printf "\nKit sellers:\n"
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"seller"}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows

echo "Coupons:"
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"coupons"}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows


curl -d '{"json":true,"code":"main.epios","scope":"all","table":"coupons", "lower_bound": "2f3d0d3c0062a87d4ad2fa428d540922028fcd533df1a9f3ef69ca92a098284a", "index_position": 2, key_type: "checksum256"}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows