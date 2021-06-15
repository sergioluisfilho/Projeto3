import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:winest/constrants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

class SignUpService {
   signUp(String email, String password) async {
    var data = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return data.uid;
  
  }
}
