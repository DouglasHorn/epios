import hashlib
import base64
import secrets
import csv
import subprocess


def get_byte(approver_eos_name, countyId, numberCoupons, fileName):
    byte = []
    i = 0
    while i < numberCoupons:
        byte.append(secrets.token_bytes(8))
        i += 1 
    print(len(byte))
    print(byte)
    get_base32(byte, numberCoupons, fileName)
    get_hash3_256(approver_eos_name, byte)


def get_base32(token_bytes, numberCoupons, fileName):
    

    csvfile = open(fileName + '.csv', 'w', newline='')
    spamwriter = csv.writer(csvfile, delimiter=' ',
                            quotechar='|', quoting=csv.QUOTE_MINIMAL)

    for element in token_bytes:
        encoded = base64.b32encode(element)
        print(encoded)
        encoded = encoded.decode("utf-8").replace("=", "") 
        spamwriter.writerow({encoded})


    
def get_hash3_256(approver_eos_name, token_bytes):
    subprocess.call(['cleos', 'wallet', 'unlock', '-n', 'default', '--password', 'PW5JmaHrYqmmD4nma24vTXGJERpo12W27GNuHvKMf7CkBXkrtaMpw'])

    for element in token_bytes:
        print(element)
        hash_object = hashlib.sha256(element)
        hex_dig = hash_object.hexdigest()
        print(hex_dig)

        data = '{"country_manager_name": "crmgr.epios", "secret_key_hash": ' + hex_dig + ', "country_id": 1}'
        subprocess.call(['cleos', 'push', 'action', approver_eos_name, 'crcoupon', data , '-p', 'crmgr.epios'])
  

get_byte("main.epios", 13, 1, "testFile23455")