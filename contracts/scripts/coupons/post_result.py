import hashlib
import base64
import secrets
import csv
import subprocess


def post_result(approver_eos_name, base32):    
    base32New = base32 + "==="
    base32New = str.encode(base32New)
    print(base32New)
    print("decode")
    decode = base64.b32decode(base32New)
    print(decode)
    hash_object = hashlib.sha256(decode)
    hex_dig = hash_object.hexdigest()
    print(hex_dig)

    subprocess.call(['cleos', 'wallet', 'unlock', '-n', 'default', '--password', '123'])
    subprocess.call(['cleos', 'wallet', 'list'])

    data = '{"country_manager_name": ' + approver_eos_name + ', "coupon_id": 0, "secret_key_hash": ' + hex_dig + ', "secret_key": ' + base32 + ', "country_id": 1, "result_time": 1563027637, "result": true, "lab_id": 1}'
    subprocess.call(['cleos', 'push', 'action', 'main.epios', 'posttestres', data , '-p', 'crmgr.epios'])


post_result("crmgr.epios", "D5XB4I6MDJMIE")