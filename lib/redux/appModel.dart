import 'package:flutter/material.dart';

class AppState {
  double sliderFontSize;
  String userID;
  String userName;
  String currentMessageTo;
  String currentMessageToUserName;

  Map<dynamic, dynamic> userData;
  AppState({
    @required this.sliderFontSize,
  });

  AppState.fromAppState(AppState another) {
    userID = another.userID;
    userName = another.userName;
    currentMessageTo = another.currentMessageTo;
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

class CurrentMessageTo {
  final String payload;
  CurrentMessageTo(this.payload);
}

class CurrentMessageToUserName {
  final String payload;
  CurrentMessageToUserName(this.payload);
}
