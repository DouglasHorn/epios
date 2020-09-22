import 'package:epios/commons/global.dart';
import 'package:epios/commons/styles.dart';
import 'package:epios/components/busyIndicator.component.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:epios/models/country.model.dart';
import 'package:flutter/material.dart';

class SelectCountryPage extends StatefulWidget {
  @override
  _SelectCountryPageState createState() => _SelectCountryPageState();
}

class _SelectCountryPageState extends State<SelectCountryPage> {
  Future<List<CountryModel>> _countries;
  CountryModel _selectedCountry;

  @override
  void initState() {
    super.initState();
    _countries = Global.contractService.getCountries();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyBuilder(),
    );
  }

  Widget _bodyBuilder() {
    return Column(
      children: <Widget>[
        SimpleAppBar(),
        Divider(),
        Expanded(
          child: _formBuilder(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
          child: SizedBox(
            width: infinity,
            height: 45,
            child: RaisedButton(
              child: Text("SELECT AND BACK",style: buttonTextStyle,),
              textColor: Colors.white,
              onPressed: _onSelectPressed, 
            ),
          ),
        ),
      ],
    );
  }

  Widget _formBuilder(){
    return FutureBuilder(
      future: _countries,
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<List<CountryModel>> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          return BusyIndicator();
        if(snapshot.connectionState == ConnectionState.done){

          return ListView(
            children: [
              ...snapshot.data.map((e) => _countryItemBuilder(e)).toList()
            ],
          );
        }
      },
    );
  }

  void _onSelectPressed()async{
    Navigator.pop(context,_selectedCountry);
  }

  Widget _countryItemBuilder(CountryModel data) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _selectedCountry = data;
        });
      },
      child: Container(
        height: 40,
        width: infinity,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300],width: 1))
        ),
        child: Row(
          children: [
            sized_15,
            Text(data.countryName),
            Spacer(),
            if(_selectedCountry == data)
              Icon(Icons.check,color: primaryColor,),
            sized_15
          ],
        ),
      ),
    );
  }
}