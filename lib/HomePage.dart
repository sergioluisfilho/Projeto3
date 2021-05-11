import 'package:flutter/material.dart';
import 'package:winest/views/DigitalCellar.dart';
import 'package:winest/views/Discover.dart';
import 'package:winest/views/WishList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [WishList(), Discover(), DigitalCellar()];
    return Scaffold(
      body: telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indiceAtual,
          onTap: (indice) {
            setState(() {
              _indiceAtual = indice;
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.purple,
          items: [
            BottomNavigationBarItem(
                //backgroundColor: Colors.orange,
                label: "WishList",
                icon: Icon(Icons.plus_one)),
            BottomNavigationBarItem(
                //backgroundColor: Colors.red,
                label: "Discover",
                icon: Icon(Icons.whatshot)),
            BottomNavigationBarItem(
                //backgroundColor: Colors.blue,
                label: "Digital Cellar",
                icon: Icon(Icons.subscriptions)),
          ]),
    );
  }
}
