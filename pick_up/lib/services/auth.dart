import 'package:firebase_auth/firebase_auth.dart';
import 'package:pick_up/models/app_user.dart';

class AuthService {
  //Firebase Auth Instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object based on FB user
  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  //On Auth Change
  Stream<AppUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  //Signin Anon
  Future signInAnon() async {
    try {
      UserCredential userInfo = await _auth.signInAnonymously();
      User? user = userInfo.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sigin Email && Pass
  Future signIn(String email, String password) async {
    try {
      UserCredential userInfo = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userInfo.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print({'Err @ SignIn': e.toString()});
      return null;
    }
  }

  //Register Email && Pass
  Future signUp(String email, String password) async {
    try {
      UserCredential userInfo = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userInfo.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print({'Err @ SignUp': e.toString()});
      return null;
    }
  }

  //Signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
