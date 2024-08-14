import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scurity_system_offfers1/firebase_options.dart';
import 'package:scurity_system_offfers1/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "مؤسسة عروض الأنظمة الأمنية",
      debugShowCheckedModeBanner: false,
      home:Home() ,
     
    );
  }

  // final router = GoRouter(initialLocation: '/', routes: [
  //   GoRoute(
  //     path: '/',
  //     builder: (context, state) => const HomePage(),
  //     routes: [
  //       GoRoute(
  //         path: 'products/:id',
  //         builder: (context, state) => ProdactDisc(
  //             prodactData: state.extra as Map<String, dynamic>,
  //             id: state.pathParameters['id']),
  //       ),
  //     ],
  //   ),
  // ]);
}
