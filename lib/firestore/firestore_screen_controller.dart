import 'package:flutter_app/add_firestore_data/add_firestoredata_screen.dart';
import 'package:flutter_app/image_picker/image_picker_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FireStoreScreenController extends GetxController {

  void changeScreen () {

    Get.to(() => AddFireStoreData());

  }
  void getScreen () {

    Get.to(() => const ImagePickerScreen());

  }

}