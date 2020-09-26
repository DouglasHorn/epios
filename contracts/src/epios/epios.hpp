#pragma once
#include <eosio/eosio.hpp>
#include <eosio/name.hpp>
#include <eosio/crypto.hpp>
#include "lab.hpp"
#include "seller.hpp"
#include "country.hpp"
#include "coupons.hpp"
#include "test.hpp"
#include "manager.hpp"   
#include "country_manager.hpp"
#include "utils.hpp"
#include <string>

class [[eosio::contract("epios")]] epios : public eosio::contract {
 public:
 epios(eosio::name receiver, eosio::name code,
           eosio::datastream<const char *> ds)
      : contract(receiver, code, ds){};

  ACTION crcountry(std::string country_name, uint64_t country_id);

  // Create Manager
  ACTION crmanager(eosio::name manager_name);

  // Create Country Manager
  ACTION crcntmanager(eosio::name manager_name, eosio::name country_manager_name, uint64_t country_id);

  // Create coupon
  ACTION crcoupon(eosio::name country_manager_name, eosio::checksum256 secret_key_hash, uint64_t country_id);

  // Approve Lab
  ACTION apprlab(eosio::name country_manager_name, std::string name,
                      std::string address, std::string phone, std::string email,
                      uint64_t country_id);

  // Approve Test Kit Seller
  ACTION apprseller(eosio::name country_manager_name, std::string name,
                         uint64_t country_id, std::string address,
                         std::string url, uint32_t flag);

  // Post Test Results
  ACTION posttestres(eosio::name country_manager_name, uint64_t coupon_id,
                      std::string secret_key_hash, uint64_t country_id, 
                      bool result, uint16_t lab_id);

  // Delete Country
  ACTION delcountry(uint64_t country_id);
  
  // Delete Manager
  ACTION delmanager(eosio::name manager_name);

  // Delete Country Manager
  ACTION delcountmngr(eosio::name manager_name, eosio::name country_manager_name);

  // Delete seller
  ACTION delseller(eosio::name country_manager_name, uint16_t id);

  // Delete coupon
  ACTION delcoupon(eosio::name country_manager_name, uint16_t id);

 private:
  manager_index::const_iterator find_manager(eosio::name manager_name);
  country_manager_index::const_iterator find_country_manager(eosio::name country_manager_name);
  country_index::const_iterator find_country(uint64_t country_id);
  coupons_index::const_iterator apprcoupon(uint64_t coupon_key, uint64_t country_id, std::string secret_key);
};
