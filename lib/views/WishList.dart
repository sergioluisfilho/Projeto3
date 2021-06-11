import 'package:flutter/material.dart';
import 'package:winest/controller/WishListController.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  WishListController _controller = WishListController();

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("WishList")));
  }
}
