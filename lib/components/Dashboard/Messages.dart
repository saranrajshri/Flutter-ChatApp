import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return _MessagesState();
  }
}

class _MessagesState extends State<Messages> {
  Widget _buildMessagesRow() {
    return Row(
      children: <Widget>[
        Padding(
          child: Icon(Icons.supervised_user_circle, size: 30.0),
          padding: EdgeInsets.only(right: 10.0),
        ),
        Padding(
          padding: EdgeInsets.only(right: 30.0),
          child: Text(
            "SARANRAJ",
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "1",
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(10.0)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            height: 50.0,
            child: _buildMessagesRow(),
            decoration: BoxDecoration(
                color: Colors.white70,
                border: Border(
                    bottom: BorderSide(color: Colors.black12, width: 1.0))),
          )
        ],
      ),
    );
  }
}
