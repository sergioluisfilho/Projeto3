import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winest/models/Wine.dart';

class WishList {
  List<Map<String, dynamic>> existingWines = [{}];

  void addWineToWishList(Wine wine, String userId) {
    Firestore db = Firestore.instance;

    getWines(userId);

    existingWines.add({
      "id": wine.id,
      "country": wine.country,
      "description": wine.description,
      "points": wine.points,
      "price": wine.price,
      "title": wine.title,
      "variety": wine.variety
    });

    db
        .collection('WishList')
        .document('$userId')
        .setData({'wishListWines': existingWines});
  }

  Future<List<dynamic>> removeFromWishList(int index, String userId) async {
    Firestore db = Firestore.instance;

    await getWines(userId);
    print(existingWines);

    // print('antes $existingWines');
    List<dynamic> data = existingWines[0]['wishListWines'].toList();
    data.removeAt(index);
    existingWines[0]['wishListWines'] = data;
    print(existingWines[0]['wishListWines']);
    // print('depois $existingWines');

    db
        .collection("WishList")
        .document('$userId')
        .setData({'wishListWines': existingWines[0]['wishListWines']});

    return existingWines[0]['wishListWines'];
  }

  Future<List<Map<String, dynamic>>> getWines(String userId) async {
    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot =
        await db.collection('WishList').document('$userId').get();

    Map<String, dynamic> winesMap = snapshot.data;
    existingWines.add(winesMap);
    existingWines.removeAt(0);
    return existingWines;
  }
}
