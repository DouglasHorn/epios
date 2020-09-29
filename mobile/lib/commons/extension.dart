import 'package:base32/base32.dart';
import 'package:crypto/crypto.dart';

extension Hash on String{
  String get getLittleEndian {
    var hash = this;
    var p1 = "";
    var p2 = "";
    for (var i = 0; i < hash.length; i++) {
      if(i<32)
        p1 += hash[i];
      else
        p2 += hash[i];
    }
    var fun = (String h){
      List<String> s = [];
      for (var i = 0; i < h.length; i++) {
        if(i.isOdd)
          s.add(h[i-1]+h[i]);
      }
      return s.reversed.reduce((value, element) => value+element);
    };
    return fun(p1)+fun(p2);
  }

  String get getCouponHash {
    var h = base32.decodeAsHexString("${this}===");
    List<int> d = [];
    for (var i = 0; i < h.length; i++) {
      if(i.isOdd)
        d.add(int.parse(h[i-1]+h[i],radix: 16));
    }
    return sha256.convert(d).toString();
  }
}