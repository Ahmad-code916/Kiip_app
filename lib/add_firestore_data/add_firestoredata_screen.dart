import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/add_firestore_data/add_firestoredata_screen_controller.dart';
import 'package:flutter_app/utilities/utils.dart';
import 'package:get/get.dart';

class AddFireStoreData extends StatelessWidget {
  AddFireStoreData({super.key});

  final fireStore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final AddFireStoreDataScreenController controller = Get.put(
        AddFireStoreDataScreenController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('FireStoreData'),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 150,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: TextFormField(
            controller: controller.postController,
            decoration: const InputDecoration(
              hintText: 'What is in your mind',
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.purple,
          ),
          child: Center(
            child: TextButton(
              onPressed: () {
                String id = DateTime.now().microsecondsSinceEpoch.toString();
                fireStore.doc(id).set({
                  'title' : controller.postController.text,
                  'id' : id,
                }).then((value) {
                  Utils().toastMessage('Post added');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
