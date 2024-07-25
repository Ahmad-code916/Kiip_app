import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/Screens/screen_three/home_screen/home_screen.dart';
import 'package:flutter_app/Screens/screen_two/screen_two.dart';
import 'package:flutter_app/controllers/admin_base_controller.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:get/get.dart';

class ScreenOneController extends GetxController {
  void getStarted() async {
    // if (FirebaseAuth.instance.currentUser != null) {
    //   final model = await AuthService.getUserDetail();
    //   UserBaseController.updateUser(model!);
    //   Get.offAll(HomeScreen());
    //   return;
    // }
    return
        Get.offAll(() => ScreenTwo());
  }
}
