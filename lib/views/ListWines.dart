import 'package:flutter/material.dart';

class ListWines extends StatefulWidget {
  String uid = "";
  ListWines(String uid) {
    this.uid = uid;
  }

  @override
  _ListWinesState createState() => _ListWinesState();
}

class _ListWinesState extends State<ListWines> {
  @override
  Widget build(BuildContext context) {
    print('List Wines uid: ${widget.uid}');
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: <Widget>[Text('Wine1'), Text('Wine2')]));
  }
}
