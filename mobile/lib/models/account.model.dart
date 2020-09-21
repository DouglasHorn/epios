import 'dart:convert';

class AccountModel {
  final String accountName;
  final String password;
  AccountModel({
    this.accountName,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'accountName': accountName,
      'password': password,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return AccountModel(
      accountName: map['accountName'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) => AccountModel.fromMap(json.decode(source));
}
