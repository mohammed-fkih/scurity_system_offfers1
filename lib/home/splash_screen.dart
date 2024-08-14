import "package:flutter/material.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ' مؤسسة عروض الأنظمة الأمنية  ',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Schyler",
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Security System Offers',
              style: TextStyle(
                fontSize: 24,
                fontFamily: "Schyler",
              ),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
