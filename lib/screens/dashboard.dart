import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:newapp/components/Dashboard/Home.dart';
import 'package:newapp/components/Dashboard/Messages.dart';

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

  Future<void> _addNewPost(String postTitle, String postBody) async {
    var data = {
      "postTitle": postTitle,
      "postBody": postBody,
      // "userID": "usnbd",
      // "userName": "Somewhat"
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

  void _showAddNewPostDialog() {
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
                    _addNewPost(postTitle, postBody);
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              "Instagram Clone",
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
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text("DrawerHEader"),
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
          ),

          body: Container(
            child: _currentPage,
          ),

          // Bottom Navigation Bar
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.orangeAccent,
            onPressed: () {
              _showAddNewPostDialog();
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
                            _currentPage = Home();
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
                            _currentPage = Home();
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
        ));
  }
}
