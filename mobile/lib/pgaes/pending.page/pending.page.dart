import 'package:epios/commons/styles.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PendingPage extends StatefulWidget {
  @override
  _PendingPageState createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyBuilder(),
    );
  }

  Widget _bodyBuilder() {
    var t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SimpleAppBar(),
        Divider(),
        Expanded(child: _contentBuilder())
      ],
    );
  }

  Widget _contentBuilder(){
    var t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          sized_30,
          FaIcon(FontAwesomeIcons.hourglassHalf , size: 30,),
          sized_15,
          Text("Your test is pending",style: t.headline5,),
          sized_30,
          Text("The lab is still processing this test. You will be notified when it is complete and ready to view.",
            style: t.headline6.copyWith(color: Colors.grey[600]),
          ),
          Spacer(),
          SizedBox(
            width: infinity,
            height: 45,
            child: RaisedButton(
              child: Text("OK",style: buttonTextStyle),
              color: primaryColor,
              textColor: Colors.white,
              onPressed: ()=>Navigator.pop(context), 
            ),
          ),
        ],
      ),
    );
  }
}