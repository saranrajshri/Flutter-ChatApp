import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:newapp/components/Dashboard/Home.dart';
import 'package:newapp/components/Dashboard/Messages.dart';
import 'package:newapp/components/Dashboard/Search.dart';
import 'package:newapp/components/Dashboard/Settings.dart';
import 'package:newapp/redux/appModel.dart';
import 'package:newapp/redux/reducers/reducers.dart';

class DashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashBoardState();
  }
}

class _DashBoardState extends State<DashBoard> {
  int _currentTabIndex = 0;
  Widget _currentPage = Home();
  String postTitle;
  String postBody;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> _addNewPost(
      String postTitle, String postBody, AppState state) async {
    var data = {
      "postTitle": postTitle,
      "postBody": postBody,
      "userID": state.userID,
      "userName": state.userData["userName"],
    };
    try {
      Firestore.instance.collection("posts").add(data);
      _showSnackBar("Posted Successfully", "success");
    } catch (e) {
      print(e.message);
    }
  }

  void _showSnackBar(String message, String variant) {
    final snackBar = SnackBar(
      content: Text("$message"),
      backgroundColor: variant == "danger" ? Colors.red : Colors.green,
      duration: Duration(seconds: 2),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _showAddNewPostDialog(AppState state) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add a new post"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                onChanged: (text) {
                  setState(() {
                    postTitle = text;
                  });
                },
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Title"),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                onChanged: (text) {
                  setState(() {
                    postBody = text;
                  });
                },
                maxLines: null,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Description"),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(color: Colors.transparent),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  color: Colors.blueAccent,
                  elevation: 5.0,
                  child: Text(
                    "Post",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _addNewPost(postTitle, postBody, state);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void getUserData(String userID) {
    Firestore.instance.collection('users').document(userID).get().then(
        (DocumentSnapshot) => {
              StoreProvider.of<AppState>(context)
                  .dispatch(UserData(DocumentSnapshot.data))
            });
  }

  @override
  void initState() {
    super.initState();
    _getUser().then((user) {
      if (user != null) {
        getUserData(user.uid);
        StoreProvider.of<AppState>(context).dispatch(UserID(user.uid));
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  Future<FirebaseUser> _getUser() async {
    return await FirebaseAuth.instance.currentUser();
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        "Blogger",
        style: TextStyle(
          color: Colors.black,
          fontFamily: "OpenSans",
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 2.0,
      iconTheme: IconThemeData(color: Colors.black),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.supervised_user_circle),
          color: Colors.black,
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("Blogger"),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Messages'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Contact Us'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('FeedBack'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            // print(state.userID);
            return Scaffold(
              key: _scaffoldKey,
              appBar: _buildAppBar(),
              drawer: _buildDrawer(),

              // Body
              body: Container(
                child: _currentPage,
              ),

              // Bottom Navigation Bar
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: Colors.orangeAccent,
                onPressed: () {
                  _showAddNewPostDialog(state);
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                child: Container(
                  height: 60.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                _currentPage = Home();
                                _currentTabIndex = 0;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.home,
                                    color: _currentTabIndex == 0
                                        ? Colors.blue
                                        : Colors.grey),
                                Text("Home",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: _currentTabIndex == 0
                                            ? Colors.blue
                                            : Colors.grey))
                              ],
                            ),
                            minWidth: 40.0,
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                _currentPage = Search();
                                _currentTabIndex = 1;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.search,
                                    color: _currentTabIndex == 1
                                        ? Colors.blue
                                        : Colors.grey),
                                Text("Search",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: _currentTabIndex == 1
                                            ? Colors.blue
                                            : Colors.grey))
                              ],
                            ),
                            minWidth: 40.0,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                _currentPage = Messages();
                                _currentTabIndex = 2;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.send,
                                    color: _currentTabIndex == 2
                                        ? Colors.blue
                                        : Colors.grey),
                                Text("Messages",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: _currentTabIndex == 2
                                            ? Colors.blue
                                            : Colors.grey))
                              ],
                            ),
                            minWidth: 40.0,
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                _currentPage = Settings();
                                _currentTabIndex = 3;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.settings,
                                    color: _currentTabIndex == 3
                                        ? Colors.blue
                                        : Colors.grey),
                                Text("Settings",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: _currentTabIndex == 3
                                            ? Colors.blue
                                            : Colors.grey))
                              ],
                            ),
                            minWidth: 40.0,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
