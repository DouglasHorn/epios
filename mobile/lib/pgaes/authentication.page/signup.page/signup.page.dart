import 'package:epios/commons/styles.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:epios/pgaes/authentication.page/setPassword.page/setPassword.page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _accountController = TextEditingController();
  String _message;

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
            Text("Create account",style: t.headline4,),
            sized_20,
            Text("Your new account name",style: t.headline6.copyWith(color:Colors.black.withOpacity(0.6),fontSize: 12),),
            sized_10,
            TextField(
              controller: _accountController,
              maxLength: 10,
              decoration: InputDecoration(
                
              ),
            ),
            SizedBox(
              height: 30,
              child: _message!=null ? Text(_message,style: const TextStyle(color: Colors.red),):null,
            ),
            sized_50,
            SizedBox(
              width: infinity,
              height: 45,
              child: RaisedButton(
                elevation: 0,
                child: Text("ACCEPT",style: TextStyle(fontWeight: FontWeight.bold),),
                textColor: Colors.white,
                onPressed: _onAcceptPressed
              ),
            ),
            sized_30,
          ],
        ),
      ),
    );
  }

  void _onAcceptPressed(){
    if(_accountController.text.isEmpty){
      setState(() {
        _message = "Account name can't be empty!";
      });
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SetPasswordPage(accountName: _accountController.text,)));
  }
}