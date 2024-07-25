import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/admin_base_controller.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/utilities/app_functions.dart';
import 'package:flutter_app/utilities/utils.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../models/message_model.dart';

class MessageScreenController extends GetxController
    with WidgetsBindingObserver {
  UserModel userModel = UserModel();

  MessageScreenController(this.userModel);

  final textController = TextEditingController();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  // FlutterSound flutterSound = FlutterSound();
  FlutterSoundPlayer _audioplayer = FlutterSoundPlayer();

  List<MessageModel> messagesList = [];
  bool isLoading = false;
  int lastCount = 20;
  DocumentSnapshot? lastDocument;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? messagesSnapShot;

  String get threadId {
    String s1 = userModel.uid ?? "";
    String s2 = UserBaseController.userData.value.uid ?? "";
    return s1.compareTo(s2) >= 0 ? "${s1}__$s2" : "${s2}__$s1";
  }

  void attachMessagesListener() {
    messagesSnapShot = FirebaseFirestore.instance
        .collection("threads")
        .doc(threadId)
        .collection("chat")
        .orderBy("messageTime", descending: true)
        .limit(1)
        .snapshots()
        .listen((event) {
      messagesList ??= messagesList ?? RxList();
      update();
      if (event.docs.isEmpty) return;
      var chat = MessageModel.fromMap(event.docs[0].data());
      if (messagesList.firstWhereOrNull((element) => element.id == chat.id) !=
          null) return;
      messagesList.insert(0, chat);
      update();
    });
  }

  Future<void> loadChat() async {
    if (lastCount < 20) {
      return;
    }
    isLoading = true;
    Query<Map<String, dynamic>> snapShotQuery;
    final ref = FirebaseFirestore.instance
        .collection("threads")
        .doc(threadId)
        .collection("chat")
        .orderBy("messageTime", descending: true)
        .limit(20);
    // snapShotQuery = ref;
    snapShotQuery = (ref);
    if (lastDocument != null) {
      snapShotQuery = snapShotQuery.startAfterDocument(lastDocument!);
    }
    var snapShot = await snapShotQuery.get();
    var messagesLIst = snapShot.docs.map((e) {
      lastDocument = e;
      return MessageModel.fromMap(e.data());
    }).toList();
    lastCount = messagesLIst.length;
    messagesList.addAll(messagesLIst);
    isLoading = false;
    update();
  }

  void sendMessage(MediaModel? mediaModel) {
    final id = generateRandomString(15);
    MessageModel messageModel = MessageModel(
      medialModel: mediaModel,
      id: id,
      message: textController.text.isNotEmpty ? textController.text : null,
      messageTime: DateTime.now(),
      senderId: UserBaseController.userData.value.uid,
      threadId: threadId,
      messageType: mediaModel != null ? 1 : 0,
      // Assume 1 for media message, 0 for text
      participantUserList: [
        userModel.uid,
        UserBaseController.userData.value.uid
      ],
    );

    FirebaseFirestore.instance
        .collection('threads')
        .doc(threadId)
        .collection("chat")
        .doc(id)
        .set(messageModel.toMap());
    textController.clear();
  }

  Future<void> getImage() async {
    final id = generateRandomString(15);
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref("chat_images/$fileName");

      final firebase_storage.UploadTask uploadTask =
          storageReference.putFile(imageFile);
      final firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      final mediaModel = MediaModel(
        id: id,
        type: 0,
        url: downloadUrl,
        thumbnail: null,
        // Add thumbnail generation if needed
        createdAt: DateTime.now(),
        name: fileName,
      );

      sendMessage(mediaModel); // Pass the mediaModel when there's an image
    } else {
      Utils().toastMessage('No image selected');
    }
  }

  Future startRecording() async {
   try{
     await Permission.microphone.request();
     if (await Permission.microphone.isGranted) {
       final Directory tempDir = await getTemporaryDirectory();
       final String path =
           '${tempDir.path}/audio_${DateTime.now().microsecondsSinceEpoch}.aac';
       await _audioRecorder.startRecorder(toFile: path);
     } else {
       Utils().toastMessage('Permission not granted');
     }
   }catch(e){
     Utils().toastMessage(e.toString());
   }
  }

  Future stopRecording() async {
    try{
      final String? path = await _audioRecorder.stopRecorder();
      if (path != null) {
        final File audioFile = File(path);
        final String fileName = DateTime.now().microsecondsSinceEpoch.toString();
        final firebase_storage.Reference reference =
        firebase_storage.FirebaseStorage.instance.ref("chat_audio/$fileName");
        final firebase_storage.UploadTask uploadTask =
        reference.putFile(audioFile);
        final firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        final mediaModel = MediaModel(
          type: 1,
          id: taskSnapshot.ref.name,
          url: downloadUrl,
          createdAt: DateTime.now(),
          name: fileName,
          thumbnail: null,
        );
        sendMessage(mediaModel);
      }
    }catch(e){
      Utils().toastMessage(e.toString());
    }
  }
  Future playAudio (String url) async {
   await  _audioplayer.startPlayer(fromURI: url);

  }

  @override
  void onInit() async {
    await loadChat();
    attachMessagesListener();
    _audioRecorder.openRecorder();
    _audioplayer.openPlayer();
    textController.addListener(() {
      update();
    });
    super.onInit();
  }

  @override
  void onClose() async {
    await messagesSnapShot?.cancel();
    _audioRecorder.closeRecorder();
    _audioplayer.closePlayer();
    super.onClose();
  }


  void changeIndex() {
    Get.back();
  }
}
