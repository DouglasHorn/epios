import 'package:encrypt/encrypt.dart';
import 'package:epios/models/account.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService{
  final Key _key = Key.fromUtf8("mnbvcxzlkjhgfdsaasdfghjkloiuytre");
  final IV _iv = IV.fromLength(16);

  Future setAccount(AccountModel account)async{
    var j = account.toJson();
    var en = _encrypt(j);
    await _setString("account", en);
  }

  Future<AccountModel> getAccount()async{
    var s = await _getString("account");
    if(s==null)
      return null;
    var d = _decrypt(s);
    return AccountModel.fromJson(d);
  }

  String _encrypt(String text){
    final encrypter = Encrypter(AES(_key));
    return encrypter.encrypt(text, iv: _iv).base64;
  }

  String _decrypt(String text){
    final encrypter = Encrypter(AES(_key));
    return encrypter.decrypt(Encrypted.from64(text), iv: _iv);
  }

  Future _setString(String key,String data) async {
    var prefs = await SharedPreferences.getInstance();
    var t = prefs.setString(key, data);
    print(data);
    print(t);
  }

  Future<String> _getString(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}