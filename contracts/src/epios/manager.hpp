#pragma once
#include <eosio/eosio.hpp>

struct [[eosio::table("manager"), eosio::contract("epios")]] manager {
  eosio::name manager_name;
  time_t creation_time;

  uint64_t primary_key() const { return manager_name.value; }

  EOSLIB_SERIALIZE(manager, (manager_name)(creation_time))
};

typedef eosio::multi_index<"manager"_n, manager> manager_index;