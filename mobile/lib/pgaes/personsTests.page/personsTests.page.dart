import 'package:epios/commons/global.dart';
import 'package:epios/components/busyIndicator.component.dart';
import 'package:epios/models/coupon.model.dart';
import 'package:epios/pgaes/newTest.page/newTest.page.dart';
import 'package:epios/services/contract.service.dart';
import 'package:flutter/material.dart';

import 'package:epios/commons/styles.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:epios/models/data.model.dart';
import 'package:epios/pgaes/buyTestKit.page/buyTestKit.page.dart';
import 'package:epios/pgaes/pending.page/pending.page.dart';
import 'package:epios/pgaes/performTest.page/performTest.page.dart';
import 'package:epios/pgaes/viewResult.page/viewResult.page.dart';
import 'package:epios/commons/extension.dart';

class PersonsTestsPage extends StatefulWidget {
  final PersonModel model;
  const PersonsTestsPage({
    Key key,
    @required this.model,
  }) : super(key: key);
  @override
  _PersonsTestsPageState createState() => _PersonsTestsPageState();
}

class _PersonsTestsPageState extends State<PersonsTestsPage> {
  PersonModel _model;
  @override
  void initState() {
    super.initState();
    _model=widget.model;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyBuilder(),
    );
  }

  Widget _bodyBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SimpleAppBar(),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text("${_model.name}'s tests",style: Theme.of(context).textTheme.headline4,),
        ),
        Expanded(
          child: _testItemsBuilder(),
        ),
        if(_model.tests.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10 ),
            child: SizedBox(
              width: infinity,
              height: 45,
              child: RaisedButton(
                child: Text("ADD NEW TEST",style: buttonTextStyle),
                textColor: Colors.white,
                onPressed: _onAddNewTestPressed,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 30,right: 30,bottom: 30 ),
          child: SizedBox(
            width: infinity,
            height: 45,
            child: RaisedButton(
              child: Text("BUY TEST KIT",style: buttonTextStyle),
              textColor: Colors.white,
              onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyTestKitPage())), 
            ),
          ),
        ),

      ],
    );
  }

  Widget _testItemsBuilder() {
    var t = Theme.of(context).textTheme;    
    if(_model.tests.isEmpty)
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${_model.name} has no test\r\nPlease add a new test",style: t.headline6.copyWith(color:Colors.grey),),
            Padding(
              padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10 ),
              child: SizedBox(
                width: 180,
                height: 45,
                child: RaisedButton(
                  child: Text("ADD NEW TEST",style: buttonTextStyle),
                  textColor: Colors.white,
                  onPressed: _onAddNewTestPressed,
                ),
              ),
            ),
          ],
        ),
      );
    return SizedBox(
      width: infinity,
      child: ListView(
        children: [
          ..._model.tests.map((e) => _testItemBuilder(e)).toList()
        ],
      ),
    );
  }

  Widget _testItemBuilder(TestModel model) {
    var t = Theme.of(context).textTheme;
    return Container(
      width: infinity,
      height: 70,
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200])),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(model.title,style: t.headline6.copyWith(fontSize: 18),),
              Text(model.description??"",style: t.headline6.copyWith(fontSize: 14,color:Colors.grey[600])),
            ],
          ),
          if(model.couponId==null)
            SizedBox(
              width: 150, 
              height: 35,
              child: RaisedButton(
                child: Text("PERFORM TEST",style: buttonTextStyle),
                textColor: Colors.white,
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PerformTestPage(model: model,))), 
                elevation: 0,
              ),
            )
          else
            _buildWidget(model)
        ],
      ),
    );
  }

  Widget _buildWidget(TestModel model){
    return FutureBuilder(
      future: Global.contractService.checkCoupon(model.couponId.getCouponHash.getLittleEndian),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<CouponModel> s) {
        if(s.connectionState == ConnectionState.waiting)
          return BusyIndicator();

        if(s.connectionState == ConnectionState.done){
          var d = s.data;
          if(d.status == 0)
            return SizedBox(
              width: 150,
              height: 35,
              child: OutlineButton(
                child: Text("PENDING",style: buttonTextStyle),
                borderSide: BorderSide(color: outlineButtonBorderColor),
                textColor: outlineButtonBorderColor,
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingPage())), 
              ),
            );
          if(model.status == 2 || model.status == 3)
            return SizedBox(
              width: 150,
              height: 35,
              child: RaisedButton(
                child: Text("VIEW RESULTS",style: buttonTextStyle,),
                textColor: Colors.white,
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewResultPage(isPositive: model.status == 3 ,))), 
                elevation: 0,
              ),
            );
        }
      },
    );
  }

  void _onAddNewTestPressed()async{
    await Navigator.push(context, MaterialPageRoute(builder: (context)=>NewTestPage(model: widget.model,)));
    setState(() {
      _model= Global.data.persons[_model.name];
    });
  }
}