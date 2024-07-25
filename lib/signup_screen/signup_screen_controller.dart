import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/Screens/screen_two/screen_two.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../controllers/admin_base_controller.dart';
import '../services/auth_service.dart';

class SignupScreenController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  late final UserModel? userModel;

  Future<User?> signIn(
      {required String emailController,
      required String passwordController,
      required String nameController}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    User? user;

    try {
      user = (await auth.createUserWithEmailAndPassword(
              email: emailController, password: passwordController))
          .user;

      if (user != null) {


        final user = await AuthService.getUserDetail();
        if(user == null){
          String uid = auth.currentUser!.uid;
          UserModel userModel = UserModel(
            name: nameController,
            email: emailController,
            password: passwordController,
            profilePic: imageUrl,
            uid: uid,
            status: "Unavailable",
          );
          await fireStore
              .collection('users')
              .doc(uid)
              .set(userModel.toMap());
          UserBaseController.updateUser(userModel);
        }

        Utils().toastMessage('SignIn Successfully');

        Get.offAll(() => ScreenTwo());
      } else {
        Utils().toastMessage('SignIn Failed');
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
    return null;
  }

  void showDialogueBox() {
    Get.defaultDialog(
        title: 'Upload Profile Picture',
        titlePadding: const EdgeInsets.only(top: 10),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          children: [
            InkWell(
              onTap: () {
                selectImage(ImageSource.camera);
                Get.back();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.camera_alt),
                  Text('Select Image from camera'),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                selectImage(ImageSource.gallery);
                Get.back();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.photo),
                  Text('Select Image from gallery'),
                ],
              ),
            ),
          ],
        ));
  }
    File? image;
    String? imageUrl;
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    void selectImage(ImageSource source) async {
      XFile? pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        image = File(pickedFile.path);
        update();
        String uid = auth.currentUser!.uid;
        firebase_storage.Reference reference =
        firebase_storage.FirebaseStorage.instance.ref('/myFolder/' + uid);
        firebase_storage.UploadTask uploadTask = reference.putFile(image!.absolute);

        Future.value(uploadTask).then((value) async {
          imageUrl = await reference.getDownloadURL();

          userModel!.profilePic = imageUrl;

          fireStore.collection('users').doc(uid).set(userModel!.toMap(),SetOptions(merge: true));
        });

      } else {
        Utils().toastMessage('No Image Selected');
      }
    }

    void getScreen() {
      Get.to(() => ScreenTwo());
    }
    void loginScreen () {
      Get.back();
    }
  }
