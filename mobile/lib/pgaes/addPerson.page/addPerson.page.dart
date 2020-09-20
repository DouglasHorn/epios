import 'package:epios/commons/styles.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:flutter/material.dart';

class AddPersonPage extends StatefulWidget {
  @override
  _AddPersonPageState createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
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
              child: Text("ADD PERSON",style: buttonTextStyle,),
              textColor: Colors.white,
              onPressed: (){}, 
            ),
          ),
        ),
      ],
    );
  }

  Widget _formBuilder() {
    var t = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            sized_20,
            Text("Add a person",style: t.headline4,),
            sized_20,
            Text("Name or label",style: textHeaderStyle,),
            sized_10,
            TextField(
              decoration: InputDecoration(

              ),
            ),
            sized_20,
            Text("Zipcode",style: textHeaderStyle,),
            sized_10,
            TextField(
              decoration: InputDecoration(

              ),
            ),
            sized_20,
            sized_20,
            Text("We respect your privacy.\r\nThis information never\r\nleaves the application.",style: t.headline6.copyWith(color:Colors.grey),),
          ]
        ),
      ),
    );
  }
}
