import 'package:epios/commons/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SimpleAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: infinity,
      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
      height: 70,
      child: Row(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: ()=>Navigator.pop(context),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FaIcon(FontAwesomeIcons.arrowLeft,color: primaryColor,),
                sized_10,
                Padding(
                  padding: const EdgeInsets.only(top:5.0),
                  child: Text("BACK",style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}