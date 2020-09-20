import 'package:epios/commons/styles.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:epios/pgaes/home.page/home.page.dart';
import 'package:flutter/material.dart';

class SetPasswordPage extends StatefulWidget {
  @override
  _SetPasswordPageState createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
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
        Expanded(child: _contentBuilder()),
      ],
    );
  }

  Widget _contentBuilder() {
    var t = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            sized_30,
            Text("Set Password",style: t.headline4,),
            sized_20,
            Text("Password",style: textHeaderStyle,),
            sized_10,
            TextField(
              decoration: InputDecoration(

              ),
            ),
            sized_20,
            Text("Email",style: textHeaderStyle,),
            sized_10,
            TextField(
              decoration: InputDecoration(

              ),
            ),
            sized_50,
            SizedBox(
              width: infinity,
              height: 45,
              child: RaisedButton(
                child: Text("SET PASSWORD",style: buttonTextStyle,),
                textColor: Colors.white,
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())), 
              ),
            ),
            sized_30,
          ],
        ),
      ),
    );
  }
} 