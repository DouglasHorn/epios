import 'package:epios/commons/styles.dart';
import 'package:epios/components/simpleNavigator.component.dart';
import 'package:epios/pgaes/home.page/map.page.dart';
import 'package:epios/pgaes/home.page/tests.page.dart';
import 'package:epios/pgaes/home.page/user.page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyBuilder(),
    );
  }

  Widget _bodyBuilder() {
    return Column(
      children: <Widget>[
        Expanded(
          child: _contentBuilder(),
        ),
        SizedBox(
          height: 60,
          width: infinity,
          child: SimpleNavigator(
            [
              {"title":"Tests","index":0,"image":"assets/images/svgs/virus.svg"},
              {"title":"User","index":1,"image":"assets/images/svgs/user.svg"},
              {"title":"Map","index":2,"image":"assets/images/svgs/map.svg"},
            ],
            (int newIndex){
              setState(() {
                _selectedTab = newIndex;
              });
            }
          ),
        )
      ],
    );
  }

  Widget _contentBuilder() {
    if(_selectedTab == 0)
      return TestsPage();
    if(_selectedTab == 1)
      return UserPage();
    if(_selectedTab == 2)
      return MapPage();
    return sized_05;
  }

}