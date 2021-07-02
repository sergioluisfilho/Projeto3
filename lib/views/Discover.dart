import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:winest/views/ListWines.dart';
import 'package:winest/sign_in/login.dart';
import 'package:winest/models/formQuestions.dart';

class Discover extends StatefulWidget {
  String uid = "";
  Discover(String uid) {
    this.uid = uid;
  }

  @override
  _DiscoverState createState() => _DiscoverState();
}

GoogleSignIn _googleSignIn = GoogleSignIn();

String countryValue = 'Country';
String colorValue = 'Color                                  ';
String sweetnessValue = 'Sweetness                        ';
String fruitValue = 'Fruit                                    ';
String scentValue = 'Scent                                  ';

bool _isLoggedIn = false;
double price;
var newPrice;

class _DiscoverState extends State<Discover> {
  double _currentValue = 3300;
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
          child: ListView(children: [
            AppBar(
              title: Text('Welcome to Winest',
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
              backgroundColor: Color(0xFF5C115E),
              centerTitle: true,
              elevation: 0,
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 30,
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 05),
              child: Text("Help us recommend you a great wine",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
            )),
            SizedBox(width: 0, height: 40),
            Text("The higher amount are you willing to pay",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: Slider(
                value: _currentValue,
                min: 4,
                max: 3300,
                divisions: 3300,
                activeColor: Colors.yellow,
                inactiveColor: Colors.purple,
                label: _currentValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentValue = value;
                  });
                },
              ),
            ),
            Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                  child: DropdownButton<String>(
                    dropdownColor: Color(0xFF5C115E),
                    value: countryValue,
                    icon: const Icon(Icons.arrow_downward, color: Colors.white),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    underline: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        countryValue = newValue;
                      });
                    },
                    items:
                        countries.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              SizedBox(width: 0, height: 5),
              Padding(
                  padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                  child: DropdownButton<String>(
                    dropdownColor: Color(0xFF5C115E),
                    value: colorValue,
                    icon: const Icon(Icons.arrow_downward, color: Colors.white),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    underline: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        colorValue = newValue;
                      });
                    },
                    items: colors.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              SizedBox(width: 0, height: 5),
              Padding(
                  padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                  child: DropdownButton<String>(
                    dropdownColor: Color(0xFF5C115E),
                    value: sweetnessValue,
                    icon: const Icon(Icons.arrow_downward, color: Colors.white),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    underline: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        sweetnessValue = newValue;
                      });
                    },
                    items:
                        sweetness.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              SizedBox(width: 0, height: 5),
              Padding(
                  padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                  child: DropdownButton<String>(
                    dropdownColor: Color(0xFF5C115E),
                    value: fruitValue,
                    icon: const Icon(Icons.arrow_downward, color: Colors.white),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    underline: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        fruitValue = newValue;
                      });
                    },
                    items: fruits.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
            ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
              child: ElevatedButton(
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
            )
          ])),
    );
  }
}
