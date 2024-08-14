import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scurity_system_offfers1/data/firebaseDataBase.dart';

import '../data/firedatabase.dart';
import 'edit_product.dart';

class ShowProducts extends StatefulWidget {
  const ShowProducts({super.key});

  @override
  _ShowProductsState createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'عرض المنتجات',
          ),
          backgroundColor: const Color.fromARGB(255, 98, 185, 225),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('products').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
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
                        child: Column(
                          children: [
                            Text("اسم المنتج : ${doc['productName']}",
                                style: const TextStyle(fontSize: 20)),
                            const SizedBox(height: 7.0),
                            const Text('صورة المنتج'),
                            const SizedBox(height: 7.0),
                            if (doc["imageURL1"] != null) ...[
                              const SizedBox(height: 7.0),
                              Image.network(
                                doc["imageURL1"]!,
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ] else ...[
                              const Icon(Icons.image)
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          children: [
                            Text("الصنف : ${doc['class']}"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          children: [
                            const Text("وصف المنتج :"),
                            const SizedBox(height: 7.0),
                            ListTile(
                              title: Text(doc['addresses']),
                              subtitle: Text(doc['descriptions']),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      const SizedBox(height: 7.0),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            color: Colors.white10,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AlertDialog(
                                      title: const Text(
                                        'حذف العنصر',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      content: const Text(
                                          'سيتم حذف العنصر ولا يمكنك استعادته. هل أنت ترغب بحذف العنصر؟'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('إلغاء'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            MyFirebase()
                                                .deleteData(doc.id, 'products');

                                            if (doc['imageURL2'] != '') {
                                              FireBase()
                                                  .deleteFile(doc['imageURL2']);
                                            }
                                            if (doc['imageURL1'] != '') {
                                              FireBase()
                                                  .deleteFile(doc['imageURL1']);
                                            }

                                            Navigator.pop(context);
                                          },
                                          child: const Text('حذف'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            color: Colors.white10,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProduct(doc: doc),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Widget buildContainer(
  //     bool show, String? text, String? title, String? desc, String? imageURL) {
  //   if (show) {
  //     return Container(
  //       padding: const EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.black12, width: 1),
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(7),
  //       ),
  //       child: Column(
  //         children: [
  //           Text(text!),
  //           if (title != null) ...[
  //             Text(
  //               "العنوان : $title",
  //             ),
  //             const SizedBox(height: 10),
  //           ],
  //           if (desc != null) ...[
  //             Text(": الوصف  $desc"),
  //             const SizedBox(height: 10),
  //           ],
  //           if (imageURL != null) ...[
  //             Image.network(
  //               imageURL,
  //               height: 200,
  //               width: 200,
  //               fit: BoxFit.cover,
  //             ),
  //           ] else ...[
  //             const Icon(Icons.image)
  //           ],
  //         ],
  //       ),
  //     );
  //   } else {
  //     return const SizedBox.shrink();
  //   }
  // }
}
