printf '\nCountries:\n'
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"country"}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows

printf '\nProject managers:\n'
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"manager"}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows

printf "\nCountry managers:\n"
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"counmanager"}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows

printf "\nLabs:\n"
curl -d '{"json":true,"code":"main.epios","scope":"alllab","table":"lab"}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows

printf "\nKit sellers:\n"
curl -d '{"json":true,"code":"main.epios","scope":"allseller","table":"seller"}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows

echo "Coupons:"
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"coupons"}' -H 'Content-Type: application/json' https://api-test.telosfoundation.io/v1/chain/get_table_rows