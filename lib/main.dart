import 'package:flutter/material.dart';
import 'package:newapp/screens/login.dart';
import 'package:newapp/screens/messageScreen.dart';
import 'package:newapp/screens/register.dart';
import 'package:newapp/screens/dashboard.dart';
import 'package:newapp/screens/splashScreen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:newapp/redux/appModel.dart';
import 'package:newapp/redux/reducers/reducers.dart';

void main() {
  final _initialState = AppState(sliderFontSize: 0.5);
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  runApp(MyApp(store: _store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          '/dashboard': (context) => DashBoard(),
          '/message': (context) => MessageScreen(),
        },
      ),
      store: store,
    );
  }
}
