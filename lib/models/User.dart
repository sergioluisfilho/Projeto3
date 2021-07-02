import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String email;

  User(id, name, email, password) {
    this.id = id;
    this.name = name;
    this.email = email;
  }

  void createUser() {
    Firestore db = Firestore.instance;

    db.collection("User").document('${this.id}').setData({
      "id": "${this.id}",
      "name": "${this.name}",
      "email": "${this.email}",
    });

    db.collection("Cellar").document("${this.id}").setData({
      "cellarWines": []
    });

    db.collection("WishList").document("${this.id}").setData({
      "wishListWines": []
    });
  }
}
