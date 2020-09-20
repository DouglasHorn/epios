import 'dart:convert';

class CountryManagerModel {
  final String managerName;
  final int countryId;
  final int creationTime;
  CountryManagerModel({
    this.managerName,
    this.countryId,
    this.creationTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'managerName': managerName,
      'countryId': countryId,
      'creationTime': creationTime,
    };
  }

  factory CountryManagerModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return CountryManagerModel(
      managerName: map['manager_name'],
      countryId: map['country_id'],
      creationTime: map['creation_time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryManagerModel.fromJson(String source) => CountryManagerModel.fromMap(json.decode(source));

  @override
  String toString() => 'CountryManagerModel(managerName: $managerName, countryId: $countryId, creationTime: $creationTime)';
}
