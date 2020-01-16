import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:newapp/redux/appModel.dart';
import 'package:newapp/redux/reducers/reducers.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  Widget _buildCard(BuildContext context, DocumentSnapshot data,) {
    var userName = data['userName'];
    var userID = data['userID'];
    var postTile = data['postTitle'];
    var postBody = data['postBody'];
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          title: Text("$postTile"),
          leading: Icon(
            Icons.supervised_user_circle,
            size: 40.0,
          ),
          subtitle: Text("Posted by $userName"),
        ),
        Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Text(postBody),
            )),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Container(
              child: StreamBuilder(
                  stream: Firestore.instance.collection("posts").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading");
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data);
                        return _buildCard(
                            context, snapshot.data.documents[index]);
                      },
                    );
                  })
                  );
        });
  }
}
