import 'dart:convert';

class DataModel {
  final Map<String,PersonModel> persons;
  DataModel({
    this.persons,
  });

  Map<String, dynamic> toMap() {
    return {
      'persons': persons,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DataModel(
      persons: Map<String,PersonModel>.from(map['persons']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModel.fromJson(String source) => DataModel.fromMap(json.decode(source));
}

class PersonModel {
  final String name;
  final List<TestModel> tests;
  PersonModel({
    this.name,
    this.tests,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'tests': tests?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return PersonModel(
      name: map['name'],
      tests: List<TestModel>.from(map['tests']?.map((x) => TestModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonModel.fromJson(String source) => PersonModel.fromMap(json.decode(source));
}

class TestModel {
  final String couponId;
  final int testDate;
  TestModel({
    this.couponId,
    this.testDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'couponId': couponId,
      'testDate': testDate,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return TestModel(
      couponId: map['couponId'],
      testDate: map['testDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TestModel.fromJson(String source) => TestModel.fromMap(json.decode(source));
}
