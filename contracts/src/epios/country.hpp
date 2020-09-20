#pragma once
#include <eosio/eosio.hpp>
#include <eosio/system.hpp>
#include <string>

struct [[eosio::table("country"), eosio::contract("epios")]] country {
  uint64_t country_id;
  std::string country_name;

  uint64_t primary_key() const { return country_id; }

  EOSLIB_SERIALIZE(country, (country_id)(country_name))
};

typedef eosio::multi_index<"country"_n, country> country_index;

