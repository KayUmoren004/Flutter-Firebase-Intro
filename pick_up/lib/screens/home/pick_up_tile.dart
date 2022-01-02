// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:pick_up/models/pick_up.dart';

class PickUpTile extends StatelessWidget {
  final PickUp players;

  const PickUpTile({Key? key, required this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var intensity;
    var name;
    var position;
    if (players.intensity != null &&
        players.name != null &&
        players.position != null) {
      intensity = players.intensity;
      name = players.name;
      position = players.position;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.green[intensity],
          ),
          title: Text(name),
          subtitle: Text('Plays $position'),
        ),
      ),
    );
  }
}
