import 'package:epios/commons/global.dart';
import 'package:epios/commons/styles.dart';
import 'package:epios/models/data.model.dart';
import 'package:epios/pgaes/addPerson.page/addPerson.page.dart';
import 'package:epios/pgaes/personsTests.page/personsTests.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestsPage extends StatefulWidget {
  @override
  _TestsPageState createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {

  @override
  Widget build(BuildContext context) {
    if(Global.data.persons.isEmpty)
      return _noTestBuilder();
    return _testListBuilder();
  }

  Widget _noTestBuilder(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("You haven't added\r\nany people yet",style:TextStyle(fontSize: 24,fontWeight: FontWeight.w300) ,textAlign: TextAlign.center,),
        sized_10,
        Text("Click the button to add \r\nyour first user",style:textHeaderStyle ,textAlign: TextAlign.center,),
        sized_20,
        ClipOval(
          child: Material(
            color: primaryColor, // button color
            child: InkWell(
              splashColor: primaryColor, // inkwell color
              child: SizedBox(
                width: 80, 
                height: 80, 
                child: Center(
                  child: SvgPicture.asset("assets/images/svgs/user.svg",color: Colors.white,)
                )
              ),
              onTap: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPersonPage(),));
                setState(() {});
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _testListBuilder(){
    return Stack(
      children: <Widget>[
        Positioned(
          top:60,
          left:30,
          right:10,
          child: Text("Your people",style: Theme.of(context).textTheme.headline4,)
        ),
        Positioned.fill(
          top: 90,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ...Global.data.persons.values.map((e) => _testItemBuilder(e)).toList(),
            ]
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: ClipOval(
            child: Material(
              color: primaryColor, // button color
              child: InkWell(
                splashColor: primaryColor, // inkwell color
                child: SizedBox(
                  width: 50, 
                  height: 50, 
                  child: Center(
                    child: FaIcon(FontAwesomeIcons.userPlus,color: Colors.white,size: 20,)
                  )
                ),
                onTap: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPersonPage(),));
                  setState(() {});
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _testItemBuilder(PersonModel model){
    var t = Theme.of(context).textTheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonsTestsPage(model: model,))),
      child: Container(
        width: infinity,
        height: 90,
        margin: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200])),
          // color: Colors.red
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            sized_10,
            Row(
              children: <Widget>[
                Text(model.name,style: t.headline6,),
                Spacer(),
                if(model.tests.length != 0)
                  Chip(                    
                    elevation: 0,
                    label: Text(model.tests.length.toString(),style: t.caption.copyWith(color: Colors.white),),
                    backgroundColor: primaryColor,
                  ),
                sized_10,
                FaIcon(FontAwesomeIcons.chevronRight,color: primaryColor,)
              ],
            ),
            sized_10,
          ],
        ),
      ),
    );
  }
}