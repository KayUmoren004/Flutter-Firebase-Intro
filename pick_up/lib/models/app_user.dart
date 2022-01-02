// ignore_for_file: empty_constructor_bodies

class AppUser {
  final String? uid;

  AppUser({this.uid});
}

class UserData {
  final String? uid;
  final String? name;
  final String? position;
  final int? intensity;

  UserData({this.uid, this.name, this.position, this.intensity});
}
