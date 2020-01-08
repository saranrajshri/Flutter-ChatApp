import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  // State variables
  int counter = 0;

  Widget _buildEmailT() {
    return Container(
        alignment: Alignment.centerLeft,
        height: 60.0,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: "Enter your email",
              hintStyle: TextStyle(color: Colors.white)),
        ));
  }

  Widget _buildPasswordT() {
    return Container(
        alignment: Alignment.centerLeft,
        height: 60.0,
        child: TextField(
          keyboardType: TextInputType.text,
          obscureText: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: "Enter your password",
              hintStyle: TextStyle(color: Colors.white)),
        ));
  }

  Widget _buildSignInButton() {
    return Container(
        padding: EdgeInsets.only(top: 15.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () {},
          child: Text("SIGN IN TO YOUR ACCOUNT",
              style: TextStyle(color: Color(0xFF478dD0))),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ));
  }

  Widget _buildOrText() {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(
              "- OR - ",
              style:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.0),
            Text(
              "Register With",
              style: TextStyle(color: Colors.white70),
            )
          ],
        ));
  }

  Widget _buildSocialButtonsRow() {
    return Container(
      padding: EdgeInsets.only(top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0),
                ],
                image: DecorationImage(
                    image: AssetImage('assets/logos/facebook.png'))),
          ),
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0),
                ],
                image: DecorationImage(
                    image: AssetImage('assets/logos/google.png'))),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Container(
        padding: EdgeInsets.only(top: 20.0),
        alignment: Alignment.center,
        child: FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: Text(
            "Don't have an account ? SignUp",
            style: TextStyle(color: Colors.white70),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0xFF73AEF5),
                    Color(0xFF61A4F1),
                    Color(0xFF478dD0),
                    Color(0xFF398AE5)
                  ],
                      stops: [
                    0.1,
                    0.4,
                    0.7,
                    0.9
                  ])),
            ),
            Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 30.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Email", style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: 10.0,
                          ),
                          _buildEmailT(),

                          SizedBox(
                            height: 20.0,
                          ),
                          // Password
                          Text("Password",
                              style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: 10.0,
                          ),
                          _buildPasswordT(),
                          _buildSignInButton(),
                          SizedBox(
                            height: 15.0,
                          ),
                          _buildOrText(),
                          _buildSocialButtonsRow(),
                          _buildRegisterLink(),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        )));
  }
}
