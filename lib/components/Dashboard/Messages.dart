import 'package:flutter/material.dart';
import 'package:newapp/screens/messageScreen.dart';
import 'package:newapp/screens/showAllUsers.dart';

class Messages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MessagesState();
  }
}

class _MessagesState extends State<Messages> {
  Widget _buildMessagesRow(String message, String userFrom) {
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.supervised_user_circle,
          size: 40.0,
        ),
        title: Text("$userFrom"),
        subtitle: Text("$message"),
        trailing: Container(
          child: Text(
            '1',
            style: TextStyle(color: Colors.white),
          ),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(25.0)),
        ),
        isThreeLine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "My Messages",
                    style: TextStyle(fontSize: 20.0, color: Colors.black54),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowAllUsers()));
                    },
                  )
                ],
              )),
          _buildMessagesRow("How are you ?", "Saranraj"),
          _buildMessagesRow("Vanakam Di Mapla... Kappy Pongal?", "Sundar"),
        ],
      ),
    );
  }
}
