import 'dart:convert';

class TestModel {
  final int testId;
  final int couponId;
  final String secretKey;
  final int countryId;
  final int resultTime;
  final String result;
  final int labId;
  TestModel({
    this.testId,
    this.couponId,
    this.secretKey,
    this.countryId,
    this.resultTime,
    this.result,
    this.labId,
  });

  Map<String, dynamic> toMap() {
    return {
      'testId': testId,
      'couponId': couponId,
      'secretKey': secretKey,
      'countryId': countryId,
      'resultTime': resultTime,
      'result': result,
      'labId': labId,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return TestModel(
      testId: map['testId'],
      couponId: map['couponId'],
      secretKey: map['secretKey'],
      countryId: map['countryId'],
      resultTime: map['resultTime'],
      result: map['result'],
      labId: map['labId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TestModel.fromJson(String source) => TestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TestModel(testId: $testId, couponId: $couponId, secretKey: $secretKey, countryId: $countryId, resultTime: $resultTime, result: $result, labId: $labId)';
  }
}
