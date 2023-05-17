import 'package:flutter/material.dart';
import 'package:joyee/screens/authenticate/login_screen.dart';
import 'package:joyee/screens/authenticate/signup_screen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isLoging = true;

  @override
  Widget build(BuildContext context)  => isLoging
      ? LoginScreen(onClickedSignUp: toggle)
      : SignUpScreen(onClickedLogin: toggle);

  void toggle() => setState(() => isLoging = !isLoging);
}
