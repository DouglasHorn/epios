import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'package:epios/commons/extension.dart';
import 'package:epios/commons/global.dart';
import 'package:epios/commons/styles.dart';
import 'package:epios/components/inlineMessage.component.dart';
import 'package:epios/components/simpleAppBar.component.dart';
import 'package:epios/models/data.model.dart';
import 'package:epios/services/contract.service.dart';

class PerformTestPage extends StatefulWidget {
  final TestModel model;
  const PerformTestPage({
    Key key,
    @required this.model,
  }) : super(key: key);
  @override
  _PerformTestPageState createState() => _PerformTestPageState();
}

class _PerformTestPageState extends State<PerformTestPage> {
  var _state = 0;
  InlineMessageModel _message;
  String _couponId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyBuilder(),
    );
  }

  Widget _bodyBuilder() {
    var t = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        SimpleAppBar(),
        Divider(),
        if(_state == 0)
          Expanded(
            child: Column(
              children: <Widget>[
                sized_10,
                Text("IDENTIFY YOURSELF",style: t.caption.copyWith(color:Colors.blue,fontSize: 16,fontWeight: FontWeight.bold),),
                sized_10,
                Text("Scan your QR code",style: t.headline5,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Text("Your test will have a card with a privacy foil covering your unique QR code. Scratch it off and scan your code.",style: textHeaderStyle,)
                ),
                InlineMessage(model: _message,),
                SvgPicture.asset("assets/images/svgs/scanqr.svg"),
                sized_20,
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                  child: SizedBox(
                    width: infinity,
                    height: 35,
                    child: OutlineButton(
                      child: Text("NEXT",style: buttonTextStyle),
                      color: primaryColor,
                      borderSide: BorderSide(color: outlineButtonBorderColor),
                      textColor: outlineButtonBorderColor,
                      onPressed: ()async{
                        String cameraScanResult = await scanner.scan();
                        if(cameraScanResult!=null){
                          try {
                            var hash = cameraScanResult.getCouponHash;
                            _message = InlineMessageModel.info(message: "Validating coupon ...");
                            setState(() {});
                            var d = await Global.contractService.checkCoupon(hash.getLittleEndian);
                            if(d.secretKeyHash != hash){
                              _message = InlineMessageModel.error(message: "This coupon is not valid in database");
                            }else{
                              _couponId = cameraScanResult;
                              _state = 1;
                            }                            
                          } catch (e) {
                            _message = InlineMessageModel.error(message:"Invalid coupon code");
                          }
                        }
                        setState(() {});
                      }, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                )
              ],
            ),
          )        
        else if(_state == 1)
          Expanded(
            child: Column(
              children: <Widget>[
                sized_20,
                Text("PERFORM THE TEST",style: t.caption.copyWith(color:Colors.blue,fontSize: 16,fontWeight: FontWeight.bold),),
                sized_10,
                Text("Complete your test",style: t.headline5,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Text("You’ll find detailed instructions attached to your test. Follow them and continue.",style: textHeaderStyle,)
                ),
                SvgPicture.asset("assets/images/svgs/test.svg"),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                  child: SizedBox(
                    width: infinity,
                    height: 35,
                    child: OutlineButton(
                      child: Text("NEXT",style: buttonTextStyle),
                      color: primaryColor,
                      borderSide: BorderSide(color: outlineButtonBorderColor),
                      textColor: outlineButtonBorderColor,
                      onPressed: ()async{
                        setState(() {
                          _state = 2;
                        });
                      }, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                )
              ],
            ),
          )
        else if(_state == 2)
          Expanded(
            child: Column(
              children: <Widget>[
                sized_20,
                Text("SEND TO THE LAB",style: t.caption.copyWith(color:Colors.blue,fontSize: 16,fontWeight: FontWeight.bold),),
                sized_10,
                Text("Seal your envelope",style: t.headline5,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Text("You’re nearly done. Simply place the test tube and the documentation in the envelope and send it back to us.",style: textHeaderStyle,)
                ),
                SvgPicture.asset("assets/images/svgs/mail.svg"),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                  child: SizedBox(
                    width: infinity,
                    height: 35,
                    child: OutlineButton(
                      child: Text("COMPLETE",style: buttonTextStyle),
                      color: primaryColor,
                      borderSide: BorderSide(color: outlineButtonBorderColor),
                      textColor: outlineButtonBorderColor,
                      onPressed: ()async{
                        widget.model.couponId = _couponId;
                        Global.storage.setData(Global.data);
                        Navigator.pop(context);
                      }, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}