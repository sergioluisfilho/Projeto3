import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
        child: _isLoggedIn
            ? Column(
          children: [
            Image.network(_userObj.photoUrl),
            Text(_userObj.displayName),
            Text(_userObj.email),
            TextButton(
                onPressed: () {
                  _googleSignIn.signOut().then((value) {
                    setState(() {
                      _isLoggedIn = false;
                    });
                  }).catchError((e) {});
                },
                child: Text("Logout"))
          ],
        )
            : Center(
          child: ElevatedButton(
            child: Text("Login with Google"),
            onPressed: () {
              _googleSignIn.signIn().then((userData) {
                setState(() {
                  _isLoggedIn = true;
                  _userObj = userData;
                });
              }).catchError((e) {
                print(e);
              });
            },
          ),
        ),
      ),
    );
  }
}