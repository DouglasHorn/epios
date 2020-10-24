#pragma once
#include <eosio/system.hpp>

time_t now(){
    return eosio::current_time_point().sec_since_epoch();
}

const uint64_t scope_all = eosio::name("all").value;

int char2int(char input)
{
  if(input >= '0' && input <= '9')
    return input - '0';
  if(input >= 'A' && input <= 'F')
    return input - 'A' + 10;
  if(input >= 'a' && input <= 'f')
    return input - 'a' + 10;
  eosio::check(false, "Invalid input string");
  return 0;
}

void get_byte_secret_key(char *res, const int size_res, std::string secret_key) {
  const char *cstr_secret_key = secret_key.c_str();

  while(*cstr_secret_key && cstr_secret_key[1])
  {
    *(res++) = char2int(*cstr_secret_key)*16 + char2int(cstr_secret_key[1]);
    cstr_secret_key += 2;
  }
}

// Dangerous
uint64_t string_hash(const std::string string_to_hash) {
    uint64_t res = 0;
    for (int i = 0; i <= string_to_hash.length() / 8; ++i){
        uint64_t temp = 0;
        for (int j = 8 * i; j < string_to_hash.length(); ++j) {
            temp |= (uint64_t)string_to_hash[j] << ((j % 8) * 8);
        }
        res ^= temp;
    }
    return res;
}