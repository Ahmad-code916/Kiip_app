import 'package:flutter/material.dart';
import 'package:flutter_app/screen_one/screen_one_controller.dart';
import 'package:get/get.dart';

class ScreenOne extends StatelessWidget {
  ScreenOne({super.key});

  final ScreenOneController controller = Get.put(ScreenOneController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 45),
                  child: const Text(
                    'Get Closer To\nEveryone',
                    style: TextStyle(
                      fontSize: 36,
                      fontFamily: 'Poppins3',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 9),
                  child: const Text(
                    'Helps you to contact everyone with\njust easy way',
                    style: TextStyle(
                      fontFamily: 'Poppins1',
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 52),
                  child: Image.asset('assets/images/image1.png'),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 50, right: 45),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff771F98)),
            ),
            onPressed: () {
              controller.getStarted();
            },
            child: const Text(
              'Get Started',
              style: TextStyle(
                color: Color(0xffF3F3F3),
                fontSize: 20,
                fontFamily: 'Poppins2',
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 56,
        ),
      ]),
    );
  }
}
