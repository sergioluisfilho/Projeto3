import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winest/models/User.dart';
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
        .collection('WishList')
        .document('$userId')
        .setData({'wishListWines': existingWines});
  }

  void removeFromWishList(int index, String userId) {
    Firestore db = Firestore.instance;

    getWines(userId);

    existingWines.removeAt(index + 1);

    db
        .collection("WishList")
        .document('${userId}')
        .setData({'wishListWines': existingWines});
  }

  void getWines(String userId) async {
    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot =
        await db.collection('WishList').document('$userId').get();

    Map<String, dynamic> winesMap = snapshot.data;
    existingWines.add(winesMap);
  }
}
