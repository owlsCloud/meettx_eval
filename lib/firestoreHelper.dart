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

  // static String read(user) async {

  //   final userDoc =
  //       FirebaseFirestore.instance.collection('users').doc(user.email);

  // }
}
