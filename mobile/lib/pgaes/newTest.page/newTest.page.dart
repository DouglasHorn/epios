import 'package:flutter/material.dart';

import 'package:epios/commons/global.dart';
import 'package:epios/commons/styles.dart';
import 'package:epios/components/inlineMessage.component.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:epios/models/data.model.dart';

class NewTestPage extends StatefulWidget {
  final PersonModel model;
  const NewTestPage({
    Key key,
    @required this.model,
  }) : super(key: key);
  @override
  _NewTestPageState createState() => _NewTestPageState();
}

class _NewTestPageState extends State<NewTestPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  InlineMessageModel _message;
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
        Divider(),
        Expanded(
          child: _formBuilder(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
          child: SizedBox(
            width: infinity,
            height: 45,
            child: RaisedButton(
              child: Text("ADD TEST",style: buttonTextStyle,),
              textColor: Colors.white,
              onPressed: _onAddPersionPressed, 
            ),
          ),
        ),
      ],
    );
  }

  Widget _formBuilder() {
    var t = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            sized_20,
            Text("Add a new test for ${widget.model.name}",style: t.headline5,),
            sized_20,
            Text("Title",style: textHeaderStyle,),
            sized_10,
            TextField(controller: _titleController,),
            sized_20,
            Text("Description",style: textHeaderStyle,),
            sized_10,
            TextField(controller: _descriptionController,),
            InlineMessage(model: _message,),
          ]
        ),
      ),
    );
  }

  void _onAddPersionPressed()async{
    if(_titleController.text.isEmpty){
      setState(() {
        _message = InlineMessageModel.error(message: "Please enter a title");
      });
      return;
    }
    widget.model.tests.add(
      TestModel(
        title: _titleController.text,
        description: _descriptionController.text,
        status: -1,
        testDate: DateTime.now().millisecondsSinceEpoch
      ),
    );
    await Global.storage.setData(Global.data);
    Navigator.pop(context);
  }

}