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
      var url =
          "http://996586700c76.ngrok.io/predict/Tart%20cherry%20and%20light,%20with%20velvety%20mushroom%20with%20lingering%20tannins/Italy/20";
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
            snapshot.data.forEach((k, v) => l.add(ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(v['title']),
                trailing: Text(k.toString()),
                onTap: () {})));
            return l;
          }

          return Scaffold(
              appBar: AppBar(title: Text('Wines classifed 4 u')),
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
