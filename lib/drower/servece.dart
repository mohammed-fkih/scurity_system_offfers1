import 'package:flutter/material.dart';
import 'package:scurity_system_offfers1/home/bottombar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home/appBar.dart';
// import 'package:websit_for_cameras/home/commenction.dart';

class Service extends StatelessWidget {
  const Service(
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
              child: AppBar1(
                  classesList: classesData, productsList: productsData)),
          body: MediaQuery.of(context).size.width <= 600
              ? phone()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 70),
                          child: Center(child: phone())),
                    ),
                  ],
                ),
        ));
  }

  Widget phone() {
    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.all(8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "أهلا بك وسهلا بك",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontFamily: "Schyler"),
        ),
        const Text(
          "نحن نملك العديد من الخدمات المتميزة في مجال الامن وتقنية المعلومات لطلب خدمة معينة ماعليك سوى اختيار الخدمة المناسبة من قائمة الخدمات  ثم قم بطلبها عن طريق التواصل معنا من خلال مواقع التواصل الاجتماعي اسفل الصفحة ",
          style: TextStyle(fontSize: 14, fontFamily: "Schyler"),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          " قائمة الخدمات التي نقدمها",
          style: TextStyle(fontFamily: "Schyler", fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textService(" 1 - تركيب كميرات مراقبة امنية"),
              textService("2 - تركيب الشبكات باحترافية وبطرق مبتكرة"),
              textService("3 - تركيب السنترالات"),
              textService("4 - تركيب أجهزة الحضور والانصراف "),
              textService("5 - تركيب أجهزة الانتركم "),
              textService("6 - تركيب أنظمة الانذار "),
              textService("7 - تركيب الاقفال الالكترونية الذكية "),
              textService("8 - تركيب أجهزة الداش كام وتتبع السيارات "),
              const Text(
                "معنا عش في أمان وفي بيئة ذكية",
                style: TextStyle(fontFamily: "Schyler", fontSize: 14),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "قم بطلب الخدمة بالطرق التالية ",
          style: TextStyle(fontSize: 18, fontFamily: "Schyler"),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  launch("'https://wa.me/+966571025752'");
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("واتس اب")
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  launch("info@sso-ksa.com");
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.black45,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("البريد الالكتروني")
                  ],
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  launch("tel:+966571025752");
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.call_end,
                      color: Colors.black45,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("مكالمة هاتفية")
                  ],
                )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "إذا كنت تريد شراء أحد منتجتنا فقم بزيارة متجرنا الالكتروني   ",
          style: TextStyle(fontSize: 18, fontFamily: "Schyler"),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  launch("https://ss-offers.com");
                },
                child: const Row(
                  children: [
                    Icon(Icons.shopping_cart),
                    SizedBox(
                      width: 5,
                    ),
                    Text("متجرنا الالكتروني")
                  ],
                ))
          ],
        ),
        BottomBar(
            productsList: productsData,
            classessList: classesData,
            isInProduct: false),
      ]),
    ));
  }

  Widget textService(String text) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        text,
        style: const TextStyle(fontFamily: "Schyler", fontSize: 15),
      ),
      const SizedBox(
        height: 7,
      )
    ]);
  }
}
