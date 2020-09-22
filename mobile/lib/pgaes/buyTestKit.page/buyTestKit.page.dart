import 'package:epios/commons/global.dart';
import 'package:epios/commons/styles.dart';
import 'package:epios/components/busyIndicator.component.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:epios/models/country.model.dart';
import 'package:epios/models/seller.model.dart';
import 'package:epios/pgaes/selectCountry.page/selectCountry.page.dart';
import 'package:epios/services/contract.service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuyTestKitPage extends StatefulWidget {
  @override
  _BuyTestKitPageState createState() => _BuyTestKitPageState();
}

class _BuyTestKitPageState extends State<BuyTestKitPage> {
  CountryModel _selectedCountry;
  Future<List<SellerModel>> _sellers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyBuilder(),
    );
  }

  Widget _bodyBuilder() {
    var t = Theme.of(context).textTheme;    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SimpleAppBar(),
        Divider(),
        if(_selectedCountry == null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text("Please select a country",style: t.headline6,),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(_selectedCountry.countryName,style: t.headline6,),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
          child: SizedBox(
            width: infinity,
            height: 35,
            child: OutlineButton(
              child: Text("SELECT COUNTRY",style: buttonTextStyle),
              color: primaryColor,
              borderSide: BorderSide(color: outlineButtonBorderColor),
              textColor: outlineButtonBorderColor,
              onPressed: ()async{
                var t = await Navigator.push(context,MaterialPageRoute(builder: (context)=>SelectCountryPage()));
                if(t==null)
                  return;
                _selectedCountry = t;
                _sellers = Global.contractService.getSellers(1);
                setState(() {});
              }, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          ),
        ),
        if(_selectedCountry != null)
          Expanded(child: _sellerBuilder(),)
        else
          Expanded(child: Center(child: Text("Please select your country to see the sellers"),),),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: SizedBox(
            width: infinity,
            height: 35,
            child: OutlineButton(
              child: Text("CONFIRM TEST PURCHASE",style: buttonTextStyle),
              color: primaryColor,
              borderSide: BorderSide(color: outlineButtonBorderColor),
              textColor: outlineButtonBorderColor,
              onPressed: (){}, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          ),
        )
      ],
    );
  }

  Widget _sellerBuilder() {
    return Padding(
      padding: const EdgeInsets.only(top:10.0),
      child: FutureBuilder(
        future: _sellers,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<List<SellerModel>> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: BusyIndicator());
          if(snapshot.connectionState == ConnectionState.done){
            if(!snapshot.hasData || snapshot.data.isEmpty)
              return Center(
                child: Text("There is no active seller for\r\n${_selectedCountry.countryName}",textAlign: TextAlign.center,),
              );
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                ...snapshot.data.map((e) => _sellerItemBuilder(e)).toList()
              ],
            );
          }
          return Text("");
        },
      ),
    );
  }

  Widget _sellerItemBuilder(SellerModel e) {
    var t = Theme.of(context).textTheme;    

    return Container(
      // height: 60,
      width: infinity,
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300],width: 1))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(e.name,style:t.headline5 ,),
          sized_10,
          Text(e.address,style: TextStyle(color: Colors.grey),),
          Text(e.url,style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}