import 'package:epios/commons/styles.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          sized_50,
          Text("Hello",style: t.headline4,),
          sized_10,
          Text("Your account name",style: t.caption),
          sized_10,
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(6)
            ),
            child: Center(
              child: Text("asdfasdfasdf"),
            ),
          ),
          sized_30,
          SizedBox(
            width: infinity,
            height: 45,
            child: RaisedButton(
              child: Text("SET NEW PASSWORD",style: buttonTextStyle,),
              textColor: Colors.white,
              onPressed: (){}, 
            ),
          ),
          sized_15,
          SizedBox(
            width: infinity,
            height: 45,
            child: RaisedButton(
              child: Text("SIGN OUT",style: buttonTextStyle,),
              textColor: Colors.white,
              onPressed: (){}, 
            ),
          ),
        ],
      ),
    );
  }
}