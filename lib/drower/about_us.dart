// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:scurity_system_offfers1/home/bottombar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home/appBar.dart';
// import 'package:websit_for_cameras/home/commenction.dart';

class AboutUs extends StatelessWidget {
  const AboutUs(
      {super.key, required this.productsData, required this.classesData});
  final List<Map<String, dynamic>> productsData;
  final List<Map<String, dynamic>> classesData;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color.fromARGB(255, 98, 185, 225),
          title: const Center(
            child: Row(children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/camer.png"),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "مؤسسة عروض الأنظمة الأمنية",
                style: TextStyle(fontFamily: "Schyler", fontSize: 18),
              ),
            ]),
          ),
        ),
        drawer: Drawer(
            child:
                AppBar1(classesList: classesData, productsList: productsData)),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth <= 600) {
            return phone();
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 70),
                    child: phone(),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget phone() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Text(
              "مؤسسة عروض الانظمة الامنية",
              style: TextStyle(fontFamily: 'Schyler'),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "مؤسسة متخصصه في بيع وتركيب الانظمة األمنية"
                  "، توريد وتركيب الانظمة الشبكية والكيمرات بمختلف أنواعها "
                  "والسنترا لات واجهزة البصمة والانذار وجرس الابواب"
                  " وأجهزة المناداة والانظمية الصوتية والمرئية."
                  "نتواجد في المملكة العربية السعودية في مدينة الرياض",
                  style: TextStyle(fontFamily: 'Schyler', fontSize: 17),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      launch("https://maps.app.goo.gl/qGPvUr5nzpxej8d27");
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          size: 40,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "موقعنا على الخريطة",
                          style: TextStyle(fontFamily: 'Schyler', fontSize: 20),
                        ),
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BottomBar(
              productsList: productsData,
              classessList: classesData,
              isInProduct: false,
            )
          ],
        ),
      ),
    );
  }
}
