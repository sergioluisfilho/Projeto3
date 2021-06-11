import 'package:flutter/material.dart';
import 'package:winest/controller/CellarController.dart';

class DigitalCellar extends StatefulWidget {
  @override
  _DigitalCellarState createState() => _DigitalCellarState();
}

class _DigitalCellarState extends State<DigitalCellar> {

  CellarController _controller = CellarController();

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("DigitalCellar")));
  }
}
