import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/screen_two/screen_two.dart';
import 'package:flutter_app/controllers/admin_base_controller.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/utilities/utils.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final searchController = TextEditingController();
  late TabController tabController;

  List<Tab> tabList = const [
    Tab(
      child: Text(
        'Chats',
        style: TextStyle(
          color: Color(0xff252525),
          fontSize: 20,
          fontFamily: 'Poppins1',
        ),
      ),
    ),
    Tab(
      child: Text(
        'Friends',
        style: TextStyle(
          color: Color(0xff252525),
          fontSize: 20,
          fontFamily: 'Poppins1',
        ),
      ),
    ),
    Tab(
      child: Text(
        'Calls',
        style: TextStyle(
          color: Color(0xff252525),
          fontSize: 20,
          fontFamily: 'Poppins1',
        ),
      ),
    ),
  ];

  @override
  void onInit() {
    tabController = TabController(length: tabList.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.dispose();
  }

  void changeScreen() {
    UserBaseController.updateUser(UserModel());
    Get.to(() => ScreenTwo());
  }
  void onSearch(){
    update();
  }
  void onChanged (String? val){
    update();
  }
}
