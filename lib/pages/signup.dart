import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meettx_eval/firestoreHelper.dart';
import 'package:meettx_eval/user_model.dart';
import 'package:email_validator/email_validator.dart';

class SignUpPage extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpPage({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isError = false;
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 4),
            TextField(
              controller: nameController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Invalid email'
                      : null,
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value != null && value.length < 6
                  ? 'Password must be atleas 6 characters'
                  : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              icon: const Icon(Icons.lock_open, size: 32),
              label: const Text('Sign Up', style: TextStyle(fontSize: 24)),
              onPressed: signUp,
            ),
            const SizedBox(height: 24),
            RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    text: 'Already have an account? ',
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: 'Log In',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary))
                ])),
          ])));

  Future signUp() async {
    String email = emailController.text.trim();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: passwordController.text.trim());
    } on FirebaseAuthException catch (err) {
      print(err);
    }
    FirestoreHelper.create(
        UserModel(name: nameController.text, email: emailController.text));
  }
}
