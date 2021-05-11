import 'package:flutter/material.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 8.0),
      child: Column(children: [
        Center(
            child: Text("Answer this form to help us find your wines",
                style: TextStyle(color: Colors.white, fontSize: 16.0))),
        ElevatedButton(
            onPressed: () {},
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
