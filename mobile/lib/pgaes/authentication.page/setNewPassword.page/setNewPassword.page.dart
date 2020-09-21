import 'package:epios/commons/global.dart';
import 'package:epios/commons/styles.dart';
import 'package:epios/components/inlineMessage.component.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:epios/models/account.model.dart';
import 'package:flutter/material.dart';

class SetNewPasswordPage extends StatefulWidget {
  @override
  _SetNewPasswordPageState createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
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
            Text("Set New Password",style: t.headline4,),
            sized_20,
            Text("Old Password",style: textHeaderStyle,),
            sized_10,
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
              ),
            ),
            sized_20,
            Text("New Password",style: textHeaderStyle,),
            sized_10,
            TextField(
              controller: _newPasswordController,
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
                child: Text("SET NEW PASSWORD",style: buttonTextStyle,),
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
    if(_passwordController.text != Global.account.password){
      setState(() {
        _message = InlineMessageModel.error(message: "Old password is invalid");
      });
      return;
    }
    if(_newPasswordController.text.isEmpty){
      setState(() {
        _message = InlineMessageModel.error(message: "Please enter new password");
      });
      return;
    }
    
    var acc = AccountModel(accountName: Global.account.accountName,password: _newPasswordController.text);
    Global.account = acc;
    Global.storage.setAccount(acc);
    setState(() {
      _message = InlineMessageModel.success(message: "New password has been set");
    });
  }
}