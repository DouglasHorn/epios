import 'package:eosdart/eosdart.dart';
import 'package:epios/models/country.model.dart';
import 'package:epios/models/countryManager.model.dart';

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

}