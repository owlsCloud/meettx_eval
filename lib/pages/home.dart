import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meettx_eval/firestoreHelper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final userEmail = user.email;

    return Scaffold(
      appBar: AppBar(
        title: Text(userEmail!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Streambuilder always listens, Futurebuilder listens once
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(userEmail)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var userDoc = snapshot.data!;
                  return Text(
                    "Hello ${userDoc["name"]}",
                    style: const TextStyle(fontSize: 28),
                  );
                })),
            const SizedBox(height: 4),
            TextField(
              controller: nameController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  labelText: 'Would you like to change your name?'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40)),
              onPressed: () =>
                  FirestoreHelper.updateName(user, nameController.text),
              child: const Text(
                'Change name',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Spacer(),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              icon: const Icon(Icons.arrow_back, size: 32),
              label: const Text(
                'Sign Out',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () => FirebaseAuth.instance.signOut(),
            )
          ],
        ),
      ),
    );
  }
}
