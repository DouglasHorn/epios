#pragma once
#include <eosio/eosio.hpp>
#include <eosio/system.hpp>
#include <string>

#include "utils.hpp"

struct [[eosio::table("lab"), eosio::contract("epios")]] lab {
  uint16_t id;
  std::string name;
  std::string address;
  std::string phone;
  std::string email;
  uint64_t country_id;

  time_t approve_time;

  uint64_t primary_key() const { return id; }

  uint64_t country_id_index() const { return country_id; }; 

  EOSLIB_SERIALIZE(lab, (id)(name)(address)(phone)(email)(country_id)(approve_time))
};

const uint64_t scope_all_lab = eosio::name("all").value;
typedef eosio::multi_index<"lab"_n, lab,
eosio::indexed_by<"bycountry"_n, eosio::const_mem_fun<lab, uint64_t, &lab::country_id_index>>
> lab_index;