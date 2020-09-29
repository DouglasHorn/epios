echo "Adding test countries"
cleos push action main.epios crcountry '{"country_name": "United States of America", "country_id": 1}' -p main.epios
sleep 1
echo "Countries:"
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"country"}' -H 'Content-Type: application/json' http://localhost:8888/v1/chain/get_table_rows

echo "Adding project manager"
cleos push action main.epios crmanager '{"manager_name": "mgr.epios"}' -p main.epios
sleep 1
echo "Project managers:"
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"manager"}' -H 'Content-Type: application/json' http://localhost:8888/v1/chain/get_table_rows

echo "Adding country manager"
cleos push action main.epios crcntmanager '{"country_manager_name": "crmgr.epios", "manager_name": "mgr.epios", "country_id": 1}' -p mgr.epios
sleep 1
echo "Country managers:"
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"counmanager"}' -H 'Content-Type: application/json' http://localhost:8888/v1/chain/get_table_rows

echo "Adding lab"
cleos push action main.epios apprlab '{"country_manager_name": "crmgr.epios", "name": "Test Lab 1", "address": "123 Main St, New York, NY 11111 USA", "phone": "12223334444", "email": "lab@testlab.com",  "country_id": 1}' -p crmgr.epios
sleep 1
echo "Labs:"
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"lab"}' -H 'Content-Type: application/json' http://localhost:8888/v1/chain/get_table_rows


echo "Adding kit seller"
cleos push action main.epios apprseller '{"country_manager_name": "crmgr.epios", "name": "Test Kit Seller", "address": "235 Main St, New York, NY 11111 USA", "url": "test1@kitseller.com", "flag": true,  "country_id": 1}' -p crmgr.epios
sleep 1
echo "Kit sellers:"
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"seller"}' -H 'Content-Type: application/json' http://localhost:8888/v1/chain/get_table_rows


echo "Adding coupon"
cleos push action main.epios crcoupon '{"country_manager_name": "crmgr.epios", "secret_key_hash": "23ab3a551407096bad1e34610802a6fc139426239f141876034523767a81dad2", "country_id": 1}' -p crmgr.epios
sleep 1
echo "Coupons:"
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"coupons"}' -H 'Content-Type: application/json' http://localhost:8888/v1/chain/get_table_rows


echo "Post test result"
cleos push action main.epios posttestres '{"country_manager_name": "crmgr.epios", "coupon_id": 0, "secret_key_hash": "$\\xd9hu\\x98h\\x16?", "country_id": 1, "result_time": 1563027637, "result": true, "lab_id": 1}' -p crmgr.epios
sleep 1
echo "posttestres:"
curl -d '{"json":true,"code":"main.epios","scope":"all","table":"test"}' -H 'Content-Type: application/json' http://localhost:8888/v1/chain/get_table_rows