// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pick_up/services/auth.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pick Up',
          style: TextStyle(fontWeight: FontWeight.w200, fontSize: 32),
        ),
        backgroundColor: Colors.green[300],
        elevation: 0,
        centerTitle: false,
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.exit_to_app),
            label: Text('Logout'),
            style: TextButton.styleFrom(primary: Colors.black),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Settings Pressed');
        },
        backgroundColor: Colors.green[300],
        child: const Icon(Icons.settings),
      ),
    );
  }
}
