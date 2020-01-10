import 'package:flutter/material.dart';
import 'package:newapp/screens/login.dart';
import 'package:newapp/screens/register.dart';
import 'package:newapp/screens/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/dashboard':(context)=>DashBoard(),
      },
    );
  }
}
