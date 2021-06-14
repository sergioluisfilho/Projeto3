import 'package:winest/HomePage.dart';

import 'sign_up_service.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameInputController = TextEditingController();
  TextEditingController _mailInputController = TextEditingController();
  TextEditingController _passwordInputController = TextEditingController();
  TextEditingController _confirmInputController = TextEditingController();

  bool showPassword = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(92, 17, 94, 2),
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
                          if (value.length < 10) {
                            return "Type a larger name";
                          }
                          return null;
                        },
                        controller: _nameInputController,
                        autofocus: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: Icon(
                            Icons.person,
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
                            return "The password must contain at least 6 caracthers";
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
                    (this.showPassword == false)
                        ? Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value != _passwordInputController.text) {
                                  return "The passwords must be the same";
                                }
                                return null;
                              },
                              controller: _confirmInputController,
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Confirm the password",
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
                          )
                        : Container(),
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
                  setState(() {
                    _doSignUp();
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (contex) => HomePage()));
                  });
                },
                child: Text("Register"),
                color: Color.fromRGBO(255, 223, 43, 51),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doSignUp() {
    if (_formKey.currentState.validate()) {
      SignUpService().signUp(
        _mailInputController.text,
        _passwordInputController.text,
      );
    } else {
      print("Invalid");
    }
  }
}
