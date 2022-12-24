import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meettx_eval/user_model.dart';

class FirestoreHelper {
  static Future create(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection('users');

    final docRef = userCollection.doc(user.email);

    final newUser = UserModel(name: user.name, email: user.email).toJson();
    try {
      await docRef.set(newUser);
    } catch (e) {
      print(e);
    }
  }

  static Future updateName(user, newName) async {
    final userCollection = FirebaseFirestore.instance.collection('users');

    final docRef = userCollection.doc(user.email);

    try {
      await docRef.update({'name': newName});
    } catch (e) {
      print(e);
    }
  }
}
