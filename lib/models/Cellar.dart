import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winest/models/User.dart';
import 'package:winest/models/Wine.dart';

class Cellar {
  List<Map<String, dynamic>> existingWines = [{}];

  void addWineToCellar(Wine wine, User user) {
    Firestore db = Firestore.instance;
    //existingWines.add(wine);
    int userId = user.id;

    getWines(user);

    existingWines.add({
      "id": wine.id,
      "country": wine.country,
      "description": wine.description,
      "designation": wine.designation,
      "points": wine.points,
      "price": wine.price,
      "province": wine.province,
      "region": wine.region,
      "tasterName": wine.tasterName,
      "title": wine.title,
      "variety": wine.variety
    });

    db
        .collection('Cellar')
        .document('$userId')
        .setData({'cellarWines': existingWines});
  }

  // Remoção baseada no index do ListTile
  void removeFromCellar(int index, User user) {
    Firestore db = Firestore.instance;

    getWines(user);

    existingWines.removeAt(index + 1);

    db
        .collection("Cellar")
        .document('${user.id}')
        .setData({'cellarWines': existingWines});
  }

  void getWines(User user) async {
    Firestore db = Firestore.instance;
    int userId = user.id;

    DocumentSnapshot snapshot =
        await db.collection('Cellar').document('$userId').get();

    Map<String, dynamic> winesMap = snapshot.data;
    existingWines.add(winesMap);
  }
}
