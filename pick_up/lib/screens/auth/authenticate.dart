// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pick_up/components/app_container.dart';
import 'package:pick_up/screens/auth/sign_in.dart';
import 'package:pick_up/screens/auth/sign_up.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() => setState(() {
        showSignIn = !showSignIn;
      });
  @override
  Widget build(BuildContext context) {
    return showSignIn ? SignIn(isSeen: toggleView) : SignUp(isSeen: toggleView);
  }
}
