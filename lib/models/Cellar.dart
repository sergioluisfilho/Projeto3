import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winest/models/Wine.dart';

class Cellar {
  List<Map<String, dynamic>> existingWines = [];

  void addWineToCellar(Wine wine, String userId) async {
    Firestore db = Firestore.instance;

    await db.collection('Cellar').document('$userId').updateData({
      'cellarWines': FieldValue.arrayUnion([
        {
          "id": wine.id,
          "country": wine.country,
          "description": wine.description,
          "points": wine.points,
          "price": wine.price,
          "title": wine.title,
          "variety": wine.variety
        }
      ])
    });
  }

  // Remoção baseada no index do ListTile
  Future<List<dynamic>> removeFromCellar(int index, String userId) async {
    Firestore db = Firestore.instance;

    await getWines(userId);
    print(existingWines);

    // print('antes $existingWines');
    List<dynamic> data = existingWines[0]['cellarWines'].toList();
    data.removeAt(index - 1);
    existingWines[0]['cellarWines'] = data;
    print(existingWines[0]['cellarWines']);
    // print('depois $existingWines');

    db
        .collection("Cellar")
        .document('$userId')
        .setData({'cellarWines': existingWines[0]['cellarWines']});

    return existingWines[0]['cellarWines'];
  }

  Future<List<Map<String, dynamic>>> getWines(String userId) async {
    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot =
        await db.collection('Cellar').document('$userId').get();

    Map<String, dynamic> winesMap = snapshot.data;
    existingWines.add(winesMap);
    return existingWines;
  }
}
