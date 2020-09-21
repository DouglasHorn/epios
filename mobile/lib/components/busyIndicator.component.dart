import 'package:epios/commons/styles.dart';
import 'package:flutter/material.dart';

class BusyIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Center(
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(primaryColor),),
      ),
    );
  }
}