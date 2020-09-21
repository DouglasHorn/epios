import 'package:flutter/material.dart';

class InlineMessageModel {
  final String message;
  final Color textColor;
  InlineMessageModel({
    this.message,
    this.textColor,
  });

  factory InlineMessageModel.error({String message="Error"}){
    return InlineMessageModel(message: message,textColor:Colors.red);
  }
}

class InlineMessage extends StatefulWidget {
  final InlineMessageModel model;
  const InlineMessage({
    Key key,
    this.model,
  }) : super(key: key);
  @override
  _InlineMessageState createState() => _InlineMessageState();
}

class _InlineMessageState extends State<InlineMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height:40,
      child: widget.model!=null ? Text(widget.model.message,style: TextStyle(color: widget.model.textColor),):null,      
    );
  }
}