import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meettx_eval/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    bool hasName = false;
    Future addName({required String name, required String email}) async {
      final user = FirebaseFirestore.instance.collection('users').doc(email);
      final data = {'name': name};
      await user.set(data);
      hasName = true;
    }

    final TextEditingController nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: hasName ? Text('a') : Text(user.email!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 4),
            TextField(
              controller: nameController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration:
                  const InputDecoration(labelText: 'What is your name?'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                final name = nameController.text;

                addName(name: name, email: user.email!);
              },
              child: const Text("Add name"),
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
