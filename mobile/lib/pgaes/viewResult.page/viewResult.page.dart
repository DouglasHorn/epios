import 'package:epios/commons/styles.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewResultPage extends StatefulWidget {
  final bool isPositive;

  ViewResultPage({this.isPositive});

  @override
  _ViewResultPageState createState() => _ViewResultPageState();
}

class _ViewResultPageState extends State<ViewResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyBuilder(),
    );
  }

  Widget _bodyBuilder() {
    return Column(
      children: <Widget>[
        SimpleAppBar(),
        sized_10,
        if(widget.isPositive)
          _positiveBuilder()
        else
          _negativeBuilder(),
        sized_20,
        _noteItemBuilder("1", "Maintain social distance.\r\nStay home if you can."),
        _noteItemBuilder("2", "Wash your hands with soap and water for 20 seconds."),
        _noteItemBuilder("3", "Don’t panic. Most cases of COVID-19 are mild in nature."),
        _noteItemBuilder("4", "Wear a face mask that covers your nose and mouth to prevent airborne transmission."),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            width: infinity,
            height: 40,
            child: RaisedButton(
              child: Text("OK",style: buttonTextStyle,),
              color: primaryColor,
              textColor: Colors.white,
              onPressed: ()=>Navigator.pop(context),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          ),
        ),
        sized_30
      ],
    );
  }

  Widget _positiveBuilder() {
    var t = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        sized_15,
        SvgPicture.asset("assets/images/svgs/test_positive.svg",),
        sized_10,
        Text("Your test is positive",style: t.headline5,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
          child: Text("Some things you can do to help stem the spread of the disease",style: t.headline6.copyWith(color:Colors.grey),)
        ),
      ],
    );
  }

  Widget _negativeBuilder() {
    var t = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        sized_15,
        SvgPicture.asset("assets/images/svgs/test_negative.svg",),
        sized_10,
        Text("Your test is negative",style: t.headline5,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
          child: Text("Some things you can do to help stem the spread of the disease",style: t.headline6.copyWith(color:Colors.grey),)
        ),
      ],
    );
  }

  Widget _noteItemBuilder(String number,String note){
    var t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 25,
            backgroundColor: primaryColor,
            child: Text(number,style: t.headline6.copyWith(color:Colors.white),),
          ),
          sized_10,
          Expanded(child: Text(note,style: t.headline6,))
        ],
      ),
    );
  }
  
}