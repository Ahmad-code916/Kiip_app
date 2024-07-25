import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/admin_base_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text(UserBaseController.userData.value.status??""),
        )
    );
  }
}