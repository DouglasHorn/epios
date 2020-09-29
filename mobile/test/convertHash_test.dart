import 'package:test/test.dart';
import 'package:epios/commons/extension.dart';

void main(){
  test("Hash Test",(){
    var hash1 = "2f3d0d3c0062a87d4ad2fa428d540922028fcd533df1a9f3ef69ca92a098284a";
    var res1 = hash1.getLittleEndian;
    print(hash1);
    print(res1);
    expect(res1, "2209548d42fad24a7da862003c0d3d2f4a2898a092ca69eff3a9f13d53cd8f02");
    
    var hash2 = "7af12386a82b6337d6b1e4c6a1119e29bb03e6209aa03c70ed3efbb9b74a290c";
    var res2 = hash2.getLittleEndian;
    print(hash2);
    print(res2);
    expect(res2, "299e11a1c6e4b1d637632ba88623f17a0c294ab7b9fb3eed703ca09a20e603bb");

  });

  test("Decode Coupon",(){
    var h = "LTFWGPY2ROZNM".getCouponHash;
    print(h);
    
    h = "6KVD6DK3TWYRM".getCouponHash;
    print(h);
    expect(h, "8f5a3e0f987f86d44b6682272bd27c1a761d8c55dc322524cbd1e8a538f6df97");
  });
}