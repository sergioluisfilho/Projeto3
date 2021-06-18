import 'package:flutter/material.dart';

class ListWines extends StatefulWidget {
  const ListWines({Key key}) : super(key: key);

  @override
  _ListWinesState createState() => _ListWinesState();
}

class _ListWinesState extends State<ListWines> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(), body: Column(children: <Widget>[Text('Wine1'), Text('Wine2')]));
  }
}
