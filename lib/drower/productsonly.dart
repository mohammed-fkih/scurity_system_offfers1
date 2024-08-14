import 'package:flutter/material.dart';
import 'package:scurity_system_offfers1/drower/prodactdisc.dart';
import 'package:scurity_system_offfers1/home/bottombar.dart';
import 'package:scurity_system_offfers1/home/commencations.dart';

import '../home/appBar.dart';

class ProductOnly extends StatefulWidget {
  const ProductOnly({
    super.key,
    required this.productsData,
    required this.classesData,
    required this.productData,
  });
  final List<Map<String, dynamic>> productData;
  final List<Map<String, dynamic>> classesData;
  final List<Map<String, dynamic>> productsData;
  @override
  State<ProductOnly> createState() => _ProductState();
}

class _ProductState extends State<ProductOnly> {
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    products = widget.productData;
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
          ),
        ),
        body: Container(
          margin: MediaQuery.of(context).size.width <= 600
              ? const EdgeInsets.symmetric(horizontal: 7)
              : const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    if (products.isNotEmpty) ...[
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width <= 800 ? 2 : 3,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = products[index];
                          return InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProdactDisc(
                                    classesData: widget.classesData,
                                    productsData: widget.productData,
                                    prodactData: item,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black12, width: 0.5),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: item['imageURL1'] != null
                                        ? Image.network(
                                            item['imageURL1'],
                                          )
                                        : Container(),
                                  ),
                                  Text(
                                    item['productName'],
                                    style: TextStyle(
                                      fontFamily: 'Schyler',
                                      fontSize: 11,
                                      color: item['imageBackground'] ==
                                              Colors.black
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ] else ...[
                      const SizedBox(
                        height: 500,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.info_outline),
                              Text("  لايوجد منتجات"),
                            ],
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(
                      height: 20,
                    ),
                    const ContactSection(),
                    const SizedBox(
                      height: 15,
                    ),
                    BottomBar(
                      productsList: widget.productsData,
                      classessList: widget.classesData,
                      isInProduct: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
