import 'dart:convert';

class TestResultModel {
  final int testId;
  final int couponId;
  final String secretKey;
  final int countryId;
  final int resultTime;
  final String result;
  final int labId;
  TestResultModel({
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

  factory TestResultModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return TestResultModel(
      testId: map['test_id'],
      couponId: map['coupon_id'],
      secretKey: map['secret_key'],
      countryId: map['country_id'],
      resultTime: map['result_time'],
      result: map['result'],
      labId: map['lab_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TestResultModel.fromJson(String source) => TestResultModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TestModel(testId: $testId, couponId: $couponId, secretKey: $secretKey, countryId: $countryId, resultTime: $resultTime, result: $result, labId: $labId)';
  }
}
