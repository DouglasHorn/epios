import 'package:epios/commons/styles.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuyTestKitPage extends StatefulWidget {
  @override
  _BuyTestKitPageState createState() => _BuyTestKitPageState();
}

class _BuyTestKitPageState extends State<BuyTestKitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyBuilder(),
    );
  }

  Widget _bodyBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SimpleAppBar(),
        Divider(),
        Spacer(),
        FaIcon(FontAwesomeIcons.question,size: 40,),
        Spacer(),
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
}