#pragma once
#include <eosio/system.hpp>

time_t now(){
    return eosio::current_time_point().sec_since_epoch();
}

const uint64_t scope_all = eosio::name("all").value;

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