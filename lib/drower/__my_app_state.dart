import 'package:flutter/material.dart';
import 'package:scurity_system_offfers1/home/appBar.dart';
import 'package:scurity_system_offfers1/home/bottombar.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:scurity_systems_offers/drower/drawer.dart';
import 'package:scurity_system_offfers1/home/commencations.dart';

class ProdactDisc1 extends StatefulWidget {
  const ProdactDisc1(
      {super.key,
      required this.prodactsData,
      required this.productsData,
      required this.classesData});
  final Map<String, dynamic> prodactsData;
  final List<Map<String, dynamic>> productsData;
  final List<Map<String, dynamic>> classesData;

  @override
  State<ProdactDisc1> createState() => _MyAppState();
}

class _MyAppState extends State<ProdactDisc1> {
  Map<String, dynamic>? products;
  List<dynamic> images = [];
  @override
  void initState() {
    if (mounted) {
      setState(() {});
    }
    products = widget.prodactsData;
    images = products!['imagesUrl'];
    super.initState();
  }

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
          classesList: widget.classesData,
          productsList: widget.productsData,
        )),
        body: MediaQuery.of(context).size.width <= 600
            ? phone()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: AppBar1(
                        classesList: widget.classesData,
                        productsList: widget.productsData),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 70),
                        child: Center(child: phone())),
                  ),
                ],
              ),
      ),
    );
  }

  Widget phone() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        margin: MediaQuery.of(context).size.width >= 900
            ? const EdgeInsets.symmetric(horizontal: 40)
            : const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          children: [
            if (products != null) ...[
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          if (products!['productName'] != null)
                            Text(
                              products!['productName'].toString(),
                              style: const TextStyle(
                                fontFamily: 'Schyler',
                                fontSize: 20,
                              ),
                            ),
                          if (products!['imageURL1'] != null)
                            Image.network(products!['imageURL1']),
                          const Text(''),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // ignore: deprecated_member_use
                        launch('${products!['shopLink']}');
                      },
                      child: const Row(children: [
                        Icon(
                          Icons.shopping_cart_rounded,
                          size: 50,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "الانتقال الى المتجر للشراء",
                          style: TextStyle(fontFamily: "Schyler", fontSize: 18),
                        ),
                      ])),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          if (products!['addresses'] != null)
                            Text(
                              products!['addresses'].toString(),
                              style: const TextStyle(
                                fontFamily: 'Schyler',
                                fontSize: 18,
                              ),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (products!['descriptions'] != null)
                            Text(
                              products!['descriptions'],
                              style: const TextStyle(
                                fontFamily: 'Schyler',
                                fontSize: 14,
                                height: 2,
                              ),
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (products?['videoLink'] != null &&
                              products?['videoLink']['url'] != null) ...[
                            InkWell(
                              child: Card(
                                child: Column(
                                  children: [
                                    Card(
                                      child: TextButton(
                                        onPressed: () {
                                          // ignore: deprecated_member_use
                                          launch(
                                              "${products?['videoLink']['url']}");
                                        },
                                        child: Text(
                                            "${products?['videoLink']['url']}"),
                                      ),
                                    ),
                                    Text(
                                        "${products?['videoLink']['description']}")
                                  ],
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(
                            height: 5,
                          ),
                          if (products?['imagesUrl'] != null) ...[
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: images.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                      child: Image.network(
                                          "${products?['imagesUrl'][index]}"));
                                })
                          ],
                          const SizedBox(
                            height: 15,
                          ),
                          const Divider(),
                          const ContactSection(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              const SizedBox(
                height: 400,
                child: Center(
                  child: Text("لايوجد منتجات"),
                ),
              )
            ],
            const SizedBox(
              height: 15,
            ),
            BottomBar(
              productsList: widget.productsData,
              classessList: widget.classesData,
              isInProduct: false,
            )
          ],
        ),
      ),
    );
  }
}
