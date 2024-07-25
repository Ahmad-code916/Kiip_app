import 'package:flutter/material.dart';
import 'package:flutter_app/image_picker/image_picker_screen_controller.dart';
import 'package:get/get.dart';

class ImagePickerScreen extends StatelessWidget {
  const ImagePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ImagePickerScreenController());
    return Scaffold(
      body: GetBuilder<ImagePickerScreenController>(builder: (controller) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                margin: const EdgeInsets.only(),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: controller.image != null
                    ? Image.file(controller.image!.absolute)
                    : IconButton(
                        onPressed: () {
                          controller.getGalleryImage();
                        },
                        icon: const Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 50,
                        ),
                      ),
              ),
              Container(
                height: 40,
                margin: const EdgeInsets.only(top: 50, left: 80, right: 80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple,
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      controller.storeFile();
                    },
                    child: const Text(
                      'Upload Image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
