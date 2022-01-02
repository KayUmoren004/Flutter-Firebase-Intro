// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pick_up/components/app/app_button.dart';
import 'package:pick_up/components/app/app_input.dart';
import 'package:pick_up/components/loading.dart';
import 'package:pick_up/models/app_user.dart';
import 'package:pick_up/services/database.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  final String authUID;
  const SettingsForm({Key? key, required this.authUID}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> positions = [
    'GK',
    'CB',
    'LB',
    'RB',
    'DM',
    'CM',
    'AM(L/R/C)',
    'LW',
    'RW',
    'ST'
  ];

  String? _currentPosition;
  String? _currentName;
  int? _currentIntensity;
  String errMsg = '';

  @override
  Widget build(BuildContext context) {
    //final AuthUser = Provider.of<AppUser?>(context);

    print({'setting', widget.authUID});

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: widget.authUID).userData,
        builder: (context, snapshot) {
          // print(DatabaseService().uid);
          if (snapshot.hasData) {
            UserData? appUserData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your Pick Up settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 20),
                  AppInput(
                    initialValue: appUserData?.name,
                    changed: (val) {
                      setState(() {
                        _currentName = val;
                      });
                    },
                    placeholder: 'Name',
                    isPassword: false,
                    formKey: _formKey,
                  ),

                  // Dropdown
                  DropdownButtonFormField(
                      value: _currentPosition ?? appUserData?.position,
                      hint: Text('Choose a position',
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                      items: positions.map((position) {
                        return DropdownMenuItem(
                          value: position,
                          child: Text(position),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _currentPosition = val.toString();
                        });
                      }),

                  SizedBox(
                    height: 20,
                  ),
                  //Slider
                  Slider(
                      min: 100.0,
                      max: 900.0,
                      inactiveColor: Colors.green[
                          (_currentIntensity ?? appUserData?.intensity)!
                              .toInt()],
                      activeColor: Colors.green[
                          (_currentIntensity ?? appUserData?.intensity)!
                              .toInt()],
                      divisions: 8,
                      value: (_currentIntensity ?? appUserData?.intensity)!
                          .toDouble(),
                      onChanged: (val) {
                        setState(() {
                          _currentIntensity = val.round();
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  AppButton(
                      text: 'Update',
                      press: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: widget.authUID)
                              .updateUserData(
                                  _currentName ?? appUserData!.name.toString(),
                                  _currentPosition ??
                                      appUserData!.position.toString(),
                                  _currentIntensity ??
                                      appUserData!.intensity!.toInt());
                          Navigator.pop(context);
                        }
                        print({
                          'CN': _currentName,
                          'CP': _currentPosition,
                          'CI': _currentIntensity
                        });
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      radius: 14,
                      margin: 10),
                ],
              ),
            );
          } else {
            return Lottie.asset(
              'assets/loading.json',
              repeat: true,
            );
          }
        });
  }
}
