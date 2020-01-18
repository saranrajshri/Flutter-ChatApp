import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:newapp/redux/appModel.dart';
import 'package:newapp/screens/messageScreen.dart';

class ShowAllUsers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShowAllUsersState();
  }
}

class _ShowAllUsersState extends State<ShowAllUsers> {
  Widget _buildUserCard(DocumentSnapshot data) {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.supervised_user_circle),
          title: Text(data["userName"]),
          trailing: IconButton(
            onPressed: () {
              StoreProvider.of<AppState>(context)
                  .dispatch(CurrentMessageTo(data.documentID));
                  StoreProvider.of<AppState>(context)
                  .dispatch(CurrentMessageToUserName(data["userName"]));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessageScreen()));
            },
            icon: Icon(Icons.send),
          ),
        )
      ],
    ));
  }

  Widget _buildUsers() {
    return Container(
      child: StreamBuilder(
        stream: Firestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print("No data");
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return _buildUserCard(snapshot.data.documents[index]);
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Select a user",
            style: TextStyle(fontFamily: "OpenSans", color: Colors.black),
          ),
        ),
        body: _buildUsers(),
      ),
    );
  }
}
