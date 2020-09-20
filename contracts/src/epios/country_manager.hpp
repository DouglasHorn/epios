#pragma once
#include <eosio/eosio.hpp>


struct [[eosio::table("counmanager"), eosio::contract("epios")]] counmanager {
  eosio::name manager_name;
  uint64_t country_id;
  time_t creation_time;

  uint64_t primary_key() const { return manager_name.value; }
  uint64_t country_id_index() const { return country_id; };

  EOSLIB_SERIALIZE(counmanager, (manager_name)(country_id)(creation_time))
};

typedef eosio::multi_index<"counmanager"_n, counmanager, 
eosio::indexed_by<"bycountry"_n, eosio::const_mem_fun<counmanager, uint64_t, &counmanager::country_id_index>>
> country_manager_index;