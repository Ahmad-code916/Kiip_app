import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImagePickerScreenController extends GetxController {
  File? image;

  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    } else {
      print('No Image Selected');
    }
  }

  void storeFile() async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/Newfolder/' + DateTime.now().microsecondsSinceEpoch.toString());
    firebase_storage.UploadTask uploadTask = ref.putFile(image!.absolute);

    Future.value(uploadTask).then((value) async {
      var newUrl = await ref.getDownloadURL();

      FirebaseFirestore.instance.collection('collectionPath').doc().set({'image':newUrl}).then((value) {
        Utils().toastMessage('Uploaded');
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
      });
    });
  }
}
