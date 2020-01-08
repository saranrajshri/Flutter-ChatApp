import 'package:flutter/material.dart';
import 'package:newapp/screens/login.dart';
import 'package:newapp/screens/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/login': (context) => Login(),
        '/register': (context) => Register(),
      },
    );
  }
}
