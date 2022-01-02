// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pick_up/components/app_container.dart';
import 'package:pick_up/components/auth/auth_button.dart';
import 'package:pick_up/components/loading.dart';
import 'package:pick_up/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function? isSeen;

  SignUp({Key? key, this.isSeen}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Firebase
  final AuthService _auth = AuthService();
  String err = '';
  bool loading = false;

  //State
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: AppContainer(
                err: err,
                isAuthScreen: true,
                emailChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                passwordChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                title: 'Sign Up',
                description: 'Create an account to continue',
                forgotPassPressed: () {
                  print({'FPP'});
                },
                forgotPassSeen: false,
                buttonText: 'Sign Up',
                buttonPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _auth.signUp(email, password);
                  if (result == null) {
                    setState(() {
                      err = 'Enter a valid email';
                      loading = false;
                    });
                  }
                  print({'Email': email, 'Pass': password});
                },
                buttonColor: Colors.green,
                buttonTextColor: Colors.white,
                buttonRadius: 14,
                buttonMargin: 20,
                emailInputPlaceholder: 'Email',
                passInputPlaceholder: 'Password',
                bottomMessage: 'Already have an account?',
                bottomActionText: 'Sign In',
                bottomActionPressed: () {
                  widget.isSeen!();
                }),
          );
  }
}
