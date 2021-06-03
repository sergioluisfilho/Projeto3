import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  int id;
  String name;
  String email;
  String password;
  String token;
  bool responseForm;

  User(id, name, email, password) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.password = password;
  }

  void createUser() {
    Firestore db = Firestore.instance;

    db.collection("User").document('${this.id}').setData({
      "id": "${this.id}",
      "name": "${this.name}",
      "email": "${this.email}",
      "password": "${this.password}",
    });

    db.collection("Cellar").document("${this.id}").setData({
      "cellarWines": [{}]
    });

    db.collection("WishList").document("${this.id}").setData({
      "wishListWines": [{}]
    });
  }
}
