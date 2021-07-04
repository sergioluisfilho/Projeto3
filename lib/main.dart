import 'package:flutter/material.dart';
import 'package:winest/sign_in/login.dart';
import 'package:winest/views/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Winest',
    home: MyHomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends  StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
