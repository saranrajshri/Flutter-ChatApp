import 'package:flutter/material.dart';

class AppState {
  double sliderFontSize;
  String userID;
  String userName;
  Map<dynamic, dynamic> userData;
  AppState({
    @required this.sliderFontSize,
  });

  AppState.fromAppState(AppState another) {
    userID = another.userID;
    userName = another.userName;
  }

  String get getUserID => userID;
  String get getUserName => userName;
  Map<dynamic, dynamic> get getUserData => userData;
}

class UserID {
  final String payload;
  UserID(this.payload);
}

class UserName {
  final String payload;
  UserName(this.payload);
}

class UserData {
  final Map<dynamic, dynamic> payload;
  UserData(this.payload);
}
