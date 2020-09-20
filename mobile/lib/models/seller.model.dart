import 'dart:convert';

class SellerModel {
  final int id;
  final int countryId;
  final String name;
  final String address;
  final String url;
  final int flag;
  final int approveTime;
  SellerModel({
    this.id,
    this.countryId,
    this.name,
    this.address,
    this.url,
    this.flag,
    this.approveTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'countryId': countryId,
      'name': name,
      'address': address,
      'url': url,
      'flag': flag,
      'approveTime': approveTime,
    };
  }

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return SellerModel(
      id: map['id'],
      countryId: map['country_id'],
      name: map['name'],
      address: map['address'],
      url: map['url'],
      flag: map['flag'],
      approveTime: map['approve_time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerModel.fromJson(String source) => SellerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SellerModel(id: $id, countryId: $countryId, name: $name, address: $address, url: $url, flag: $flag, approveTime: $approveTime)';
  }
}
