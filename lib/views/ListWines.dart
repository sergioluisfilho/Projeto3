import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:winest/models/formQuestions.dart';
import 'package:winest/views/Discover.dart';

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
  Widget build(BuildContext context) {
    print('List Wines uid: ${widget.uid}');
    print(
        '${widget.countryValue}, ${widget.colorValue}, ${widget.sweetnessValue}, ${widget.fruitValue}, ${widget.maxPrice}');

    Future<Map> fetch() async {
      var url = "https://c189719c0d24.ngrok.io/predict/red/Italy/20";
      var response = await http.get(url);
      return json.decode(response.body);
    }

    fetch();

    return FutureBuilder(
      future: fetch(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          snapshot.data.forEach((k, v) => print('${k}: ${v}'));

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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                elevation: 24.0,
                                backgroundColor: Color(0xFF5C115E),
                                title: Text(v['title'],
                                    style: TextStyle(color: Colors.white)),
                                content: Container(
                                    width: 350.0,
                                    height: 500.0,
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
                                                  MainAxisAlignment.spaceAround,
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
                                                  MainAxisAlignment.spaceAround,
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
                                                  MainAxisAlignment.spaceAround,
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
                                        ]))));
                      }))
                });
            return l;
          }

          return Scaffold(
              backgroundColor: Color(0xFF5C115E),
              appBar: AppBar(
                  title: Text('Wines classifed for you'),
                  backgroundColor: Color(0xFF5C115E)),
              body: Column(children: builder()));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
