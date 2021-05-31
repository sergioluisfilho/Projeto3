import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:winest/constrants/routes.dart';

class SignUpService {
  signUp(String email, String password) async {
    http.Response response = await http.post(
      Routes.signUp,
      body: json.encode(
        {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      ),
    );

    print(response.body);
  }
}