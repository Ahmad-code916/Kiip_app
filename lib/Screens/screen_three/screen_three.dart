import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/screen_three/home_screen/home_screen.dart';
import 'package:flutter_app/Screens/screen_three/person_screen/person_screen.dart';
import 'package:flutter_app/Screens/screen_three/screen_three_controller.dart';
import 'package:flutter_app/Screens/screen_three/setting_screen/setting_screen.dart';
import 'package:get/get.dart';

class ScreenThree extends StatelessWidget {
  ScreenThree({super.key});


  final ScreenThreeController controller = Get.put(ScreenThreeController());

  final screens = [
    HomeScreen(),
    const PersonScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: screens,
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          onTap: (index) {
            controller.changeIndex(index);
          },
          currentIndex: controller.selectedIndex.value,
          items: [
            BottomNavigationBarItem(
              icon: GestureDetector(
                child: Image.asset(
                  'assets/images/home_icon.png',
                  color: (controller.selectedIndex.value == 0)
                      ? const Color(0xff771F98)
                      : const Color(0xff696969),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                child: Image.asset(
                  'assets/images/user_icon.png',
                  color: (controller.selectedIndex.value == 1)
                      ? const Color(0xff771F98)
                      : const Color(0xff696969),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                child: Image.asset(
                  'assets/images/setting_icon.png',
                  color: (controller.selectedIndex.value == 2)
                      ? const Color(0xff771F98)
                      : const Color(0xff696969),
                ),
              ),
              label: '',
            ),
          ],
        );
      }),
    );
  }
}
