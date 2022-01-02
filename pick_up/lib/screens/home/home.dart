// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick_up/models/pick_up.dart';
import 'package:pick_up/screens/home/pick_up_list.dart';
import 'package:pick_up/screens/home/setting_modal.dart';
import 'package:pick_up/services/auth.dart';
import 'package:pick_up/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final String userUID;
  Home({Key? key, required this.userUID}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    //print({'home', userUID});
    //Setting Panel
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(
                authUID: userUID,
              ),
            );
          });
    }

    return StreamProvider<List<PickUp>>.value(
      value: DatabaseService().pickUp,
      initialData: const [],
      child: Scaffold(
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
              _showSettingsPanel();
            },
            backgroundColor: Colors.green[300],
            child: const Icon(Icons.settings),
          ),
          body: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/night.webp'),
                          fit: BoxFit.cover)),
                  child: PickUpList()),
              Padding(
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Note: Color = Intensity',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              )
            ],
          )),
    );
  }
}
