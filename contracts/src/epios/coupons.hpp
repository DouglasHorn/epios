#pragma once
#include <eosio/eosio.hpp>
#include <eosio/system.hpp>
#include <string>

#include "utils.hpp"
#include "test.hpp"

enum Status { unused, used };

struct [[eosio::table("coupons"), eosio::contract("epios")]] coupons {
  uint64_t country_id;
  uint64_t coupon_id;
  uint8_t status;
  eosio::checksum256 secret_key_hash;
  
  uint64_t primary_key() const { return coupon_id; }
  eosio::checksum256 checksum_key() const { return secret_key_hash; }

  EOSLIB_SERIALIZE(coupons, (country_id)(coupon_id)(status)(secret_key_hash))
};

typedef eosio::multi_index<
    "coupons"_n, coupons,
    eosio::indexed_by<"checksum"_n,
                     eosio::const_mem_fun<coupons, eosio::checksum256,
                                          &coupons::checksum_key>>
    > coupons_index;