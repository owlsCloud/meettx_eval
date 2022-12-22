import 'package:flutter/material.dart';
import 'package:meettx_eval/pages/login.dart';
import 'package:meettx_eval/pages/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(onClickedSignUp: toggle)
      : SignUpPage(onClickedSignIn: toggle);
  void toggle() => setState(() => isLogin = !isLogin);
}
