// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scurity_system_offfers1/data/firebaseDataBase.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<AddProduct> {
  late FirebaseStorage _storage;
  String? imagesUrl;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? addresses = '';
  String? descriptions = '';
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _shopLink = TextEditingController();
  String shopLink = '';
  String selectedCategory = '';
  // ignore: prefer_typing_uninitialized_variables
  var pickedImage;
  String? imageURL1;
  String? Url1 = '';
  String? Url2 = '';

  TextEditingController productNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> _chooseImage(int imageIndex) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedImage != null && imageIndex == 1) {
        imageURL1 = pickedImage.path;
      } else {
        imagesUrl = pickedImage?.path;
      }
    });
  }

  bool isEnable = true;
  List<String> categoryList = [];
  Future<void> fetchCategories() async {
    try {
      await Firebase.initializeApp();
      QuerySnapshot querySnapshot =
          await _firestore.collection('classes').get();
      List<String> categories = [];
      for (var doc in querySnapshot.docs) {
        categories.add((doc.data() as Map)['name']);
      }
      setState(() {
        categoryList = categories;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching categories')),
      );
    }
  }

  Future<void> saveDataToFirebase() async {
    try {
      await Firebase.initializeApp();
      if (productNameController.text != '' &&
          addressController != '' &&
          descriptionController != '' &&
          _shopLink != '') {
        // Create a new document in the 'products' collection
        await FireBase().addDataToFirebase_Id('products',{
          'productName': productNameController.text,
          'addresses': addressController.text,
          'descriptions': descriptionController.text,
          'imageURL1': Url1,
          'class': selectedCategory,
          'videoLink': _links,
          'imagesUrl': _imagesUrl,
          'shopLink': _shopLink.text,
          'creatAt': DateTime.now()
        } );
        // await _firestore.collection('products').add();
        // Clear the form fields and lists
        productNameController.clear();
        addressController.clear();
        descriptionController.clear();
        _shopLink.clear;
        setState(() {
          addresses = '';
          descriptions = '';
          imageURL1 = null;
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حفظ المنتج بنجاح')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('قم بتأكد من الحقول الفارغة')),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error saving data')),
      );
    }
  }

  Map<String, String> _links = {};
  void _addLink() {
    String url = _urlController.text;
    String description = _descriptionController.text;

    if (url.isNotEmpty && description.isNotEmpty) {
      setState(() {
        _links = {'url': url, 'description': description};
      });

      _urlController.clear();
      _descriptionController.clear();
    }
  }

  final List<dynamic> _imagesUrl = [];

  @override
  void initState() {
    _storage = FirebaseStorage.instance;
    fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'إضافة منتج جديد',
              ),
              backgroundColor: const Color.fromARGB(255, 98, 185, 225),
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12, width: 1),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Column(children: [
                            TextField(
                              controller: productNameController,
                              decoration: const InputDecoration(
                                labelText: 'اسم المنتج',
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            if (Url1 != null && Url1!.isNotEmpty) ...[
                              const SizedBox(height: 16.0),
                              Image.network(
                                Url1!,
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              )
                            ] else ...[
                              const Icon(Icons.image)
                            ],
                            Row(
                              children: [
                                const Text('اختر صورة للمنتج: '),
                                ElevatedButton(
                                  onPressed: () async {
                                    await _chooseImage(1);
                                    if (imageURL1!.isNotEmpty) {
                                      Url1 = await _uploadImage(imageURL1!);
                                    }
                                  },
                                  child: const Text('اختر صورة'),
                                ),
                              ],
                            ),
                          ])),
                      const SizedBox(height: 16.0),
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12, width: 1),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                  "اختر الصف الذي ينتمي إليه هذا المنتج"),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: categoryList.map((category) {
                                  return RadioListTile<String>(
                                    title: Text(category),
                                    value: category,
                                    groupValue: selectedCategory,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCategory = value!;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          )),
                      TextField(
                        controller: _shopLink,
                        decoration: const InputDecoration(
                            label: Text("رابط المنتج على المتجر")),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: addressController,
                              decoration: const InputDecoration(
                                labelText: 'العنوان',
                              ),
                            ),
                            TextField(
                              controller: descriptionController,
                              maxLines: 10,
                              decoration:
                                  const InputDecoration(label: Text("الوصف")),
                            ),
                            const SizedBox(height: 16.0),
                            const SizedBox(height: 16.0),
                            const SizedBox(height: 16.0),
                            Container(
                              height: 200,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black12, width: 0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _urlController,
                                      decoration: const InputDecoration(
                                        labelText: 'رابط الفيديو ',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _descriptionController,
                                      decoration: const InputDecoration(
                                        labelText: 'الوصف',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: _addLink,
                                    child: const Text('إضافة'),
                                  ),
                                  const SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _links.entries.map((entry) {
                                      return Text(
                                          '${entry.key}              ${entry.value}');
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              // height: 200,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12, width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text('اختر صورة توضيحية: '),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await _chooseImage(2);
                                          if (imagesUrl!.isNotEmpty) {
                                            Url2 =
                                                await _uploadImage(imagesUrl!);
                                            _imagesUrl.add(Url2);
                                          }
                                        },
                                        child: const Text('اختر صورة'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(pickedImage != null
                                      ? pickedImage!.path
                                      : ""),
                                  const SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _imagesUrl.map((entry) {
                                      return entry != null
                                          ? Image.network(entry)
                                          : const Text("No image selected");
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await saveDataToFirebase();
                              },
                              child: const Text('حفظ'),
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ]))));
  }

  Future<String?> _uploadImage(String imagePath) async {
    if (imagePath.isNotEmpty) {
      final file = File(imagePath);
      final fileName = file.path.split('/').last;

      final uploadTask =
          _storage.ref().child('products/$fileName').putFile(file);

      try {
        final snapshot = await uploadTask.whenComplete(() {});
        if (snapshot.state == TaskState.success) {
          final imageUrl = await snapshot.ref.getDownloadURL();
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم حفظ البيانات بنجاح')),
          );

          return imageUrl;
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('حدث خطأ أثناء الحفظ')),
          );
          return null;
        }
      } catch (error) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ أثناء الرفع')),
        );
        return null;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار صورة')),
      );
      return null;
    }
  }
}
