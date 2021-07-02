import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListWines extends StatefulWidget {
  String uid = "";
  ListWines(String uid) {
    this.uid = uid;
  }

  @override
  _ListWinesState createState() => _ListWinesState();
}

class _ListWinesState extends State<ListWines> {
  @override
  Widget build(BuildContext context) {
    print('List Wines uid: ${widget.uid}');

    Future<Map> fetch() async {
      var url =
          "http://6d841ba2def4.ngrok.io/predict/Tart%20cherry%20and%20light,%20with%20velvety%20mushroom%20with%20lingering%20tannins/Italy/20";
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
