#pragma once
#include <eosio/eosio.hpp>
#include <eosio/system.hpp>
#include <string>

#include "utils.hpp"

#define TEST_RESULT_POSITIVE "Positive"
#define TEST_RESULT_NEGATIVE "Negative"

struct [[eosio::table("test"), eosio::contract("epios")]] test {
  uint64_t test_id;
  uint64_t coupon_id;
  std::string secret_key;
  uint64_t country_id;
  time_t result_time;
  std::string result;
  uint16_t lab_id;

  uint64_t primary_key() const { return test_id; }
  uint64_t couponid_key() const { return coupon_id; }
  EOSLIB_SERIALIZE(test,
                   (test_id)(coupon_id)(secret_key)(country_id)(
                       result_time)(result)(lab_id))
};

typedef eosio::multi_index<
    "test"_n, test,
    eosio::indexed_by<"userid"_n,
                     eosio::const_mem_fun<test, uint64_t,
                                          &test::couponid_key>>
    > test_index;