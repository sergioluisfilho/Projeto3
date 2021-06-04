import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winest/HomePage.dart';
import 'package:winest/sign_up/sign_up.dart';

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
      backgroundColor: Color.fromRGBO(92, 17, 94, 2),
      // appBar: AppBar(title: Text("Login")),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: _isLoggedIn
              ? Center(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  ),
                )
              : Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('images/logo.png'),
                    Center(
                      // ignore: deprecated_member_use
                      child: OutlineButton.icon(
                        label: Text(
                          'Sign In With Google',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        shape: StadiumBorder(),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        highlightedBorderColor: Colors.black,
                        borderSide: BorderSide(color: Colors.white),
                        textColor: Colors.black,
                        icon:
                            FaIcon(FontAwesomeIcons.google, color: Colors.red),
                        onPressed: () {
                          _googleSignIn.signIn().then((userData) {
                            setState(() {
                              _isLoggedIn = true;
                              _userObj = userData;
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (contex) => HomePage()));
                            });
                          }).catchError((e) {
                            print(e);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("LOGIN ERROR"),
                                  );
                                });
                          });
                        },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                          child: Text("Create account"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (contex) => SignUpPage()));
                          }),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
