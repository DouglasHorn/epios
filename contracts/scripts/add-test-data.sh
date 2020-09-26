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


curl -d '{"json":true,"code":"main.epios","scope":"all","table":"coupons", "lower_bound": "2209548d42fad24a7da862003c0d3d2f4a2898a092ca69eff3a9f13d53cd8f01", "index_position": 2, "key_type": "sha256", "limit": 1}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows