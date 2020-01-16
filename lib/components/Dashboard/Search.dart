import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchState();
  }
}

class _SearchState extends State<Search> {
  @override   
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            child: Text(
              "Search Users",
              style: TextStyle(fontSize: 20.0),
            ),
            padding: EdgeInsets.all(20.0),
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Card(
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search here", prefixIcon: Icon(Icons.search)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
