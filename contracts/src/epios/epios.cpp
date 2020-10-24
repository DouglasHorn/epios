#include "epios.hpp"

void epios::crcountry(std::string country_name, uint64_t country_id) {
  require_auth(_self);
  country_index country_table(_self, scope_all);
  eosio::check(country_table.find(country_id) == country_table.end(),
               "This country is already registered");
  country_table.emplace(_self, [&](auto &country_to_add) {
    country_to_add.country_id = country_id;
    country_to_add.country_name = country_name;
  });
}

void epios::crmanager(eosio::name manager_name) {
  require_auth(_self);

  manager_index manager_table(_self, scope_all);
  auto iter_manager = manager_table.find(manager_name.value);
  eosio::check(iter_manager == manager_table.end(),
               "This manager already registred");

  manager_table.emplace(_self, [&](auto &manager_to_add) {
    manager_to_add.manager_name = manager_name;
    manager_to_add.creation_time = now();
  });
}

void epios::crcntmanager(eosio::name manager_name, eosio::name country_manager_name, uint64_t country_id) {
  require_auth(manager_name);
  find_manager(manager_name);
  find_country(country_id);

  country_manager_index country_manager_table(_self, scope_all);
  auto iter_country_manager = country_manager_table.find(country_manager_name.value);
  eosio::check(iter_country_manager == country_manager_table.end(),
               "This country manager already registred");

  country_manager_table.emplace(_self, [&](auto &country_manager_to_add) {
    country_manager_to_add.manager_name = country_manager_name;
    country_manager_to_add.country_id = country_id;
    country_manager_to_add.creation_time = now();
  });
}

void epios::crcoupon(eosio::name country_manager_name, eosio::checksum256 secret_key_hash, uint64_t country_id) {
  require_auth(country_manager_name);
  find_country_manager(country_manager_name);
  find_country(country_id);
  
  coupons_index coupons_table(_self, scope_all);
  coupons_table.emplace(_self, [&](auto &coupon_to_add) {
    coupon_to_add.country_id = country_id;
    coupon_to_add.coupon_id = coupons_table.available_primary_key();
    coupon_to_add.status = uint8_t(unused);
    coupon_to_add.secret_key_hash = secret_key_hash;
  });
}

coupons_index::const_iterator epios::apprcoupon(uint64_t coupon_key, uint64_t country_id, std::string secret_key) {
  coupons_index coupons_table(_self, scope_all);

  auto iter_coupon = coupons_table.find(coupon_key);
  eosio::check(iter_coupon != coupons_table.end(), "Coupon not found");
  eosio::check(iter_coupon->country_id == country_id, "Countries id do not match");
  eosio::check(iter_coupon->status == unused, "Coupon has already been used");

  const int size_res = 8;
  char res[size_res] {0};
  get_byte_secret_key(res, size_res, secret_key);

  assert_sha256(res, size_res, iter_coupon->secret_key_hash);

  coupons_table.modify(iter_coupon, _self, [&](auto &coupon) {
    coupon.status = uint8_t(used);
  });

  return iter_coupon;
}

void epios::apprlab(eosio::name country_manager_name, std::string name,
                      std::string address, std::string phone, std::string email,
                      uint64_t country_id){
  require_auth(country_manager_name);
  find_country(country_id);
  auto country_manager = find_country_manager(country_manager_name);

  eosio::check(country_manager->country_id == country_id,
               "Only country manager from the same country allowed");

  auto lab_table = lab_index(_self, scope_all_lab);
  lab_table.emplace(_self, [&](auto &lab_to_add) {
    lab_to_add.id = lab_table.available_primary_key();
    lab_to_add.name = name;
    lab_to_add.address = address;
    lab_to_add.phone = phone;
    lab_to_add.email = email;
    lab_to_add.country_id = country_id;
    lab_to_add.approve_time = now();
  });
}

void epios::apprseller(eosio::name country_manager_name, std::string name,
                         uint64_t country_id, std::string address,
                         std::string url, uint32_t flag) {
  require_auth(country_manager_name);
  find_country(country_id);
  auto iter_country_manager = find_country_manager(country_manager_name);

  eosio::check(check_seller_flag(flag), "Seller flag is invalid");

  eosio::check(iter_country_manager->country_id == country_id,
               "Only country manager from the same country allowed");

  auto seller_table = seller_index(_self, scope_all_seller);

  seller_table.emplace(_self, [&](auto &seller_to_add) {
    seller_to_add.id = seller_table.available_primary_key();;
    seller_to_add.name = name;
    seller_to_add.country_id = country_id;
    seller_to_add.address = address;
    seller_to_add.url = url;
    seller_to_add.flag = flag;
    seller_to_add.approve_time = now();
  });
}


void epios::posttestres(eosio::name country_manager_name, uint64_t coupon_id,
                        std::string secret_key, uint64_t country_id,
                        std::string test_type, std::string report,
                        time_t test_date, std::string result, uint16_t lab_id) {
  require_auth(country_manager_name);
  find_country_manager(country_manager_name);
  find_country(country_id);

  apprcoupon(coupon_id, country_id, secret_key);

  test_index test_table(_self, scope_all);

  const uint64_t test_id = test_table.available_primary_key();
  test_table.emplace(_self, [&](auto &test_to_add) {
    test_to_add.test_id = test_id;
    test_to_add.coupon_id = coupon_id;
    test_to_add.secret_key = secret_key;
    test_to_add.country_id = country_id;
    test_to_add.test_type = test_type;
    test_to_add.report = report;
    test_to_add.result_time = now();
    test_to_add.test_date = test_date;
    test_to_add.result = result;
    test_to_add.lab_id = lab_id;
  });
}

void epios::delcountry(uint64_t country_id) {
  require_auth(_self);

  country_index country_table(_self, scope_all);
  auto iter_country = country_table.find(country_id);
  eosio::check(iter_country != country_table.end(), "No country with such ID");

  country_table.erase(iter_country);
}

void epios::delmanager(eosio::name manager_name) {
  require_auth(_self);

  auto iter_manager = find_manager(manager_name);
  manager_index manager_table(_self, scope_all);
  manager_table.erase(iter_manager);
}

void epios::delcountmngr(eosio::name manager_name, eosio::name country_manager_name) {
  require_auth(manager_name);
  find_manager(manager_name);

  auto iter_country_manager = find_country_manager(country_manager_name);
  country_manager_index country_manager_table(_self, scope_all);
  country_manager_table.erase(iter_country_manager);
}

void epios::dellab(eosio::name country_manager_name, uint16_t id) {
  require_auth(country_manager_name);
  auto iter_country_manager = find_country_manager(country_manager_name);
  lab_index lab_table(_self, scope_all_lab);

  auto iter_lab = lab_table.find(id);
  eosio::check(iter_lab != lab_table.end(),
               "Seller not found");
  eosio::check(iter_country_manager->country_id == iter_lab->country_id,
               "Only country manager from the same country allowed");

  lab_table.erase(iter_lab);
}

void epios::delseller(eosio::name country_manager_name, uint16_t id) {
  require_auth(country_manager_name);
  auto iter_country_manager = find_country_manager(country_manager_name);
  seller_index seller_table(_self, scope_all_seller);

  auto iter_seller = seller_table.find(id);
  eosio::check(iter_seller != seller_table.end(),
               "Seller not found");
  eosio::check(iter_country_manager->country_id == iter_seller->country_id,
               "Only country manager from the same country allowed");

  seller_table.erase(iter_seller);
}

void epios::delcoupon(eosio::name country_manager_name, uint16_t id) {
  require_auth(country_manager_name);
  auto iter_country_manager = find_country_manager(country_manager_name);
  coupons_index coupon_table(_self, scope_all);

  auto iter_coupon = coupon_table.find(id);
  eosio::check(iter_coupon != coupon_table.end(),
               "Coupon not found");
  eosio::check(iter_country_manager->country_id == iter_coupon->country_id,
               "Only country manager from the same country allowed");

  coupon_table.erase(iter_coupon);
}

void epios::deltest(eosio::name country_manager_name, uint16_t id) {
  require_auth(country_manager_name);
  auto iter_country_manager = find_country_manager(country_manager_name);
  
  test_index test_table(_self, scope_all);
  auto iter_test = test_table.find(id);
  eosio::check(iter_test != test_table.end(),
               "Test not found");
  eosio::check(iter_country_manager->country_id == iter_test->country_id,
               "Only country manager from the same country allowed");
  
  test_table.erase(iter_test);
}

manager_index::const_iterator epios::find_manager(
    eosio::name manager_name) {
  manager_index manager_table(_self, scope_all);
  auto iter_manager = manager_table.find(manager_name.value);
  eosio::check(iter_manager != manager_table.end(), "Manager not found");
  return iter_manager;
}

country_manager_index::const_iterator epios::find_country_manager(
    eosio::name country_manager_name) {
  country_manager_index country_manager_table(_self, scope_all);
  auto iter_country_manager = country_manager_table.find(country_manager_name.value);
  eosio::check(iter_country_manager != country_manager_table.end(), "Country manager not found");
  return iter_country_manager;
}

country_index::const_iterator epios::find_country(uint64_t country_id) {
  country_index country_table(_self, scope_all);
  auto iter_country = country_table.find(country_id);
  eosio::check(iter_country != country_table.end(), "Country not found");
  return iter_country;
}

EOSIO_DISPATCH(
    epios,
    (crcountry)(crmanager)(crcntmanager)(crcoupon)(apprlab)(apprseller)(posttestres)(delcountry)(delmanager)(delcountmngr)(dellab)(delseller)(delcoupon)(deltest))