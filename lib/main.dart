import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:winest/HomePage.dart';

void main() {

  runApp(MyApp());

  Firestore.instance.collection("col").document("doc").setData({"texto": "Lucas"});

  //runApp(MaterialApp(
  //  title: 'Winest',
  //  home: HomePage(),
  //  debugShowCheckedModeBanner: false,
  //));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Winest",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}
