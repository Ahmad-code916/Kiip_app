import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/screen_three/home_screen/chat_screen/chat_screen_controller.dart';
import 'package:flutter_app/Screens/screen_three/home_screen/home_screen_controller.dart';
import 'package:flutter_app/controllers/admin_base_controller.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final fireStore = FirebaseFirestore.instance
      .collection('users')
      .where("uid", isNotEqualTo: UserBaseController.userData.value.uid ?? "")
      .snapshots();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Get.put(ChatScreenController());
    HomeScreenController controller2 = Get.put(HomeScreenController());
    return Scaffold(
      body: GetBuilder<ChatScreenController>(builder: (controller) {
        return StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data != null) {
                List<UserModel> users = [];
                users = snapshot.data!.docs
                    .map((e) =>
                        UserModel.fromMap(e.data() as Map<String, dynamic>))
                    .toList();
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return (users[index].name ?? "").toLowerCase().contains(
                              controller2.searchController.text.toLowerCase())
                          ? GestureDetector(
                              onTap: () {
                                controller.changeScreen(users[index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 22, right: 21, bottom: 32),
                                padding: const EdgeInsets.all(9),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: const Color(0xff771F98))),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.purple,
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          child: CachedNetworkImage(
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            imageUrl: snapshot
                                                .data!.docs[index]['profilePic']
                                                .toString(),
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 13,
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]['name']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Color(0xff181818),
                                                fontSize: 16,
                                                fontFamily: 'Poppins3'),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]['email']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Color(0xff5C5C5C),
                                                fontSize: 13,
                                                fontFamily: 'Poppins1'),
                                          ),
                                        ]),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox();
                    });
              } else {
                return Container(
                  child: const Center(
                    child: Text('No user added yet!'),
                  ),
                );
              }
            });
      }),
    );
  }
}

// ListView.builder(
//     itemCount: controller.chatList.length,
//     itemBuilder: (context, index) {
//       return GestureDetector(
//           onTap: (){
//             controller.changeScreen(controller.chatList[index]);
//           },
//           child: ThreadWidget(threadModel: controller.chatList[index]));
//     }),
// class ThreadWidget extends StatelessWidget {
//   final ChatModel threadModel;
//
//   const ThreadWidget({super.key, required this.threadModel});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 22, right: 21, bottom: 32),
//       padding: const EdgeInsets.all(9),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: const Color(0xff771F98))),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundImage: NetworkImage(threadModel.imageUrl),
//           ),
//           const SizedBox(
//             width: 13,
//           ),
//           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(
//               threadModel.name,
//               style: const TextStyle(
//                   color: Color(0xff181818),
//                   fontSize: 16,
//                   fontFamily: 'Poppins3'),
//             ),
//             Row(children: [
//               Image.asset('assets/images/tick_icon.png'),
//               Text(
//                 threadModel.title,
//                 style: const TextStyle(
//                     color: Color(0xff5C5C5C),
//                     fontSize: 13,
//                     fontFamily: 'Poppins1'),
//               ),
//             ]),
//           ]),
//           const Spacer(),
//           Column(children: [
//             Text(
//               threadModel.time,
//               style: const TextStyle(
//                   color: Color(0xff5C5C5C),
//                   fontSize: 11,
//                   fontFamily: 'Poppins1'),
//             ),
//             const SizedBox(
//               height: 7,
//             ),
//             const CircleAvatar(
//               radius: 12,
//               backgroundColor: Color(0xff771F98),
//               child: Center(
//                 child: Text(
//                   '2',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             )
//           ]),
//         ],
//       ),
//     );
//   }
// }
