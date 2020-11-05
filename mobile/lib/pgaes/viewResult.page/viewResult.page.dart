import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:epios/commons/global.dart';
import 'package:epios/commons/styles.dart';
import 'package:epios/components/busyIndicator.component.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:epios/models/data.model.dart';
import 'package:epios/models/test.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:base32/base32.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViewResultPage extends StatefulWidget {
  final int couponId;

  ViewResultPage({this.couponId});

  @override
  _ViewResultPageState createState() => _ViewResultPageState();
}

class _ViewResultPageState extends State<ViewResultPage> {
  bool _showCert = false;
  String _certCode = "";
  @override
  void initState() { 
    super.initState();
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                sized_10,
                _resultBuilder(),
                sized_20,
                _noteItemBuilder("1", "Maintain social distance.\r\nStay home if you can."),
                _noteItemBuilder("2", "Wash your hands with soap and water for 20 seconds."),
                _noteItemBuilder("3", "Don’t panic. Most cases of COVID-19 are mild in nature."),
                _noteItemBuilder("4", "Wear a face mask that covers your nose and mouth to prevent airborne transmission."),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
          child: SizedBox(
            width: infinity,
            height: 40,
            child: RaisedButton(
              child: Text("OK",style: buttonTextStyle,),
              color: primaryColor,
              textColor: Colors.white,
              onPressed: ()=>Navigator.pop(context),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _resultBuilder(){
    return FutureBuilder(
      future: Global.contractService.getTestResult(widget.couponId),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<TestResultModel> s) {
        if(s.connectionState == ConnectionState.waiting)
          return BusyIndicator();
        if(s.connectionState == ConnectionState.done){
          var d = s.data;
          if(d.result == "POSITIVE"){
            return _positiveBuilder();
          }else{
            return _negativeBuilder();
          }
        }        
      }
    );
  }

  Widget _positiveBuilder() {
    var t = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        sized_15,
        SvgPicture.asset("assets/images/svgs/test_positive.svg",),
        sized_10,
        Text("Your test is positive",style: t.headline5,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
          child: Text("Some things you can do to help stem the spread of the disease",style: t.headline6.copyWith(color:Colors.grey),)
        ),
        _certBuilder()
      ],
    );
  }

  Widget _negativeBuilder() {
    var t = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        sized_15,
        SvgPicture.asset("assets/images/svgs/test_negative.svg",),
        sized_10,
        Text("Your test is negative",style: t.headline5,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
          child: Text("Some things you can do to help stem the spread of the disease",style: t.headline6.copyWith(color:Colors.grey),)
        ),
      ],
    );
  }

  Widget _noteItemBuilder(String number,String note){
    var t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 25,
            backgroundColor: primaryColor,
            child: Text(number,style: t.headline6.copyWith(color:Colors.white),),
          ),
          sized_10,
          Expanded(child: Text(note,style: t.headline6,))
        ],
      ),
    );
  }

  Widget _certBuilder(){
    if(_showCert)
      return QrImage(
        data: _certCode,
        version: QrVersions.auto,
        size: 200.0,
      );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        width: infinity,
        height: 40,
        child: RaisedButton(
          child: Text("Generate QR Certificate",style: buttonTextStyle,),
          color: primaryColor,
          textColor: Colors.white,
          onPressed: (){
            var rnd = Random().nextInt(99);
            var t = "${widget.couponId}epios$rnd";
            var bytes = utf8.encode('message');
            var hash = sha256.convert(bytes).toString();
            _certCode = "$t,$rnd,$hash";
            setState(() {
              _showCert = true;
            });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      ),
    );
  }
  
}