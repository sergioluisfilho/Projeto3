import 'package:flutter/material.dart';
import 'package:winest/views/DigitalCellar.dart';
import 'package:winest/views/Discover.dart';
import 'package:winest/views/WishList.dart';

class HomePage extends StatefulWidget {
  String uid = "";
  HomePage(String uid) {
    this.uid = uid;
  }
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indiceAtual = 1;
  @override
  Widget build(BuildContext context) {
    print('uid: ${widget.uid}');
    List<Widget> telas = [
      WishList(widget.uid),
      Discover(widget.uid),
      Cellar(widget.uid)
    ];
    return Scaffold(
      backgroundColor: Color(0xFF5C115E),
      body: telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indiceAtual,
          onTap: (indice) {
            setState(() {
              _indiceAtual = indice;
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Color(0xFF5C115E),
          items: [
            BottomNavigationBarItem(
                //backgroundColor: Colors.orange,
                label: "WishList",
                icon: Icon(Icons.plus_one)),
            BottomNavigationBarItem(
                //backgroundColor: Colors.red,
                label: "Discover",
                icon: Icon(Icons.graphic_eq_sharp)),
            BottomNavigationBarItem(
                //backgroundColor: Colors.blue,
                label: "Digital Cellar",
                icon: Icon(Icons.wine_bar)),
          ]),
    );
  }
}
