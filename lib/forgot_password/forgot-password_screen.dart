import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/forgot_password/forgot_password_screen_controller.dart';
import 'package:flutter_app/utilities/utils.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordScreenController controller =
        Get.put(ForgotPasswordScreenController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.purple,
            ),
            child: Center(
              child: TextButton(
                onPressed: () {
                  auth
                      .sendPasswordResetEmail(
                          email: controller.emailController.text.toString())
                      .then((value) {
                    Utils().toastMessage('We have send an email');
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                },
                child: const Text(
                  'Forgot',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
