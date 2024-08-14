import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scurity_system_offfers1/home/home_page.dart';
import 'package:scurity_system_offfers1/home/splash_screen.dart';

import '../data/firebaseDataBase.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> classesData = [];
  List<Map<String, dynamic>> productsData = [];
  String productId = "";
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    initializeFirebase();
    fetchProducts();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> fetchProducts() async {
    // productsData = await FireBase().fetchAllDataFromFirebase('products');
    classesData = await FireBase().fetchAllDataFromFirebase('classes');
    final productsSnapshot = await _firestore.collection('products').get();
    productsData = productsSnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp();
    } catch (error) {
      print("حدث خطأ أثناء تهيئة Firebase: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SplashScreen();
    } else {
      if (productsData.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "تحقق من اتصال جهازك بالإنترنت ثم قم بإعادة فتح التطبيق."),
            ),
          );
        });
      }
      return  HomePage(classesData: classesData,productsData: productsData,);
    }
  }
}
