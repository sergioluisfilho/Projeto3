import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:winest/HomePage.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  Firestore.instance.collection("Users").document("pontos").setData({"Junior" : "324", "Rafael" : "233"});

  runApp(MyApp());

  //runApp(MaterialApp(
  //  title: 'Winest',
  //  home: HomePage(),
  //  debugShowCheckedModeBanner: false,
  //));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}