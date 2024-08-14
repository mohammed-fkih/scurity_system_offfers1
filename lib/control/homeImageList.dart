import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class HomeImageList extends StatefulWidget {
  const HomeImageList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeImageList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  Future<void> deleteDataFromFirebase(String docId, String imageURL) async {
    await _firestore.collection('homeImage').doc(docId).delete();
    await _storage.refFromURL(imageURL).delete();
  }

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> uploadImage() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = _storage.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(_image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> addDataToFirebase() async {
    String imageUrl = await uploadImage();
    String title = _titleController.text;
    String desc = _descController.text;
    String link = _linkController.text;
    await _firestore.collection('homeImage').add({
      'imageURL2': imageUrl,
      'sliderTitle': title,
      'sliderDesc': desc,
      'link': link
    });

    _titleController.clear();
    _descController.clear();
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة العناصر'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('sliders').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          List<Map<String, dynamic>> prodDataList = [];

          for (var product in snapshot.data!.docs) {
            if (product["imageURL2"] != "") {
              Map<String, dynamic> prodData =
                  product.data() as Map<String, dynamic>;
              prodDataList.add(prodData);
            }
          }

          return ListView.builder(
            itemCount: prodDataList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Image.network(prodDataList[index]['imageURL2']),
                title: Text(prodDataList[index]['sliderTitle']),
                subtitle: Text(prodDataList[index]['sliderDesc']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle edit functionality
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('تأكيد الحذف'),
                              content: const Text('هل تريد حذف هذا العنصر؟'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    deleteDataFromFirebase(
                                      snapshot.data!.docs[index].id,
                                      prodDataList[index]['imageURL2'],
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('نعم'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('لا'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('إضافة عنصر جديد'),
                content: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: _image != null
                          ? Image.file(
                              _image!,
                              width: 100,
                              height: 100,
                            )
                          : const Text('اختر صورة'),
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'عنوان العنصر',
                      ),
                    ),
                    TextField(
                      controller: _descController,
                      decoration: const InputDecoration(
                        labelText: 'وصف العنصر',
                      ),
                    ),
                    TextField(
                      controller: _linkController,
                      decoration: const InputDecoration(
                        labelText: 'الرابط',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      addDataToFirebase();
                      Navigator.of(context).pop();
                    },
                    child: const Text('حفظ'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
