
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:scurity_system_offfers1/drower/prodactdisc.dart';
import 'package:scurity_system_offfers1/home/search.dart';
// import '../drower/prodactdisc.dart';
import '../drower/product.dart';
import '../widgets.dart';
import 'appBar.dart';
import 'bottombar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key, required this.classesData, required this.productsData,
  });
  final List<Map<String, dynamic>> classesData;
  final List<Map<String, dynamic>> productsData;
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ChangeNotifier {
  int index1 = 0;

  List<Map<String, dynamic>> classesData = [];
  List<Map<String, dynamic>> productsData = [];
  String productId = "";
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // initializeFirebase();
    // fetchProducts();
    classesData=widget.classesData;
    productsData=widget.productsData;
  }

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Future<void> fetchProducts() async {
  //   // productsData = await FireBase().fetchAllDataFromFirebase('products');
  //   classesData = await FireBase().fetchAllDataFromFirebase('classes');
  //   final productsSnapshot = await _firestore.collection('products').get();
  //   productsData = productsSnapshot.docs.map((doc) => doc.data()).toList();
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // Future<void> initializeFirebase() async {
  //   try {
  //     await Firebase.initializeApp();
  //   } catch (error) {
  //     print("حدث خطأ أثناء تهيئة Firebase: $error");
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
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
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title:  const Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/camer.png"),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "مؤسسة عروض الأنظمة الأمنية",
                    style: TextStyle(fontFamily: "Schyler", fontSize: 16),
                  ),
                ],
              ),
            
            actions: [
              IconButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchPage(searchData: productsData,classesData: classesData,)
                            ),
                          );
                

              }, icon: const Icon(Icons.search))
            ],
          ),
          drawer: Drawer(
            child: AppBar1(
              classesList: classesData,
              productsList: productsData,
            ),
          ),
          body: SingleChildScrollView(
            child: ChangeNotifierProvider.value(
              value: this,
              child: Consumer<_HomePageState>(
                builder: (context, homePageState, _) {
                  return Column(children: [
                    MediaQuery.of(context).size.width <= 700
                        ? phone()
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: AppBar1(
                                  classesList: classesData,
                                  productsList: productsData,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: phone(),
                              ),
                            ],
                          ),
                    BottomBar(
                      productsList: productsData,
                      classessList: classesData,
                      isInProduct: false,
                    ),
                  ]);
                },
              ),
            ),
          ),
        ),
      );
    }
  

  Widget phone() {
    // fetchProducts();
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ImageSlider(),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "المنتجات",
                    style: TextStyle(fontFamily: "Schyler", fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Product(
                                productsData: productsData,
                                classesData: productsData),
                          ),
                        );
                      });
                    },
                    child: const Text(
                      "عرض الكل",
                      style: TextStyle(fontFamily: "Schyler", fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10)),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: productsData.length,
                  itemBuilder: (context, i) {
                    if (productsData.isNotEmpty) {
                      return InkWell(
                        onTap: () {
                          
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdactDisc(
                            classesData: classesData,
                            productsData: productsData,
                            prodactData: productsData[i]
                           ),
                            ),
                          );

                          setState(() {
                            index1 = i;
                          });
                        },
                        child: ProductsElement(
                          imageUrl: productsData[i]['imageURL1'] ?? '',
                          name: productsData[i]['productName'] ?? '',
                        ),
                      );
                    }
                    return null;
                  },
                )),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: const Text(
                "ماهو الجديد",
                style: TextStyle(fontFamily: "Schyler", fontSize: 15),
              ),
            ),
            const SizedBox(height: 10),
            const ImagesInList(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
