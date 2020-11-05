import 'package:eosdart/eosdart.dart';
import 'package:epios/models/country.model.dart';
import 'package:epios/models/countryManager.model.dart';
import 'package:epios/models/coupon.model.dart';
import 'package:epios/models/data.model.dart';
import 'package:epios/models/seller.model.dart';
import 'package:epios/models/test.model.dart';

class ContractService{
  EOSClient _client;

  final String contract = "main.epios";
  final String scope = "all";
  
  //testnet
  final List<String> nodeList = [
    "https://api-test.telosfoundation.io",
    "https://testnet.persiantelos.com",
  ];

  //mainnet
  // final List<String> nodeList = [
  //   "https://api.telosfoundation.io",
  //   "https://mainnet.persiantelos.com",
  // ];

  init(){
    _client = EOSClient(nodeList[0],"v1",httpTimeout: 30);
  }

  Future<List<CountryManagerModel>> getCountryManagers()async{
    var d = await _client.getTableRows(contract, scope, "counmanager",limit: 200);
    return d.map((e) => CountryManagerModel.fromMap(e)).toList();
  }

  Future<List<CountryModel>> getCountries()async{
    var d = await _client.getTableRows(contract, scope, "country",limit: 200);
    return d.map((e) => CountryModel.fromMap(e)).toList();
  }

  Future<CountryModel> getCoupon(String hash)async{
    var d = await _client.getTableRow(contract, scope, "coupons",upper: hash,lower: hash);
    return CountryModel.fromMap(d);
  }

  Future<List<SellerModel>> getSellers(int countryId)async{
    var d = await _client.getTableRows(contract, scope, "seller",indexPosition: 2,keyType: "i64",upper: countryId.toString(),lower: countryId.toString());
    return d.map((e) => SellerModel.fromMap(e)).toList();
  }

  Future<CouponModel> checkCoupon(String hash)async{
    var d = await _client.getTableRow(contract, scope, "coupons",
      lower: hash,
      indexPosition: 2,
      keyType: "sha256",
    );
    return CouponModel.fromMap(d);
  }

  Future<TestResultModel> getTestResult(int couponId)async{
    var d = await _client.getTableRow(contract, scope, "test",
      lower: couponId.toString(),
      indexPosition: 2,
      keyType: "i64",
    );
    print(d);
    return TestResultModel.fromMap(d);    
  }
}