import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pick_up/models/app_user.dart';
import 'package:pick_up/models/pick_up.dart';

class DatabaseService {
  //UID
  final String? uid;
  DatabaseService({this.uid});
  //Collection reference
  final CollectionReference pickUpCollection =
      FirebaseFirestore.instance.collection('Pick Up');

  Future updateUserData(String name, String position, int intensity) async {
    return await pickUpCollection.doc(uid).set({
      'Name': name,
      'Position': position,
      'Intensity': intensity,
    });
  }

  List<PickUp> _pickUpListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PickUp(
          name: doc.get('Name') ?? '',
          position: doc.get('Position') ?? '0',
          intensity: doc.get('Intensity') ?? 0);
    }).toList();
  }

  //User data from snapshot
  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //       uid: uid,
  //       name: snapshot.get('Name') ?? '',
  //       position: snapshot.get('Position') ?? '0',
  //       intensity: snapshot.get('Intensity') ?? 0);
  // }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data().toString().contains('Name')
          ? snapshot.get('Name')
          : '',
      position: snapshot.data().toString().contains('Position')
          ? snapshot.get('Position')
          : 'LB',
      intensity: snapshot.data().toString().contains('Intensity')
          ? snapshot.get('Intensity')
          : 100,
    );
  }

  // Get pick_up Stream
  Stream<List<PickUp>> get pickUp {
    return pickUpCollection.snapshots().map(_pickUpListFromSnapshot);
  }

  //Get usr doc stream
  Stream<UserData> get userData {
    return pickUpCollection.doc((uid)).snapshots().map(_userDataFromSnapshot);
  }

  // Stream<PickUp>? get pickUp {
  //   return pickUpCollection.snapshots();
  // }

  // List<PickUp> _pickUpListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return PickUp(
  //         name: doc.data['Name'] ?? '',
  //         position: doc.data['Position'] ?? '',
  //         intensity: doc.data['Intensity'] ?? 0);
  //   }).toList();
  // }

}
