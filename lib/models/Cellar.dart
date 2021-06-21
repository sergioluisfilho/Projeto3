import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winest/models/User.dart';
import 'package:winest/models/Wine.dart';

class Cellar {
  List<Map<String, dynamic>> existingWines = [{}];

  void addWineToCellar(Wine wine, String userId) {
    Firestore db = Firestore.instance;

    getWines(userId);

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
  void removeFromCellar(int index, String userId) {
    Firestore db = Firestore.instance;

    getWines(userId);

    existingWines.removeAt(index + 1);

    db
        .collection("Cellar")
        .document('${userId}')
        .setData({'cellarWines': existingWines});
  }

  Future<List<Map<String, dynamic>>> getWines(String userId) async {
    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot =
        await db.collection('Cellar').document('$userId').get();

    Map<String, dynamic> winesMap = snapshot.data;
    existingWines.add(winesMap);
    existingWines.removeAt(0);
    return existingWines;
  }
}
