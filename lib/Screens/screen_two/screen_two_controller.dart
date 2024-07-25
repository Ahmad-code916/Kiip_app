import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/Screens/screen_three/screen_three.dart';
import 'package:flutter_app/controllers/admin_base_controller.dart';
import 'package:flutter_app/firestore/firestore_screen.dart';
import 'package:flutter_app/forgot_password/forgot-password_screen.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/signup_screen/signup_screen.dart';
import 'package:flutter_app/utilities/utils.dart';
import 'package:get/get.dart';

class ScreenTwoController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late final UserModel userModel;
  Future<User?> logIn(String emailController, String passwordController) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      User? user = (await auth.signInWithEmailAndPassword(
              email: emailController, password: passwordController))
          .user;
      if (user != null) {
        final userModel = await AuthService.getUserDetail();
        if(userModel == null){

        }
        UserBaseController.updateUser(userModel!);
        Utils().toastMessage('Login Successfully');
        Get.offAll(() => ScreenThree());
        return user;
      } else {
        Utils().toastMessage('Login Failed');
        return user;
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
      return null;
    }
  }

  void getScreen() {
    Get.to(() => ScreenThree());
  }

  void changeScreen() {
    Get.to(() => FireStoreScreen());
  }

  void newScreen() {
    Get.to(() => ForgotPasswordScreen());
  }
  void signupScreen () {
    Get.to(() => SignupScreen());
  }
}
