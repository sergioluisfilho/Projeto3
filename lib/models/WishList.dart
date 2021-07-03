import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winest/models/Wine.dart';

class WishList {
  List<Map<String, dynamic>> existingWinesWishList = [];

  void addWineToWishList(Wine wine, String userId) async {
    Firestore db = Firestore.instance;

    await db.collection('WishList').document('$userId').updateData({
      'wishListWines': FieldValue.arrayUnion([
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

  Future<List<dynamic>> removeFromWishList(int index, String userId) async {
    Firestore db = Firestore.instance;

    await getWines(userId);
    print(existingWinesWishList);

    List<dynamic> data = existingWinesWishList[0]['wishListWines'].toList();
    data.removeAt(index);
    existingWinesWishList[0]['wishListWines'] = data;

    db
        .collection("WishList")
        .document('$userId')
        .setData({'wishListWines': existingWinesWishList[0]['wishListWines']});

    return existingWinesWishList[0]['wishListWines'];
  }

  Future<List<Map<String, dynamic>>> getWines(String userId) async {
    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot =
        await db.collection('WishList').document('$userId').get();

    Map<String, dynamic> winesMap = snapshot.data;
    existingWinesWishList.add(winesMap);
    return existingWinesWishList;
  }
}
