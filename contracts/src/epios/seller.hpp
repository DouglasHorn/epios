#pragma once
#include <eosio/eosio.hpp>
#include <eosio/system.hpp>
#include <string>

#define SELLER_FLAG_PHYSICAL_LOCATION (1 << 0)
#define SELLER_FALG_ONLINE_RETAILER (1 << 1)

bool check_seller_flag(uint32_t flag) {
  uint32_t mask = SELLER_FLAG_PHYSICAL_LOCATION | SELLER_FALG_ONLINE_RETAILER;
  return (flag & mask) && !(flag & ~mask);
}

struct [[eosio::table("seller"), eosio::contract("epios")]] seller {
  uint16_t id;
  std::string name;
  uint64_t country_id;
  std::string address;
  std::string url;
  int flag;

  time_t approve_time;

  uint64_t primary_key() const { return id; }
  uint64_t country_id_index() const { return country_id; }; 
  
  EOSLIB_SERIALIZE(seller, (id)(name)(country_id)(address)(url)(
                                       flag)(approve_time))
};

const uint64_t scope_all_seller = eosio::name("all").value;
typedef eosio::multi_index<"seller"_n, seller,
eosio::indexed_by<"bycountry"_n, eosio::const_mem_fun<seller, uint64_t, &seller::country_id_index>>
  > seller_index;