import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dml/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on Firebase
  TheUser _userFromFirebaseUser(User user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<TheUser> get user{
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  // sign in Anonymous
  Future signAnon() async {
    try{
      // this UserCredential called AuthResult in 2019
      UserCredential userCredential = await _auth.signInAnonymously();
      // this User called FirebaseUser in 2019
      User user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

//sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return _userFromFirebaseUser(user);
    }catch(e) {
      print(e.toString());
      return null;
    }
  }

//register with email & password
  Future createUserWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return _userFromFirebaseUser(user);
    }catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
      try{
        return await _auth.signOut();
      }catch(e){
        print(e.toString());
        return null;
      }
  }
}
