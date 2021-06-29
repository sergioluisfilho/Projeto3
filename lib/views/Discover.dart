import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:winest/views/ListWines.dart';
import 'package:winest/sign_in/login.dart';

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

GoogleSignIn _googleSignIn = GoogleSignIn();

bool _isLoggedIn = false;

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    var snapshots = Firestore.instance
        .collection('User')
        .where('id', isEqualTo: '${widget.uid}')
        .snapshots();
    print('discover uid: ${widget.uid}');
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFFFDF2B)),
              child: StreamBuilder(
                  stream: snapshots,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int i) {
                          var item = snapshot.data.documents[i].data;
                          return Container(
                            child: Column(
                              children: [
                                ListTile(
                                    leading: Icon(Icons.person,
                                        color: Color(0xFF5C115E)),
                                    title: Text("Name"),
                                    subtitle: Text(
                                      item['name'],
                                      style: TextStyle(
                                          color: Color(0xFF5C115E),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                ListTile(
                                  leading: Icon(Icons.mail,
                                      color: Color(0xFF5C115E)),
                                  title: Text("Email"),
                                  subtitle: Text(item['email'],
                                      style: TextStyle(
                                          color: Color(0xFF5C115E),
                                          fontSize: 16.0,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          );
                        });
                  }),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.amber,
              ),
              title: Text(
                "Settings",
              ),
            ),
            Container(
              color: Color(0xFF5C115E),
              child: ListTile(
                  leading: Icon(
                    Icons.arrow_back,
                    color: Colors.amber,
                  ),
                  title: Text("Logout",
                      style: TextStyle(
                          color: Color(0xFFFFDF2B),
                          fontWeight: FontWeight.bold)),
                  onTap: () async {
                    await _googleSignIn.signOut().then((userData) {
                      setState(() {
                        _isLoggedIn = false;
                      });
                      debugPrint('deslogado');
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (contex) => Login()));
                    }).catchError((e) {
                      print(e);
                    });
                  }),
            )
          ],
        ),
      ),
      backgroundColor: Color(0xFF5C115E),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 8.0),
        child: Column(children: [
          AppBar(
            title: Text('Welcome to Winest',
                style: TextStyle(color: Colors.white, fontSize: 20.0)),
            backgroundColor: Color(0xFF5C115E),
            centerTitle: true,
            elevation: 0,
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 40,
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: Text("Help us recommend you a great wine",
                style: TextStyle(color: Colors.white, fontSize: 16.0)),
          )),
          Container(
            margin: const EdgeInsets.all(50),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: TextFormField(
                cursorColor: Colors.purple,
                maxLines: null,
                autofocus: false,
                decoration: InputDecoration(
                    hintText: "Describe a wine you would like to try",
                    hintStyle: TextStyle(fontSize: 12, color: Colors.black),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.wine_bar, color: Colors.purple))),
          ),
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
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
