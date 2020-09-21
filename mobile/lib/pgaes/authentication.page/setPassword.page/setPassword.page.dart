import 'package:epios/commons/global.dart';
import 'package:epios/components/inlineMessage.component.dart';
import 'package:epios/models/account.model.dart';
import 'package:epios/services/storage.service.dart';
import 'package:flutter/material.dart';

import 'package:epios/commons/styles.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:epios/pgaes/home.page/home.page.dart';

class SetPasswordPage extends StatefulWidget {
  final String accountName;
  const SetPasswordPage({
    Key key,
    this.accountName,
  }) : super(key: key);
  @override
  _SetPasswordPageState createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  InlineMessageModel _message;
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
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
              ),
            ),
            InlineMessage(model: _message),
            // sized_20,
            // Text("Email",style: textHeaderStyle,),
            // sized_10,
            // TextField(
            //   decoration: InputDecoration(

            //   ),
            // ),
            sized_50,
            SizedBox(
              width: infinity,
              height: 45,
              child: RaisedButton(
                child: Text("SET PASSWORD",style: buttonTextStyle,),
                textColor: Colors.white,
                onPressed: _onSetPasswrodPressed, 
              ),
            ),
            sized_30,
          ],
        ),
      ),
    );
  }

  void _onSetPasswrodPressed(){
    if(_passwordController.text.isEmpty){
      setState(() {
        _message = InlineMessageModel.error(message: "Please enter your password");
      });
      return;
    }
    var acc = AccountModel(accountName: widget.accountName,password: _passwordController.text);
    Global.account = acc;
    Global.storage.setAccount(acc);

    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (context)=>HomePage()),
      ModalRoute.withName("auth")
    );
  }
} 