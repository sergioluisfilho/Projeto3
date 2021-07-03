import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:winest/controller/CellarController.dart';
import 'package:winest/controller/WishListController.dart';
import 'package:winest/models/Wine.dart';

class ListWines extends StatefulWidget {
  String uid = "";
  String countryValue = "";
  String colorValue = "";
  String sweetnessValue = "";
  String fruitValue = "";
  double maxPrice;

  ListWines(String uid, String countryValue, String colorValue,
      String sweetnessValue, String fruitValue, double maxPrice) {
    this.uid = uid;
    this.countryValue = countryValue;
    this.colorValue = colorValue;
    this.sweetnessValue = sweetnessValue;
    this.fruitValue = fruitValue;
    this.maxPrice = maxPrice;
  }

  @override
  _ListWinesState createState() => _ListWinesState();
}

class _ListWinesState extends State<ListWines> {
  @override
  CellarController _cellarController = CellarController();
  WishListController _wishListController = WishListController();

  Widget build(BuildContext context) {
    print('List Wines uid: ${widget.uid}');
    print(
        '${widget.countryValue}, ${widget.colorValue}, ${widget.sweetnessValue}, ${widget.fruitValue}, ${widget.maxPrice}');

    Future<Map> fetch() async {
      var ngrokUrl = "http://f720bd8a0f1c.ngrok.io";
      var phrase =
          'A ${widget.colorValue} and ${widget.sweetnessValue} wine with light notes of ${widget.fruitValue}';
      var url =
          "$ngrokUrl/predict/$phrase/${widget.countryValue}/${widget.maxPrice}";
      var response = await http.get(url);
      return json.decode(response.body);
    }

    fetch();

    return FutureBuilder(
      future: fetch(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Scaffold(
              backgroundColor: Color(0xFF5C115E),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Image.asset('images/no_wines_wishlist.png'),
                    SizedBox(width: 0, height: 5),
                    Text('Ooops!',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    SizedBox(width: 0, height: 60),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                          'It seems that there are no wines matching your description',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                    SizedBox(width: 0, height: 5),
                    Text('Try again with others options',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    SizedBox(width: 0, height: 40),
                    Text('Tap on Return',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    SizedBox(width: 0, height: 40),
                    Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                        child: const Text('Try Again',
                            style:
                                TextStyle(color: Colors.purple, fontSize: 20)),
                        onPressed: () => {Navigator.pop(context)},
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          snapshot.data.forEach((k, v) => print('$k: $v'));

          List<Widget> builder() {
            List<Widget> l = [];
            snapshot.data.forEach((k, v) => {
                  l.add(ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(v['title'],
                          style: TextStyle(color: Colors.white)),
                      shape: RoundedRectangleBorder(),
                      trailing: Icon(Icons.wine_bar, color: Colors.white),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                              actions: <Widget>[
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color:
                                              Color.fromRGBO(255, 223, 43, 51),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16.0)),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            Wine wine = Wine(
                                                k.toString(),
                                                v['country'].toString(),
                                                v['description'],
                                                v['points'].toString(),
                                                v['price'].toString(),
                                                v['title'],
                                                v['variety']);
                                            _cellarController.addWineToCellar(
                                                wine, widget.uid);
                                          },
                                          child: Text('Add to Cellar',
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color:
                                              Color.fromRGBO(255, 223, 43, 51),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16.0)),
                                        ),
                                        child: TextButton(
                                            onPressed: () {
                                              Wine wine = Wine(
                                                  k.toString(),
                                                  v['country'].toString(),
                                                  v['description'],
                                                  v['points'].toString(),
                                                  v['price'].toString(),
                                                  v['title'],
                                                  v['variety']);
                                              _wishListController
                                                  .addWineToWishList(
                                                      wine, widget.uid);
                                            },
                                            child: Text('Add to WishList',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black))),
                                      )
                                    ])
                              ],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 24.0,
                              backgroundColor: Color(0xFF5C115E),
                              title: Text(v['title'],
                                  style: TextStyle(color: Colors.white)),
                              content: Wrap(
                                children: <Widget>[
                                  Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Color(0xFF5C115E),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0)),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(children: [
                                              Text('Description',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          255, 223, 43, 51),
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ]),
                                            SizedBox(width: 0, height: 10),
                                            Text('${v['description']}',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            SizedBox(width: 0, height: 20),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text('Price',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              255, 223, 43, 51),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text('Points',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              255, 223, 43, 51),
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ]),
                                            SizedBox(width: 0, height: 10),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text('${v['price']}',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  Text('${v['points']}',
                                                      style: TextStyle(
                                                          color: Colors.white))
                                                ]),
                                            SizedBox(width: 0, height: 20),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text('Country',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              255, 223, 43, 51),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text('Variety',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              255, 223, 43, 51),
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ]),
                                            SizedBox(width: 0, height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text('${v['country']}',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                Text('${v['variety']}',
                                                    style: TextStyle(
                                                        color: Colors.white))
                                              ],
                                            ),
                                          ]))
                                ],
                              )),
                        );
                      }))
                });
            return l;
          }

          return Scaffold(
              backgroundColor: Color(0xFF5C115E),
              appBar: AppBar(
                  title: Text('Discover'), backgroundColor: Color(0xFF5C115E)),
              body: SingleChildScrollView(
                child: Column(children: builder()),
              ));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
