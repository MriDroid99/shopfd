import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? uid;
  String? token;
  Future<void> signUp(String email, String password) async {
    var sPref = await SharedPreferences.getInstance();
    var user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    uid = user.user!.uid;
    token = await user.user!.getIdToken();
    sPref.setString('uid', uid!);
    sPref.setString('token', token!);
  }

  Future<void> logIn(String email, String password) async {
    var sPref = await SharedPreferences.getInstance();

    var user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    uid = user.user!.uid;
    token = await user.user!.getIdToken();

    sPref.setString('uid', uid!);
    sPref.setString('token', token!);
  }

  Future<void> logout() async {
    uid = null;
    token = null;
    await FirebaseAuth.instance.signOut();
    var sPref = await SharedPreferences.getInstance();

    // await sPref.remove('uid');
    // await sPref.remove('token');
    await sPref.clear();
  }

  Future<void> getDataFromsPref() async {
    var sPref = await SharedPreferences.getInstance();

    uid = sPref.getString('uid');
    token = sPref.getString('token');
  }
}
