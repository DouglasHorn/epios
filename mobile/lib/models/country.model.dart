import 'dart:convert';

class CountryModel {
  final int countryId;
  final String countryName;
  CountryModel({
    this.countryId,
    this.countryName,
  });

  Map<String, dynamic> toMap() {
    return {
      'countryId': countryId,
      'countryName': countryName,
    };
  }

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return CountryModel(
      countryId: map['countryId'],
      countryName: map['countryName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryModel.fromJson(String source) => CountryModel.fromMap(json.decode(source));

  @override
  String toString() => 'CountryModel(countryId: $countryId, countryName: $countryName)';
}
