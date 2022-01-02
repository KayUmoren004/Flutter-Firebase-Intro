// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pick_up/models/app_user.dart';
import 'package:pick_up/screens/auth/authenticate.dart';
import 'package:pick_up/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthUser = Provider.of<AppUser?>(context);

    //print({'wrapper', AuthUser?.uid});

    // return home || auth
    return AuthUser == null
        ? Authenticate()
        : Home(
            userUID: AuthUser.uid.toString(),
          );
  }
}
