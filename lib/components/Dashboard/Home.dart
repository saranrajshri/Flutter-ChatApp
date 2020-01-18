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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _buildCard(
      BuildContext context, DocumentSnapshot data, AppState state) {
    var userName = data['userName'];
    var userID = data['userID'];
    var postTile = data['postTitle'];
    var postBody = data['postBody'];
    bool alreadyLiked = false;

    String comment;

    List<dynamic> newListOfLikes = List<dynamic>();
    List<dynamic> newListOfComments = List<dynamic>();

    var likes = data["likes"];
    var comments = data['comments'];

    // add likes data to the infinite length list
    for (int i = 0; i < likes.length; i++) {
      newListOfLikes.add(likes[i]);
    }

    // add comments data to the infinite length list
    for (int i = 0; i < comments.length; i++) {
      newListOfComments.add(comments[i]);
    }

    // check  if the user has already liked the post
    for (int i = 0; i < newListOfLikes.length; i++) {
      if (newListOfLikes[i]["userID"].toString() == state.userID) {
        alreadyLiked = true;
      }
    }

    // add like function
    void _addLike(String documentID) {
      newListOfLikes.add(
          {"userID": state.userID, "userName": state.userData["userName"]});
      alreadyLiked = true;
      try {
        Firestore.instance.collection('posts').document(documentID).updateData({
          "likes": newListOfLikes,
        });
      } catch (e) {
        print(e.message);
      }
    }

    // Add comment
    void _addComment(documentID) {
      newListOfComments.add({
        "userID": state.userID,
        "userName": state.userData["userName"],
        "comment": comment
      });

      try {
        Firestore.instance
            .collection('posts')
            .document(documentID)
            .updateData({"comments": newListOfComments});
      } catch (e) {
        print(e.message);
      }
    }

    Widget _buildComments() {
      List<Widget> comments = List<Widget>();
      for (int i = 0; i < newListOfComments.length; i++) {
        final commentContainer = Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10.0),
            child: newListOfComments[i]['userName'] != null
                ? Row(
                    children: <Widget>[
                      Text(
                        "${newListOfComments[i]['userName']} : ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${newListOfComments[i]['comment']}")
                    ],
                  )
                : Center(
                    child: Text("No Comments"),
                  ));

        comments.add(commentContainer);
      }

      return Column(children: comments);
    }

    void _showCommentsDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                content: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Comments",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                _buildComments(),
              ],
            ));
          });
    }

    // show comments dialog
    void _showAddCommentDialog(String documentID) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Add Comment"),
              content: Container(
                  height: 150.0,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            comment = text;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter your comment here'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          _addComment(documentID);
                        },
                        color: Colors.blueAccent,
                        child:
                            Text("Add", style: TextStyle(color: Colors.white)),
                      )
                    ],
                  )),
            );
          });
    }

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
        Container(
          padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 5.0),
          alignment: Alignment.centerLeft,
          child: newListOfLikes.length > 0
              ? Text("${newListOfLikes.length} likes")
              : null,
        ),
        Divider(
          color: Colors.black12,
          height: 1.0,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: !alreadyLiked
                    ? IconButton(
                        icon: Icon(Icons.favorite),
                        onPressed: () {
                          _addLike(data.documentID);
                        },
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("Already liked");
                        },
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    _showAddCommentDialog(data.documentID);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        Container(
            alignment: Alignment.centerLeft,
            child: FlatButton(
              onPressed: () {
                _showCommentsDialog();
              },
              child: Text("Show Comments"),
            ))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Container(
              key: _scaffoldKey,
              child: StreamBuilder(
                  stream: Firestore.instance.collection("posts").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text("Loading...."),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data);
                        return _buildCard(
                            context, snapshot.data.documents[index], state);
                      },
                    );
                  }));
        });
  }
}
