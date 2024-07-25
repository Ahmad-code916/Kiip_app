import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/user_model.dart';

class AuthService {
  static Future<UserModel?>getUserDetail() async {
    UserModel? userModel;
    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
        .get();
    if(snap.exists){
      userModel = UserModel.fromMap(snap.data()!);
    }
    return userModel;
  }
}
