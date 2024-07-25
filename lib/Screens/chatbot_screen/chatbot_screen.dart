// import 'package:flutter/material.dart';
// import 'package:flutter_app/Screens/chatbot_screen/chatbot_screen_controller.dart';
// import 'package:flutter_app/models/chatbot_model.dart';
// import 'package:get/get.dart';
//
// class ChatBotScreen extends StatelessWidget {
//   final ChatBotScreenController controller = Get.put(ChatBotScreenController());
//
//   ChatBotScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => ListView.builder(
//           reverse: true,
//           itemCount: controller.messages.length,
//           itemBuilder: (context, index) {
//             MessageModel message = controller.messages[index];
//             return _buildMessage(message);
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMessage(MessageModel message) {
//     return Column(children: [
//       Container(
//         margin: const EdgeInsets.only(
//           left: 21,
//           right: 20,
//         ),
//         alignment:
//             message.isSender ? Alignment.centerRight : Alignment.centerLeft,
//         child: Container(
//           padding:
//               const EdgeInsets.only(left: 11, right: 20, top: 17, bottom: 17),
//           decoration: BoxDecoration(
//             color: message.isSender
//                 ? const Color(0xff771F98)
//                 : const Color(0xffFFFFFF),
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//                 color: message.isSender
//                     ? const Color(0xff771F98)
//                     : const Color(0xff771F98)),
//           ),
//           child: Text(
//             message.text,
//             style: TextStyle(
//               color: message.isSender
//                   ? const Color(0xffFFFFFF)
//                   : const Color(0xff171717),
//               fontSize: 14,
//               fontFamily: 'Poppins1',
//             ),
//           ),
//         ),
//       ),
//       Align(
//         alignment:
//             message.isSender ? Alignment.centerRight : Alignment.centerLeft,
//         child: Container(
//           height: 20,
//           width: 60,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: const Color(0xffF1F1F1),
//           ),
//           margin:
//               const EdgeInsets.only(left: 21,right: 22, bottom: 31, top: 9),
//           alignment:
//               message.isSender ? Alignment.centerRight : Alignment.centerLeft,
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//                 Text(message.time),
//                 Image.asset('assets/images/icon_msg_seen.png'),
//           ]),
//         ),
//       ),
//     ]);
//   }
// }
