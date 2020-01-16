import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {

  void _logOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("Change Preferences"),
            leading: Icon(Icons.settings),
          ),
          Divider(
            color: Colors.black12,
          ),
          ListTile(
            title: Text("Language Settings"),
            leading: Icon(Icons.language),
          ),
          Divider(
            color: Colors.black12,
          ),
          ListTile(
            title: Text("Account Settings"),
            leading: Icon(Icons.settings_phone),
          ),
          Divider(
            color: Colors.black12,
          ),
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              _logOut();
            },
          ),
          Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}
