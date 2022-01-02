import 'package:flutter/material.dart';
import 'package:pick_up/models/pick_up.dart';
import 'package:pick_up/screens/home/pick_up_tile.dart';
import 'package:provider/provider.dart';

class PickUpList extends StatefulWidget {
  const PickUpList({Key? key}) : super(key: key);

  @override
  _PickUpListState createState() => _PickUpListState();
}

class _PickUpListState extends State<PickUpList> {
  @override
  Widget build(BuildContext context) {
    //Access data
    final pickUp = Provider.of<List<PickUp>?>(context) ??
        []; //(add double "??", do this on home.dart too)

    return ListView.builder(
        itemCount: pickUp.length,
        itemBuilder: (context, index) {
          return PickUpTile(players: pickUp[index]);
        });
  }
}
