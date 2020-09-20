import 'dart:convert';

class LabModel {
  final int id;
  final String name;
  final String adderss;
  final String phone;
  final String email;
  final int countryId;
  final int approveTime;
  LabModel({
    this.id,
    this.name,
    this.adderss,
    this.phone,
    this.email,
    this.countryId,
    this.approveTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'adderss': adderss,
      'phone': phone,
      'email': email,
      'countryId': countryId,
      'approveTime': approveTime,
    };
  }

  factory LabModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return LabModel(
      id: map['id'],
      name: map['name'],
      adderss: map['adderss'],
      phone: map['phone'],
      email: map['email'],
      countryId: map['country_id'],
      approveTime: map['approve_time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LabModel.fromJson(String source) => LabModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LabModel(id: $id, name: $name, adderss: $adderss, phone: $phone, email: $email, countryId: $countryId, approveTime: $approveTime)';
  }
}
