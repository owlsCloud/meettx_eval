import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? name;
  final String? email;

  UserModel({this.name, this.email});

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(name: snapshot['name'], email: snapshot['email']);
  }

  Map<String, dynamic> toJson() => {'name': name, 'email': email};
}
