import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/signup_screen/signup_screen_controller.dart';
import 'package:flutter_app/utilities/utils.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupScreenController controller = Get.put(SignupScreenController());

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<SignupScreenController>(builder: (controller) {
      return SafeArea(
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 31, left: 27),
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.arrow_circle_left_outlined,
                            size: 30,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      Stack(children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, left: 22),
                          child: const Text(
                            'Hello,Welcome Back',
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Poppins3',
                                color: Color(0xff000000)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 40, left: 22),
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
                          margin: const EdgeInsets.only(top: 95, left: 120),
                          child: CircleAvatar(
                            radius: 50,
                            child: controller.image != null
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    child: Image.file(
                                      height: double.infinity,
                                      width: double.infinity,
                                      controller.image!.absolute,
                                      fit: BoxFit.cover,
                                    ))
                                : IconButton(
                                    icon: const Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                    onPressed: () {
                                      controller.showDialogueBox();
                                    },
                                  ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 14, left: 242),
                          child: Image.asset('assets/images/image2.png'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 209, left: 42),
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
                      Container(
                        margin: const EdgeInsets.only(left: 22, right: 21),
                        child: TextFormField(
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
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 26, left: 42),
                        child: const Text(
                          'Name',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 15,
                            fontFamily: 'Poppins1',
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 7, left: 22, right: 21),
                        child: TextFormField(
                          controller: controller.nameController,
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
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 26, left: 42),
                        child: const Text(
                          'Password',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 15,
                            fontFamily: 'Poppins1',
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 7, left: 22, right: 21),
                        child: TextFormField(
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
                      ),
                      GestureDetector(
                        onTap: () {
                          if (controller.emailController.text.isNotEmpty &&
                              controller.passwordController.text.isNotEmpty &&
                              controller.nameController.text.isNotEmpty &&
                              controller.image != null) {
                            controller.signIn(
                                emailController: controller.emailController.text
                                    .toString()
                                    .trim(),
                                passwordController: controller
                                    .passwordController.text
                                    .toString()
                                    .trim(),
                                nameController: controller.nameController.text
                                    .toString()
                                    .trim());
                          } else {
                            Utils().toastMessage(
                                ' Select Image or Enter the fields');
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 40, left: 30, right: 26),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff771F98),
                          ),
                          child: const Center(
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Poppins2',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Have an account.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          GestureDetector(
                              onTap: controller.loginScreen,
                              child: const Text(
                                'Log in',
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
      );
    }));
  }
}
