import 'package:epios/commons/global.dart';
import 'package:epios/commons/styles.dart';
import 'package:epios/components/inlineMessage.component.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:epios/models/data.model.dart';
import 'package:epios/pgaes/home.page/home.page.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _accountController = TextEditingController();
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
            Text("Sign In",style: t.headline4,),
            sized_20,
            Text("Account name",style: textHeaderStyle,),
            sized_10,
            TextField(
              controller: _accountController,
            ),
            sized_20,
            Text("Password",style: textHeaderStyle,),
            sized_10,
            TextField(
              controller: _passwordController,
            ),
            InlineMessage(model: _message),
            sized_50,
            SizedBox(
              width: infinity,
              height: 45,
              child: RaisedButton(
                child: Text("SIGN IN",style: buttonTextStyle,),
                textColor: Colors.white,
                onPressed: _onSigninPressed, 
              ),
            ),
            sized_30,
          ],
        ),
      ),
    );
  }

  void _onSigninPressed() async{
    if(_accountController.text.isEmpty){
      setState(() {
        _message = InlineMessageModel.error(message: "Please enter account name");
      });
      return;
    }
    if(_passwordController.text.isEmpty){
      setState(() {
        _message = InlineMessageModel.error(message: "Please enter password");
      });
      return;
    }
    if(_passwordController.text != Global.account.password || _accountController.text != Global.account.accountName){
      setState(() {
        _message = InlineMessageModel.error(message: "Invalid account name or password");
      });
      return;
    }
    Global.data = await Global.storage.getData();
    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (context)=>HomePage()),
      ModalRoute.withName("auth")
    );
  }
}