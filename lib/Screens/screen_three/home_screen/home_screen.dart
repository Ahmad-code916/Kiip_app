import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/screen_three/home_screen/calls_screen/calls_screen.dart';
import 'package:flutter_app/Screens/screen_three/home_screen/chat_screen/chat_screen.dart';
import 'package:flutter_app/Screens/screen_three/home_screen/friends_screen/friends_screen.dart';
import 'package:flutter_app/Screens/screen_three/home_screen/home_screen_controller.dart';
import 'package:flutter_app/utilities/utils.dart';
import 'package:get/get.dart';


class HomeScreen extends StatelessWidget {
  final HomeScreenController controller = Get.put(HomeScreenController());

  HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: GetBuilder<HomeScreenController>(builder: (controller) {
        return Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 36),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xffF1F1F1),
                    ),
                    margin: const EdgeInsets.only(top: 36, left: 22),
                    height: 50,
                    width: 270,
                    child: TextFormField(
                      onChanged: controller.onChanged,
                      controller: controller.searchController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              const BorderSide(color: Color(0xffF1F1F1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              const BorderSide(color: Color(0xffF1F1F1)),
                        ),
                        hintText: 'Search Chat',
                        hintStyle: const TextStyle(
                          color: Color(0xff252525),
                          fontFamily: 'Poppins1',
                          fontSize: 20,
                        ),
                        prefixIcon: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Color(0xff252525),
                          ),
                          onPressed: () {
                            controller.onSearch();
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(top: 36, right: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF1F1F1),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        auth.signOut().then((value) {
                          controller.changeScreen();
                        }).onError((error, stackTrace) {
                          Utils().toastMessage(error.toString());
                        });
                      },
                      child: Icon(Icons.logout),
                      // Image.asset('assets/images/scan.png'),
                    ),
                  ),
                ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 36),
            child: TabBar(
              indicatorColor: const Color(0xffF1F1F1),
              controller: controller.tabController,
              tabs: controller.tabList,
            ),
          ),
          Expanded(
            child: TabBarView(controller: controller.tabController, children: [
              ChatScreen(),
              const FriendsScreen(),
              const CallsScreen(),
            ]),
          ),
        ]);
      }),
    );
  }
}
