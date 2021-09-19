import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth with ChangeNotifier {
  String? uid;
  String? token;
  Future<void> signUp(String email, String password) async {
    var user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    uid = user.user!.uid;
    token = await user.user!.getIdToken();
  }

  Future<void> logIn(String email, String password) async {
    var user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    uid = user.user!.uid;
    token = await user.user!.getIdToken();

    print(uid);
    print(token);
  }
}
