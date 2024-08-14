
import "package:flutter/material.dart";
import "package:scurity_system_offfers1/drower/classes.dart";
import "package:scurity_system_offfers1/drower/prodactdisc.dart";
import "package:scurity_system_offfers1/drower/product.dart";
import "package:scurity_system_offfers1/drower/servece.dart";
import "../drower/__my_app_state.dart";
import "../drower/about_us.dart";
import "../drower/productsonly.dart";
import "../widgets.dart";
import "commencations.dart";

class BottomBar extends StatefulWidget {
  const BottomBar(
      {super.key,
      required this.productsList,
      required this.classessList,
      required this.isInProduct});
  final List<Map<String, dynamic>> productsList;
  final List<Map<String, dynamic>> classessList;
  final bool isInProduct;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<Map<String, dynamic>> class1 = [];
  List<Map<String, dynamic>> class2 = [];
  List<Map<String, dynamic>> class3 = [];
  List<Map<String, dynamic>> class4 = [];
  List<Map<String, dynamic>> class5 = [];
  List<Map<String, dynamic>> class6 = [];
  List<Map<String, dynamic>> class7 = [];
  int index1 = 0;
  List<Map<String, dynamic>> productData = [];

  List<Map<String, dynamic>> productsData = [];
  Future<void> fetchProducts() async {
    productsData = widget.productsList;
    class1.clear();
    class2.clear();
    class3.clear();
    class4.clear();
    class5.clear();
    class6.clear();
    class7.clear();
    for (var element in productsData) {
      for (var i = 0; i < widget.classessList.length; i++) {
        if (element['class'] == widget.classessList[i]['name']) {
          switch (i) {
            case 0:
              {
                class1.add(element);
              }
              break;
            case 1:
              {
                class2.add(element);
              }
              break;
            case 2:
              {
                class3.add(element);
              }
              break;
            case 3:
              {
                class4.add(element);
              }
              break;
              case 4:
              {
                class5.add(element);
              }
              break;
              case 5:
              {
                class6.add(element);
              }
              break;
            default:
              {
                class7.add(element);
              }
          }
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Text(
                  "    منتجـــــــات   ",
                  style: TextStyle(fontFamily: "Schyler",fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10,),
              Column(
                children: [
                  showProjectsAsClass(class1),
                  const SizedBox(height: 5),
                  showProjectsAsClass(class2),
                  const SizedBox(height: 5),
                  showProjectsAsClass(class3),
                  const SizedBox(height: 5),
                  showProjectsAsClass(class4),
                  const SizedBox(height: 5),
                  showProjectsAsClass(class5),
                  const SizedBox(height: 5),
                  showProjectsAsClass(class6),
                  const SizedBox(height: 5),
                  showProjectsAsClass(class7),
                  const SizedBox(height: 5),
                ],
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                  " اصناف المنتجات  ",
                  style: TextStyle(
                    fontFamily: "Schyler",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: widget.classessList.map((entry) {
                    return InkWell(
                      onTap: () async {
                        productData.clear();
                        // ignore: unnecessary_null_comparison
                        if (widget.productsList != null) {
                          for (var el in widget.productsList) {
                            if (el['class'] == entry['name']) {
                              productData.add(el);
                            }
                          }
                        }
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductOnly(
                                  productsData: widget.productsList,
                                  classesData: widget.classessList,
                                  productData: productData),
                            ),
                          );
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          entry['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Schyler",
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 15),
              const Divider(),
              const Text(
                " قائمة الخدمات التي نقدمها",
                style: TextStyle(
                  fontFamily: "Schyler",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textService("1 - تركيب كميرات مراقبة امنية"),
                      textService("2 - تركيب الشبكات باحترافية وبطرق مبتكرة"),
                      textService("3 - تركيب السنترالات"),
                      textService("4 - تركيب أجهزة الحضور والانصراف "),
                      textService("5 - تركيب أجهزة الانتركم "),
                      textService("6 - تركيب أنظمة الإنذار والإطفاء"),
                      const Text(
                        "معنا عش في أمان وفي بيئة ذكية",
                        style: TextStyle(fontFamily: "Schyler", fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                  "الانتقال السريع",
                  style: TextStyle(fontFamily: "Schyler",fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(spacing: 10, runSpacing: 10, children: [
                  fastGo("المتجات", 2),
                  fastGo("الاصناف", 1),
                  fastGo("طلب خدمة", 3),
                  fastGo("اين نحن", 4),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              const ContactSection1()
            ],
          ),
        ),
      ]),
    );
  }

  Widget showProjectsAsClass(List<Map<String, dynamic>> products) {
    return products.isNotEmpty
        ? Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, i) {
                  if (products.isNotEmpty) {
                    return InkWell(
                      onTap: () async {
                        setState(() {
                          index1 = widget.productsList.indexWhere((product) =>
                              product['productName'] ==
                              products[i]['productName']);
                        });
                        if (widget.isInProduct) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdactDisc1(
                                  prodactsData: widget.productsList[index1],
                                  classesData: widget.classessList,
                                  productsData: widget.productsList),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdactDisc(
                                classesData: widget.classessList,
                                productsData: widget.productsList,
                                prodactData: widget.productsList[index1]
                              ),
                            ),
                          );
                        }
                      },
                      child: ProductsElement(
                        imageUrl: products[i]['imageURL1'],
                        name: products[i]['productName'],
                      ),
                    );
                  }
                  return null;
                }))
        : Container();
  }

  Widget textService(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(fontFamily: "Schyler", fontSize: 15),
        ),
        const SizedBox(
          height: 7,
        )
      ],
    );
  }

  Widget fastGo(String text, int classes) {
    return InkWell(
        onTap: () {
          setState(() {
            switch (classes) {
              case 1:
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Products(
                          classesData: widget.classessList,
                          productsData: widget.productsList),
                    ),
                  );
                  break;
                }
              case 2:
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Product(
                          productsData: widget.productsList,
                          classesData: widget.classessList),
                    ),
                  );
                  break;
                }

              case 3:
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Service(
                          classesData: widget.classessList,
                          productsData: widget.productsList),
                    ),
                  );
                  break;
                }
              case 4:
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUs(
                          classesData: widget.classessList,
                          productsData: widget.productsList),
                    ),
                  );
                  break;
                }
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontFamily: "Schyler"),
          ),
        ));
  }
}
