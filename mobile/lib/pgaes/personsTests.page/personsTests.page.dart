import 'package:epios/commons/styles.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:epios/pgaes/buyTestKit.page/buyTestKit.page.dart';
import 'package:epios/pgaes/pending.page/pending.page.dart';
import 'package:epios/pgaes/performTest.page/performTest.page.dart';
import 'package:epios/pgaes/viewResult.page/viewResult.page.dart';
import 'package:flutter/material.dart';

class PersonsTestsPage extends StatefulWidget {
  @override
  _PersonsTestsPageState createState() => _PersonsTestsPageState();
}

class _PersonsTestsPageState extends State<PersonsTestsPage> {
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
        sized_15,
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text("Douglas' tests",style: Theme.of(context).textTheme.headline4,),
        ),
        Expanded(
          child: _testItemsBuilder(),
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
    return SizedBox(
      width: infinity,
      child: ListView(
        children: [
          {"id":"Test 0000000001","date":"01/06/20","status":0},
          {"id":"Test 0000000002","date":"01/06/20","status":1},
          {"id":"Test 0000000003","date":"01/06/20","status":2},
          {"id":"Test 0000000004","date":"01/06/20","status":3},
        ].map((e) => _testItemBuilder(e)).toList(),
      ),
    );
  }

  Widget _testItemBuilder(dynamic model) {
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
              Text(model["id"],style: t.headline6.copyWith(fontSize: 18),),
              Text(model["date"],style: t.headline6.copyWith(fontSize: 14,color:Colors.grey[600])),
            ],
          ),
          if(model["status"] == 0)
            SizedBox(
              width: 150, 
              height: 35,
              child: RaisedButton(
                child: Text("PERFORM TEST",style: buttonTextStyle),
                textColor: Colors.white,
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PerformTestPage())), 
                elevation: 0,
              ),
            )
          else if(model["status"] == 2 || model["status"] == 3)
            SizedBox(
              width: 150,
              height: 35,
              child: RaisedButton(
                child: Text("VIEW RESULTS",style: buttonTextStyle,),
                textColor: Colors.white,
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewResultPage(isPositive: model["status"] == 3 ,))), 
                elevation: 0,
              ),
            )
          else if(model["status"] == 1)
            SizedBox(
              width: 150,
              height: 35,
              child: OutlineButton(
                child: Text("PENDING",style: buttonTextStyle),
                borderSide: BorderSide(color: outlineButtonBorderColor),
                textColor: outlineButtonBorderColor,
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingPage())), 
              ),
            )
        ],
      ),
    );
  }
}