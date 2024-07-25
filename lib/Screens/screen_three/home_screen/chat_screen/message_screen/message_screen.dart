import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/screen_three/home_screen/chat_screen/message_screen/message_screen_controller.dart';
import 'package:flutter_app/controllers/admin_base_controller.dart';
import 'package:flutter_app/models/message_model.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key, required this.userModel});

  final FirebaseAuth auth = FirebaseAuth.instance;

  final UserModel userModel;

  final fireStore =
      FirebaseFirestore.instance.collection('myCollection').snapshots();
  final fireStore2 = FirebaseFirestore.instance.collection('chats').snapshots();

  @override
  Widget build(BuildContext context) {
    Get.put(MessageScreenController(userModel));

    // final ChatBotScreenController controller2 =
    //     Get.put(ChatBotScreenController());

    return Scaffold(
      body: GetBuilder<MessageScreenController>(builder: (controller) {
        return Column(
          children: [
            Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 150,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.changeIndex();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 34),
                      child: CircleAvatar(
                        radius: 25,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: CachedNetworkImage(
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: userModel.profilePic ?? "",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userModel.name ?? "",
                          style: const TextStyle(
                              color: Color(0xff181818),
                              fontSize: 16,
                              fontFamily: 'Poppins3'),
                        ),
                        Text(
                          userModel.status ?? "",
                          style: const TextStyle(
                            color: Color(0xff771F98),
                            fontFamily: 'Poppins1',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Image.asset('assets/images/video_call_icon.png'),
                    const SizedBox(
                      width: 23,
                    ),
                    Image.asset('assets/images/audio_call_icon.png'),
                    const SizedBox(
                      width: 23,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.messagesList.length,
                reverse: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ChatBubble(
                    model: controller.messagesList[index],
                    isSender: controller.messagesList[index].senderId ==
                        UserBaseController.userData.value.uid,
                    onPlayAudio: () {
                      if (controller.messagesList[index].medialModel != null &&
                          controller.messagesList[index].medialModel!.type ==
                              1) {
                        controller.playAudio(
                            controller.messagesList[index].medialModel!.url);
                      }
                    },
                  );
                },
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: controller.messagesList.length,
            //       reverse: true,
            //       scrollDirection: Axis.vertical,
            //       itemBuilder: (context, index) {
            //         return ChatBubble(
            //           model: controller.messagesList[index],
            //           isSender: controller.messagesList[index].senderId ==
            //               UserBaseController.userData.value.uid,
            //         );
            //       }),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(right: 3),
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff000000),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 23),
                          width: double.infinity,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: controller.textController,
                            style: const TextStyle(
                              fontFamily: 'Poppins1',
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type here..',
                              hintStyle: TextStyle(
                                color: Color(0xff8D8D8D),
                                fontSize: 17,
                                fontFamily: 'Poppins1',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            controller.getImage();
                          },
                          child: Image.asset('assets/images/camera.png')),
                      const SizedBox(
                        width: 20,
                      ),
                      Image.asset('assets/images/square_icon.png'),
                      const SizedBox(
                        width: 20,
                      ),
                      controller.textController.text.isEmpty
                          ? GestureDetector(
                              onLongPressStart: (details) async {
                                await controller.startRecording();
                                },
                          onLongPressEnd: (details) async {
                            await controller.stopRecording();
                          },
                              child:
                                  Image.asset('assets/images/voice_icon.png'))
                          : IconButton(
                              onPressed: () {
                                if (controller.textController.text
                                    .trim()
                                    .isNotEmpty) {}
                                controller.textController.clear();
                              },
                              icon: IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  controller.sendMessage(null);
                                },
                              ),
                            ),
                      // IconButton(
                      //   onPressed: () async {
                      //     await controller.stopRecording();
                      //   },
                      //   icon: Icon(Icons.stop),
                      // ),
                      const SizedBox(
                        width: 20,
                      ),
                    ]),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isSender;
  final MessageModel model;
  final VoidCallback onPlayAudio;

  const ChatBubble(
      {super.key,
      required this.isSender,
      required this.model,
      required this.onPlayAudio});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: isSender ? 80 : 10,
                right: isSender ? 10 : 80,
                bottom: 10,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff771F98)),
                borderRadius: const BorderRadius.all(Radius.circular(11)),
                color: isSender ? const Color(0xff771F98) : Colors.white,
              ),
              child: model.medialModel != null
                  ? model.medialModel!.type == 0
                      ? ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: model.medialModel!.url ?? "",
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        )
                      : GestureDetector(
                          onTap: onPlayAudio,
                          child: Column(
                            children: [
                              // const Icon(Icons.audiotrack),
                              Text(
                                'Play Audio',
                                style: TextStyle(
                                    fontFamily: 'Poppins1',
                                    fontSize: 14,
                                    color:
                                        isSender ? Colors.white : Colors.black),
                              ),
                            ],
                          ),
                        )
                  : Text(
                      model.message ?? "",
                      style: TextStyle(
                          fontFamily: 'Poppins1',
                          fontSize: 14,
                          color: isSender ? Colors.white : Colors.black),
                    ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: isSender ? 0 : 15, right: isSender ? 15 : 0),
              child: Text(DateFormat("hh:mm").format(model.messageTime!)),
            ),
          ]),
    );
  }
}

// class ChatBubble extends StatelessWidget {
//   final bool isSender;
//   final MessageModel model;
//
//   const ChatBubble({super.key, required this.isSender, required this.model});
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
//       child: Column(
//           crossAxisAlignment:
//               isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: EdgeInsets.only(
//                 left: isSender ? 80 : 10,
//                 right: isSender ? 10 : 80,
//                 bottom: 10,
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: const Color(0xff771F98),
//                 ),
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(13),
//                 ),
//                 color: isSender ? const Color(0xff771F98) : Colors.white,
//               ),
//               child: Text(
//                 model.message ?? "",
//                 style: TextStyle(
//                     fontFamily: 'Poppins1',
//                     fontSize: 14,
//                     color: isSender ? Colors.white : Colors.black),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(
//                   left: isSender ? 0 : 15, right: isSender ? 15 : 0),
//               child: Text(DateFormat("hh:mm").format(model.messageTime!)),
//             )
//           ]),
//     );
//   }
// }
