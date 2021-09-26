import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop2/model/http_exception.dart';

class Auth with ChangeNotifier {
  String? uid;
  String? token;
  Future<void> signUp(String email, String password) async {
    try {
      var sPref = await SharedPreferences.getInstance();
      var user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      uid = user.user!.uid;
      token = await user.user!.getIdToken();
      sPref.setString('uid', uid!);
      sPref.setString('token', token!);
      notifyListeners();
    } catch (error) {
      String msg = 'Authentication failed';
      print(error.toString());
      if (error.toString().contains('email-already-in-use')) {
        msg = 'this email is already exist';
      }
      throw HttpException(msg);
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      var sPref = await SharedPreferences.getInstance();

      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      uid = user.user!.uid;
      token = await user.user!.getIdToken();

      sPref.setString('uid', uid!);
      sPref.setString('token', token!);
      notifyListeners();
    } catch (error) {
      String msg = 'Authentication failed';
      print(error.toString());
      if (error.toString().contains('wrong-password')) {
        msg = 'Wrong Password, Please make sure from your password';
      } else if (error.toString().contains('user-not-found')) {
        msg = 'email not found, Please make sure from your email';
      } else if (error.toString().contains('too-many-requests')) {
        msg = 'Too Many Requests';
      }
      throw HttpException(msg);
    }
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
