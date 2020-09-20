import 'package:epios/services/contract.service.dart';
import 'package:test/test.dart';

void main(){
  
  group("Contract Service Test", (){

    var contractService = ContractService();
    contractService.init();

    test("Get country managers", ()async{
      var countryManagers = await contractService.getCountryManagers();
      print(countryManagers);
      expect(countryManagers[0].countryId, 1);
    });

    test("Get countries", ()async{
      var countries = await contractService.getCountries();
      print(countries);
      expect(countries[0].countryId, 1);
    });

  });
}