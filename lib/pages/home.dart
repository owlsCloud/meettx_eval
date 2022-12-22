import 'package:firebase_auth/firebase_auth.dart';
import 'package:meettx_eval/auth.dart';
import 'package:flutter/material.dart';
import 'package:meettx_eval/pages/login.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
    );
  }
}
