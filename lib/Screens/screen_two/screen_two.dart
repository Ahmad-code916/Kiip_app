import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/screen_two/screen_two_controller.dart';
import 'package:get/get.dart';
import 'dart:io';

class ScreenTwo extends StatelessWidget {
  ScreenTwo({super.key});

  final ScreenTwoController controller = Get.put(ScreenTwoController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          Container(
                            margin: const EdgeInsets.only(top: 92),
                            child: const Text(
                              'Hello,Welcome Back',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Poppins3',
                                  color: Color(0xff000000)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 128),
                            child: const Text(
                              'Hope to see you again, to use your\naccount please login first',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontFamily: 'Poppins1',
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 14, left: 242),
                            child: Image.asset('assets/images/image2.png'),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 209, left: 15),
                            child: const Text(
                              'Email address',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 15,
                                fontFamily: 'Poppins1',
                              ),
                            ),
                          ),
                        ]),
                        TextFormField(
                          controller: controller.emailController,
                          style: const TextStyle(fontFamily: 'Poppins1'),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color(0xff6B6B6B),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color(0xff6B6B6B),
                                ),
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 26, left: 15),
                          child: const Text(
                            'Password',
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 15,
                              fontFamily: 'Poppins1',
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: controller.passwordController,
                          style: const TextStyle(
                            fontFamily: 'Poppins1',
                          ),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color(0xff6B6B6B),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color(0xff6B6B6B),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              controller.newScreen();
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xff993F3F),
                                fontFamily: 'Poppins1',
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.logIn(controller.emailController.text,
                                controller.passwordController.text.toString());
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xff771F98),
                            ),
                            child: const Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Poppins2',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/line1.png'),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 11, right: 11),
                                  child: const Text(
                                    'Or Login with',
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 15,
                                      fontFamily: 'Poppins1',
                                    ),
                                  ),
                                ),
                                Image.asset('assets/images/line2.png'),
                              ]),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/google_logo.png'),
                              if (Platform.isIOS)
                                const SizedBox(
                                  width: 37.76,
                                ),
                              if (Platform.isIOS)
                                Image.asset('assets/images/apple_logo.png'),
                              const SizedBox(
                                width: 39.76,
                              ),
                              Image.asset('assets/images/fb_logo.png'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            GestureDetector(
                                onTap: controller.signupScreen,
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Color(0xff993F3F),
                                    fontSize: 18,
                                  ),
                                )),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
