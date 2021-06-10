import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:winest/HomePage.dart';
import 'package:winest/sign_up/sign_up.dart';
import 'file:///C:/Users/lucas/Desktop/Projeto3/lib/sign_in/login.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  //Firestore.instance.collection("Users").document("pontos").setData({"Junior" : "324", "Rafael" : "233"});

  //runApp(MyApp());

  runApp(MaterialApp(
    title: 'Winest',
    home: Login(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}