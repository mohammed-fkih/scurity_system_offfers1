import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scurity_system_offfers1/data/firebaseDataBase.dart';

class AddClass extends StatefulWidget {
  const AddClass({super.key});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  Future<XFile?> selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  String? imageUrl;
  TextEditingController className = TextEditingController();
  TextEditingController description = TextEditingController();
  File? image;

  void showWarningMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("إظافة صنف جديد"),
          ),
          body: Container(
            margin: const EdgeInsets.all(6),
            child: Column(
              children: [
                TextFormField(
                  controller: className,
                  decoration: const InputDecoration(
                    labelText: "اسم الصنف",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: description,
                  decoration: const InputDecoration(
                    labelText: "الوصف ",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (image != null) ...[
                  Image.file(image!),
                ],
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    XFile? pickedImage = await selectImage();
                    if (pickedImage != null) {
                      setState(() {
                        image = File(pickedImage.path);
                      });
                    } else {
                      print('No image selected.');
                    }
                  },
                  child: const Text("إختر صورة للصنف"),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (className.text.isEmpty || image == null) {
                      showWarningMessage('الرجاء ملء جميع الحقول');
                    } else {
                      imageUrl = await FireBase().uploadFile(image!);
                      await FireBase().addDataToFirebase('classes', {
                        'name': className.text,
                        'image': imageUrl,
                        'description': description.text
                      });
                    }
                  },
                  child: const Text("إظافة صنف"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
