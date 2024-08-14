import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scurity_system_offfers1/data/firebaseDataBase.dart';
import 'package:scurity_system_offfers1/data/firedatabase.dart';

class EditProduct extends StatefulWidget {
  final DocumentSnapshot doc;

  const EditProduct({super.key, required this.doc});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  File? imageURL1;
  File? imageURL2;
  bool? showInSlider;
  String? url1 = '';
  String? url2 = '';
  String selectedCategory = '';
  String? sliderTitle;
  String? sliderDesc;
  String? addresses;
  String? descriptions;
  String? productName;
  String? VideoUrl;
  String? videodesc;
  String? _shopLink;
  String? newURL1;
  Map<String, dynamic> _links = {};
  Future<void> _chooseImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedImage != null) {
        imageURL1 = File(pickedImage.path);
      }
    });
  }

  List<String> categoryList = [];

  Future<void> fetchCategories() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await Firebase.initializeApp();
      QuerySnapshot querySnapshot = await firestore.collection('classes').get();
      List<String> categories = [];
      for (var doc in querySnapshot.docs) {
        categories.add((doc.data() as Map)['name']);
      }
      setState(() {
        categoryList = categories;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching categories')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getImage();
    fetchCategories();
    selectedCategory = widget.doc['class'];
    addresses = widget.doc['addresses'];
    descriptions = widget.doc['descriptions'] ?? '';
    _shopLink = widget.doc['shopLink'] ?? '';
    _links = widget.doc['videoLink'] ?? {};
    videodesc = _links['description'] ?? '';
    VideoUrl = _links['url'] ?? '';
  }

  Future<void> getImage() async {
    url1 = await widget.doc['imageURL1'];
  }

  void _addLink() {
    String? url = VideoUrl;
    String? description = videodesc;

    if (url!.isNotEmpty && description!.isNotEmpty) {
      setState(() {
        _links = {'url': url, 'description': description};
      });
      VideoUrl = '';
      videodesc = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'تعديل بيانات المنتج',
              ),
              backgroundColor: const Color.fromARGB(255, 98, 185, 225),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'تفاصيل المنتج',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          initialValue: widget.doc['productName'],
                          decoration:
                              const InputDecoration(labelText: 'اسم المنتج'),
                          onChanged: (value) {
                            setState(() {
                              productName = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        DropdownButtonFormField<String>(
                          value: selectedCategory,
                          decoration: const InputDecoration(labelText: 'الفئة'),
                          items: categoryList.map((category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          initialValue: _shopLink,
                          decoration: const InputDecoration(
                              label: Text("رابط المنتج على المتجر")),
                          onChanged: (value) {
                            setState(() {
                              _shopLink = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          initialValue: widget.doc['addresses'],
                          decoration:
                              const InputDecoration(labelText: 'العناوين'),
                          onChanged: (value) {
                            setState(() {
                              addresses = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          maxLines: 10,
                          initialValue: widget.doc['descriptions'],
                          decoration: const InputDecoration(labelText: 'الوصف'),
                          onChanged: (value) {
                            setState(() {
                              descriptions = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: VideoUrl,
                            decoration: const InputDecoration(
                              labelText: 'رابط الفيديو ',
                            ),
                            onChanged: (value) {
                              setState(() {
                                VideoUrl = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: videodesc,
                            decoration: const InputDecoration(
                              labelText: 'الوصف',
                            ),
                            onChanged: (value) {
                              setState(() {
                                videodesc = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _addLink,
                          child: const Text('إضافة'),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _links.entries.map((entry) {
                            return Text(
                                '${entry.key}              ${entry.value}');
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'صور المنتج',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  _chooseImage();
                                },
                                child: const Text('تعديل صورة المنتج'),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        if (imageURL1 != null)
                          Row(
                            children: [
                              Expanded(
                                child: Image.file(imageURL1!),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () async {
                            if (imageURL1 != null) {
                              newURL1 = await FireBase()
                                  .updateFile(imageURL1!, url1!);
                              await MyFirebase()
                                  .updateData('products', widget.doc.id, {
                                'imageURL1': newURL1,
                              });
                            }
                            await MyFirebase()
                                .updateData('products', widget.doc.id, {
                              'productName': productName,
                              'addresses': addresses,
                              'descriptions': descriptions,
                              'shopLink': _shopLink,
                              'videoLink': _links,
                              'class': selectedCategory
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("تم التعديل بنجاح")));
                          },
                          child: const Text('حفظ التغييرات'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
