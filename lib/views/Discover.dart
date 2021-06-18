import 'package:flutter/material.dart';
import 'package:winest/views/ListWines.dart';

class Discover extends StatefulWidget {
  String uid = "";
  Discover(String uid) {
    this.uid = uid;
  }
  @override
  _DiscoverState createState() => _DiscoverState();
}

List<String> perguntas = [
  'Favorite wine producer country',
  'Designation',
  'Filter by points',
  'suitable price for you',
  'province',
  'region ',
  'name of the taster you trust',
  'variety: type of the grape',
  'winery: place that that made the wine'
];

List respostas = [];

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    print('discover uid: ${widget.uid}');
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 8.0),
      child: Column(children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
          child: Text("Answer this form to help us find your wines",
              style: TextStyle(color: Colors.white, fontSize: 16.0)),
        )),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (contex) => ListWines(widget.uid)));
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text("Find Wines",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFFFDF2B)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  //side: BorderSide(color: Colors.red)
                ))))
      ]),
    );
  }
}
