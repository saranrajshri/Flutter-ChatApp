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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.supervised_user_circle),
                color: Colors.black,
                onPressed: () {},
              )
            ],
          ),

          body: Container(
            child: _currentPage,
          ),

          
          // Bottom Navigation Bar
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.orangeAccent,
            onPressed: () {},
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
