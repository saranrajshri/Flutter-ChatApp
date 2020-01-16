import 'package:newapp/redux/appModel.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is UserID) {
    newState.userID = action.payload;
  }

  if (action is UserName) {
    newState.userName = action.payload;
  }

  if (action is UserData) {
    newState.userData = action.payload;
    print(newState.userData);
  }

  return newState;
}
