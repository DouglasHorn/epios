import 'package:epios/models/account.model.dart';
import 'package:epios/models/data.model.dart';
import 'package:epios/services/storage.service.dart';

class Global{
  static final String version = "0.1.0";
  static AccountModel account;
  static StorageService storage = StorageService();
  static DataModel data;
}