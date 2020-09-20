import 'package:epios/pgaes/authentication.page/authentication.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'commons/styles.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.black,
        // For iOS.
        statusBarBrightness: Brightness.light,
      ),
      child: MaterialApp(
        title: 'Epios',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0            
          ),
          textTheme: TextTheme(
            headline3: TextStyle(color: Colors.black,fontSize: 44),
            headline4: TextStyle(color: Colors.black,fontSize: 32),
          ),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "helvetica",
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[400],),borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
          ),
          buttonTheme: ButtonThemeData(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
            ),
            textTheme: ButtonTextTheme.normal,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),

          ),
        ),

        home: AuthenticationPage(),
      ),
    );
  }
}