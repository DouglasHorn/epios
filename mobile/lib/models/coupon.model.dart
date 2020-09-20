import 'dart:convert';

class CouponModel {
  final int countryId;
  final int couponId;
  final int status;
  final String secretKeyHash;
  CouponModel({
    this.countryId,
    this.couponId,
    this.status,
    this.secretKeyHash,
  });

  Map<String, dynamic> toMap() {
    return {
      'countryId': countryId,
      'couponId': couponId,
      'status': status,
      'secretKeyHash': secretKeyHash,
    };
  }

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return CouponModel(
      countryId: map['country_id'],
      couponId: map['coupon_id'],
      status: map['status'],
      secretKeyHash: map['secret_key_hash'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CouponModel.fromJson(String source) => CouponModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CouponModel(countryId: $countryId, couponId: $couponId, status: $status, secretKeyHash: $secretKeyHash)';
  }
}
