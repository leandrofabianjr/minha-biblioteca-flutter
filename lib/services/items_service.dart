import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minha_biblioteca/services/auth.dart';

class ItemsService {
  CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('items');

  Future<dynamic> list() {
    final user = Auth.currentUser;
    // Call the user's CollectionReference to add a new user
    return itemsCollection
        .where(
          'uid',
          isEqualTo: user?.uid,
        )
        .get()
        .then((value) {
      final map = value.docs.map((element) {
        return element.data();
      });
      return map;
    }).catchError((err) {
      print(err);
    });
  }
}
