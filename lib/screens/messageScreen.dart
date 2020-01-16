import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "dart:async";
import 'package:flutter_redux/flutter_redux.dart';
import 'package:newapp/redux/appModel.dart';

class MessageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MessageScreenState();
  }
}

class _MessageScreenState extends State<MessageScreen> {
  String currentDocID;
  List<dynamic> newListOfMessages = List<dynamic>();
  ScrollController _controller = ScrollController();

  // Appbar
  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2.0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        )
      ],
      title: Text(
        "SuperMan",
        style: TextStyle(fontFamily: "OpenSans", color: Colors.black),
      ),
    );
  }

  // add message to firebase
  void _sendMessage(String message, AppState state) {
    newListOfMessages.add({
      "userID": state.userID,
      "message": message,
      "time": (DateTime.now().hour).toString() +
          ":" +
          (DateTime.now().minute).toString()
    });
    try {
      Firestore.instance
          .collection("messages")
          .document(currentDocID)
          .updateData({"messages": newListOfMessages});
      Timer(Duration(milliseconds: 100), () => _controller.jumpTo(_controller.position.maxScrollExtent));    } catch (e) {
      print(e.message);
    }
  }

  // Message Input Field
  Widget _buildMessageInputRow(AppState state) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        textInputAction: TextInputAction.go,
        autofocus: true,
        onSubmitted: (message) {
          _sendMessage(message, state);
        },
        decoration: InputDecoration(hintText: 'Enter your message here'),
      ),
    );
  }

  Widget _buildMessageRow(
      BuildContext context, DocumentSnapshot data, AppState state) {
    // set the current document ID
    currentDocID = data.documentID;

    var messages = data["messages"];

    newListOfMessages.clear();
    for (int i = 0; i < messages.length; i++) {
      newListOfMessages.add(messages[i]);
    }

    List<Widget> messagesColumn = List<Widget>();
    for (int i = 0; i < newListOfMessages.length; i++) {
      String message = newListOfMessages[i]["message"];
      String messageFrom = newListOfMessages[i]["userID"];
      String time = newListOfMessages[i]["time"];
      messagesColumn.add(Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
          child: Row(
            mainAxisAlignment: messageFrom == state.userID
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 200.0,
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "$message",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    decoration: BoxDecoration(
                        color: messageFrom == state.userID
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20.0, top: 5.0),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "$time",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              )
            ],
          )));
    }

    return Column(children: messagesColumn);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: _buildAppBar(),
          body: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    Expanded(
                        child: StreamBuilder(
                      stream: Firestore.instance
                          .collection("messages")
                          .where("userFrom", isEqualTo: state.userID)
                          .where("userTo", isEqualTo: "")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          print("Loading...");
                        }

                        return ListView.builder(
                          controller: _controller,
                          itemCount: 1,
                          // reverse: true,
                          itemBuilder: (context, index) {
                            return _buildMessageRow(
                                context, snapshot.data.documents[0], state);
                          },
                        );
                      },
                    )),
                    _buildMessageInputRow(state),
                  ],
                );
              }),
        ));
  }
}
