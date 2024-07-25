import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/firestore/firestore_screen_controller.dart';
import 'package:flutter_app/utilities/utils.dart';
import 'package:get/get.dart';

class FireStoreScreen extends StatelessWidget {
  FireStoreScreen({super.key});

  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final FireStoreScreenController controller =
        Get.put(FireStoreScreenController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('FireStore'),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 20, right: 20),
            child: IconButton(
              onPressed: () {
                controller.getScreen();
              },
              icon: const Icon(
                Icons.arrow_circle_right_outlined,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.changeScreen();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return const Text('Some error');
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            ref
                                .doc(
                                    snapshot.data!.docs[index]['id'].toString())
                                .update({
                              'title': 'I am a Boy',
                            }).then((value) {
                              Utils().toastMessage('updated');
                            }).onError((error, stackTrace) {
                              Utils().toastMessage(error.toString());
                            });
                            // ref.doc(snapshot.data!.docs[index]['id']).delete();
                          },
                          title: Text(
                              snapshot.data!.docs[index]['title'].toString()),
                          subtitle:
                              Text(snapshot.data!.docs[index].id.toString()),
                        );
                      }),
                );
              }),
        ],
      ),
    );
  }
}
