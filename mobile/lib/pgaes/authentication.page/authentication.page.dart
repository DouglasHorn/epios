import 'package:epios/commons/global.dart';
import 'package:epios/commons/styles.dart';
import 'package:epios/components/busyIndicator.component.dart';
import 'package:epios/models/account.model.dart';
import 'package:epios/pgaes/authentication.page/signin.page/signin.page.dart';
import 'package:epios/pgaes/authentication.page/signup.page/signup.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyBuilder(),
    );
  }

  Widget _bodyBuilder() {
    var t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          sized_30,
          SvgPicture.asset("assets/images/svgs/epios_logo.svg",height: 100),
          Spacer(),
          Text("Easy lab\r\ntesting at your\r\nfingertips.",style: t.headline4.copyWith(color: Colors.black,fontSize: 32),textAlign: TextAlign.left,),
          sized_30,
          SizedBox(
            width: MediaQuery.of(context).size.width-100,
            child: Text("For your safety and those around you, it is recommended that everyone gets tested. Let’s keep our communities safe.",
              style: t.caption.copyWith(fontSize: 12,color: Colors.black.withOpacity(0.6)),
            )
          ),
          sized_30,
          _buttonBuilder(),
        ],
      ),
    );
  }

  Widget _buttonBuilder(){
    return FutureBuilder(
      future: Global.storage.getAccount(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<AccountModel> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          return BusyIndicator();
        if(snapshot.connectionState == ConnectionState.done){
          Global.account = snapshot.data;
          return Column(
            children: [
              if(snapshot.data == null)
                SizedBox(
                  width: infinity,
                  height: 45,
                  child: RaisedButton(
                    child: Text("SIGN UP",style: TextStyle(fontWeight: FontWeight.bold)),
                    textColor: Colors.white,
                    onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage(),settings: RouteSettings(name: "auth"))), 
                    elevation: 0,
                  ),
                ),
              if(snapshot.data != null)
                SizedBox(
                  width: infinity,
                  height: 45,
                  child: RaisedButton(
                    child: Text("SIGN IN",style: TextStyle(fontWeight: FontWeight.bold),),
                    textColor: Colors.white,
                    onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninPage())), 
                    elevation: 0,
                  ),
                ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}