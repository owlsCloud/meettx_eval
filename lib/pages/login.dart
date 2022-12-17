import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? error = "";
  bool isLogin = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signIn() async {
    try {
      await Auth().signIn(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (err) {
      setState(() {
        error = err.message;
      });
    }
  }

  Future<void> createUser() async {
    try {
      await Auth().createUser(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (err) {
      setState(() {
        error = err.message;
      });
    }
  }

  Widget _title() {
    return const Text('meet-tx');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(error == '' ? '' : 'Humm ? $error');
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin ? signIn : createUser,
        child: Text(isLogin ? 'Login' : "Register"));
  }

  Widget _loginButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Register Instead' : "Login Instead"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _title()),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('email', _emailController),
            _entryField('password', _passwordController),
            _errorMessage(),
            _submitButton(),
            _loginButton()
          ],
        ),
      ),
    );
  }
}
