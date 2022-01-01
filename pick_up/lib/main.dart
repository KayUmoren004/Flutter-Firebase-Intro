// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pick_up/components/loading.dart';
import 'package:pick_up/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pick_up/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/app_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Wrapper(),
        home: StreamProvider<AppUser?>.value(
          value: AuthService().user,
          initialData: null,
          child: Wrapper(),
        ));
  }
}
