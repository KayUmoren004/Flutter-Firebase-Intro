// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pick_up/components/app_container.dart';
import 'package:pick_up/components/auth/auth_button.dart';
import 'package:pick_up/components/loading.dart';
import 'package:pick_up/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function? isSeen;
  const SignIn({Key? key, this.isSeen}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  //State
  String email = '';
  String password = '';
  String err = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    //print({email, password});
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
                title: 'Sign In',
                description: 'Sign In to continue',
                forgotPassPressed: () {
                  print({'FPP'});
                },
                forgotPassSeen: true,
                buttonText: 'Sign In',
                buttonPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _auth.signIn(email, password);
                  if (result == null) {
                    setState(() {
                      err = 'Enter a valid email or password';
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
                bottomMessage: 'Don\u0027t have an account?',
                bottomActionText: 'Create account',
                bottomActionPressed: () {
                  widget.isSeen!();
                }),
          );
  }
}
