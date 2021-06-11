import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
<<<<<<< HEAD
import 'package:winest/HomePage.dart';
import 'package:winest/sign_up/sign_up.dart';
=======
import 'package:google_sign_in/google_sign_in.dart';
import 'package:winest/sign_in/login_services.dart';
>>>>>>> dev-lucas

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  bool showPassword = false;

  TextEditingController _mailInputController = TextEditingController();
  TextEditingController _passwordInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(92, 17, 94, 2),
<<<<<<< HEAD
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
=======
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 50,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
              ),
              Image.asset('images/logo.png'),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        validator: (value) {
                          if (value.length < 5) {
                            return "This email is too short";
                          } else if (!value.contains("@")) {
                            return "That email looks a little weird, doesn't it?";
                          }
                          return null;
                        },
                        controller: _mailInputController,
                        autofocus: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "E-mail",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(92, 17, 94, 2),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(92, 17, 94, 2),
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        validator: (value) {
                          if (value.length < 6) {
                            return "The password must contains at least 6 caracthers";
                          }
                          return null;
                        },
                        controller: _passwordInputController,
                        obscureText: (this.showPassword == true) ? false : true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: Icon(
                            Icons.vpn_key_sharp,
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(92, 17, 94, 2),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(92, 17, 94, 2),
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                    ),
                    Container(),
                    Row(
                      children: [
                        Checkbox(
                          value: this.showPassword,
                          onChanged: (bool newValue) {
                            setState(() {
                              this.showPassword = newValue;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                        Text(
                          "Show Password",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _doSignIn();
                },
                child: Text("Login"),
                color: Color.fromRGBO(255, 223, 43, 51),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 10,
                ),
              ),
              RaisedButton.icon(
                color: Colors.white,
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
                label: Text(
                  'Sign In With Google',
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                textColor: Colors.black,
                icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
              ),
            ],
          ),
>>>>>>> dev-lucas
        ),
      ),
    );
  }
<<<<<<< HEAD
=======

  void _doSignIn() {
    if (_formKey.currentState.validate()) {
      LoginService().login(
        _mailInputController.text,
        _passwordInputController.text,
      );
    } else {
      print("Invalid");
    }
  }
>>>>>>> dev-lucas
}
