import 'package:epios/commons/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SimpleNavigator extends StatefulWidget {
  final List<dynamic> items;
  final Function(int selectedIndex) onSelectedItemChanged;

  SimpleNavigator(this.items,this.onSelectedItemChanged);
  @override
  _SimpleNavigatorState createState() => _SimpleNavigatorState();
}

class _SimpleNavigatorState extends State<SimpleNavigator> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.items.map((e) => _itemBuilder(index: e["index"],title: e["title"],image:e["image"])).toList(),
      ),
    );
  }

  Widget _itemBuilder({int index,String title, String image}){
    var color = index == _selectedIndex ? primaryColor : Colors.grey[700];
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          _selectedIndex = index;
          if(widget.onSelectedItemChanged != null)
            widget.onSelectedItemChanged(index);
          setState(() {
            
          });
        },
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 2,
              color: index == _selectedIndex ? primaryColor : Colors.grey[100],
            ),
            sized_10, 
            Center(
              child: Column(
                children: <Widget>[
                  SvgPicture.asset(image,color: color),
                  sized_05,
                  Text(title,style: TextStyle(color: color),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}