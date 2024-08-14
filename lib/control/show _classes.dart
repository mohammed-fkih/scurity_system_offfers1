//import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scurity_system_offfers1/control/add_new_class.dart';
// import 'package:websit_for_cameras/control/add_new_class.dart';

import '../data/firedatabase.dart';

class ShowClasses extends StatefulWidget {
  const ShowClasses({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<ShowClasses> {
  String? imageName;

  @override
  void dispose() {
    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'عرض الأصناف',
          ),
          backgroundColor: const Color.fromARGB(255, 98, 185, 225),
        ),
        body: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('classes').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Text('An error occurred');
                  }

                  final List<DocumentSnapshot> classDocuments =
                      snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: classDocuments.length,
                    itemBuilder: (context, index) {
                      final classData = classDocuments[index].data();
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: (classData as Map)['name'] ?? '',
                              decoration: const InputDecoration(
                                labelText: 'الاسم',
                              ),
                              onChanged: (value) {
                                // Handle name change
                              },
                            ),
                            TextFormField(
                              initialValue: classData['description'] ?? '',
                              decoration: const InputDecoration(
                                labelText: 'الوصف',
                              ),
                              onChanged: (value) {
                                // Handle description change
                              },
                            ),
                            const SizedBox(height: 15),
                            if (classData['imageURL'] != null)
                              Image.network(
                                classData['imageURL'] ?? '',
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons
                                      .error); // صورة بديلة عند فشل التحميل
                                },
                              ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        imageName = classData['imageURL'] ?? '';
                                        return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: SingleChildScrollView(
                                              child: Container(
                                                  child: AlertDialog(
                                                title:
                                                    const Text('تعديل العنصر'),
                                                content: Column(
                                                  children: [
                                                    TextFormField(
                                                      initialValue:
                                                          (classData)['name'] ??
                                                              '',
                                                      onChanged: (value) {
                                                        setState(() {
                                                          classData['name'] =
                                                              value;
                                                        });
                                                      },
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'الاسم',
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      initialValue: classData[
                                                              'description'] ??
                                                          '',
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'الوصف',
                                                      ),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          classData[
                                                                  'description'] =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(height: 15),
                                                    if (imageName!.isNotEmpty)
                                                      Image.network(
                                                        imageName!,
                                                        height: 200,
                                                        width: 200,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return const Icon(
                                                              Icons.error);
                                                        },
                                                      ),
                                                    const SizedBox(height: 15),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        _selectImage();
                                                      },
                                                      child: const Text(
                                                          'تعديل الصورة'),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      await _uploadImage(
                                                          classDocuments[index]
                                                              .id);
                                                      await MyFirebase()
                                                          .updateData(
                                                              'classes',
                                                              classDocuments[
                                                                      index]
                                                                  .id,
                                                              {
                                                            'name': classData[
                                                                'name'],
                                                            'description':
                                                                classData[
                                                                    'description'],
                                                          });

                                                      // Handle data editing and update in Firebase
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('تعديل'),
                                                  ),
                                                ],
                                              )),
                                            ));
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: SingleChildScrollView(
                                                child: AlertDialog(
                                                  title: const Text(
                                                    'حذف العنصر',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  content: const Text(
                                                      'سيتم حذف العنصر ولا يمكنك إستعادته'),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          MyFirebase().deleteData(
                                                              classDocuments[
                                                                      index]
                                                                  .id,
                                                              'classes');
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text("حذف"))
                                                  ],
                                                ),
                                              ));
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddClass()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _selectImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imageName = pickedImage.path;
      });
    }
  }

  Future<void> _uploadImage(String classId) async {
    if (imageName!.isNotEmpty) {
      final file = File(imageName!);
      final fileName = file.path.split('/').last;
      final FirebaseStorage storage = FirebaseStorage.instance;
      final Reference storageReference = storage
          .ref()
          .child('classes/$fileName')
          .child(DateTime.now().toString());

      final UploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.whenComplete(() async {
        final imageUrl = await storageReference.getDownloadURL();

        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        final DocumentReference classRef =
            firestore.collection('classes').doc(classId);

        await classRef.update({'imageURL': imageUrl});
      });

      print('تم تحديث الصورة بنجاح!');
    }
  }
}
