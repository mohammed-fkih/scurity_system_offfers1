import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scurity_system_offfers1/data/firebaseDataBase.dart';
import 'drower/productsonly.dart';
//----------------------------------- ImageSlider --------------------------------------------------

class ImageSlider extends StatefulWidget {
  const ImageSlider({
    super.key,
  });

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<Map<String, dynamic>> prodDataList = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    List<Map<String, dynamic>> data =
        await FireBase().fetchAllDataFromFirebase('sliders');
    if (mounted) {
      setState(() {
        prodDataList = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width <= 750 ? double.infinity : 750,
      child: prodDataList.isNotEmpty
          ? buildCarouselSlider()
          : buildPlaceholderContainer(),
    );
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.blue, // لون دائرة التحميل
        // حجم دائرة التحميل
      ),
    );
  }

  Widget buildCarouselSlider() {
    return Center(
      child: CarouselSlider.builder(
        itemCount: prodDataList.length,
        itemBuilder: (_, int index, int i) {
          return InkWell(
            onTap: () {
              if (prodDataList[i]['link']) {
                // ignore: deprecated_member_use
                launch(prodDataList[i]['link']);
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(prodDataList[index]['imageURL2'].toString(),
                     fit: BoxFit.fill,
                    errorBuilder: (context, exception, stackTrace) {
                  return Container();
                }),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        prodDataList[index]['sliderTitle'].toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "Schyler",
                        ),
                      ),
                      Text(
                        prodDataList[index]['sliderDesc'].toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "Schyler",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        options: CarouselOptions(
          viewportFraction: 1,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
          disableCenter: true,
          enlargeFactor: 4,
          aspectRatio: 16 / 9,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          initialPage: 0,
          reverse: true,
        ),
      ),
    );
  }

  Widget buildPlaceholderContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250, // تعديل الارتفاع حسب الحاجة
      color: Colors.grey, // لون الاستبدال
    );
  }
}

//----------------------------------- ProductsElement --------------------------------------------------

class ProductsElement extends StatefulWidget {
  const ProductsElement({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  final String imageUrl;
  final String name;

  @override
  State<ProductsElement> createState() => _ProductsElementState();
}

class _ProductsElementState extends State<ProductsElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Image.network(widget.imageUrl, fit: BoxFit.fill,
                  errorBuilder: (context, exception, stackTrace) {
                return Container();
              }),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(
                right: 8,
                left: 8,
              ),
              child: Text(
                widget.name,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "Schyler",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//----------------------------------- ImagesInList --------------------------------------------------
class ImagesInList extends StatefulWidget {
  const ImagesInList({
    super.key,
  });

  @override
  State<ImagesInList> createState() => _ImagesInListState();
}

class _ImagesInListState extends State<ImagesInList> {
  List<Map<String, dynamic>> prodDataList = [];
  Future<void> getData() async {
    List<Map<String, dynamic>> data =
        await FireBase().fetchAllDataFromFirebase('homeImage');
    if (mounted) {
      setState(() {
        prodDataList = data;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: prodDataList.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () async {
            if (prodDataList[i]['link'] != "" &&
                prodDataList[i]['link'] != null) {
              // ignore: deprecated_member_use
              launch(prodDataList[i]['link']);
            }
          },
          child: Container(
            height: 300,
            color: Colors.white,
            child: (prodDataList[i]['imageURL2'] != "")
                ? Card(
                    child: Stack(
                      children: [
                        Image.network(
                          prodDataList[i]['imageURL2'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, exception, stackTrace) {
                            return Container();
                          },
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                color: Colors.black.withOpacity(0.5),
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  prodDataList[i]['sliderTitle'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontFamily: "Schyler",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
        );
      },
    );
  }
}

//----------------------------------- MyProducts --------------------------------------------------

class MyProducts extends StatefulWidget {
  const MyProducts(
      {super.key, required this.classesData, required this.productssData});

  final List<Map<String, dynamic>> classesData;
  final List<Map<String, dynamic>> productssData;

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> classes = [];

  @override
  void initState() {
    super.initState();
    products = widget.productssData;
    classes = widget.classesData;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: MediaQuery.of(context).size.width <= 650 ? 2 : 3,
      children: classes.map((item) {
        return InkWell(
          onTap: () async {
            List<Map<String, dynamic>> productData = [];

            // ignore: unnecessary_null_comparison
            if (products != null) {
              for (var el in products) {
                if (el['class'] == item['name']) {
                  productData.add(el);
                }
              }
            }

            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductOnly(
                    productData: productData,
                    classesData: widget.classesData,
                    productsData: widget.productssData),
              ),
            );
          },
          child: item["imageURL"] != null &&
                  item["imageURL"].toString().isNotEmpty
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.black12, width: 0.5),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  width: 200,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: SizedBox(
                          child: Image.network(
                            item["imageURL"].toString(),
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return const Icon(Icons
                                  .error); // عرض رمز الخطأ في حالة فشل تحميل الصورة
                            },
                          ),
                        ),
                      ),
                      // const SizedBox(height: 3),
                      Expanded(
                        flex: 2,
                        child: Text(
                          item["name"].toString(),
                          style: const TextStyle(
                              fontSize: 14, fontFamily: 'Schyler'),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        );
      }).toList(),
    );
  }
}
