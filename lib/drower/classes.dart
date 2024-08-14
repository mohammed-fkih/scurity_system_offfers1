import 'package:flutter/material.dart';
import 'package:scurity_system_offfers1/home/appBar.dart';
import 'package:scurity_system_offfers1/home/bottombar.dart';
// import 'package:websit_for_cameras/home/commenction.dart';
//import 'package:websit_for_cameras/drower/product.dart';
import 'package:scurity_system_offfers1/widgets.dart';

///import 'package:websit_for_cameras/home/home_page.dart';

// ignore: must_be_immutable
class Products extends StatefulWidget {
  const Products(
      {super.key, required this.productsData, required this.classesData});
  final List<Map<String, dynamic>> productsData;
  final List<Map<String, dynamic>> classesData;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Products> {
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> classes = [];
  @override
  void initState() {
    products = widget.productsData;
    classes = widget.classesData;
    super.initState();
    if (mounted) {
      setState(() {});
    }
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
                  productsList: widget.productsData)),
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
        child: SafeArea(
            child: Column(
      children: [
        MyProducts(
          classesData: classes,
          productssData: products,
        ),
        const SizedBox(
          height: 2,
        ),
        const Divider(),
        BottomBar(
          productsList: widget.productsData,
          classessList: widget.classesData,
          isInProduct: false,
        )
      ],
    )));
  }
}
