import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Screens/screen_three/home_screen/chat_screen/message_screen/message_screen.dart';
import 'package:flutter_app/Screens/screen_three/home_screen/home_screen_controller.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:get/get.dart';


class ChatScreenController extends GetxController with WidgetsBindingObserver {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  HomeScreenController controller2 = Get.put(HomeScreenController());

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  void setStatus(String status) async {
    await fireStore.collection('users').doc(auth.currentUser!.uid).update({
      'status': status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus('Online');
    } else {
      setStatus('Offline');
    }
    super.didChangeAppLifecycleState(state);
  }

  void changeScreen(UserModel user) {
    Get.to(() => MessageScreen(userModel: user));
  }
}
