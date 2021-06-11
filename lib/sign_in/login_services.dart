import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:winest/constrants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

class LoginService {
  login(String email, String password) async {
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((response) => print(response));
  }
}
