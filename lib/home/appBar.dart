import "package:flutter/material.dart";
import "package:scurity_system_offfers1/drower/servece.dart";
import "../drower/about_us.dart";
import "../drower/classes.dart";
import "../drower/product.dart";
import "home_page.dart";

class AppBar1 extends StatefulWidget {
  const AppBar1(
      {super.key, required this.productsList, required this.classesList});
  final List<Map<String, dynamic>> productsList;
  final List<Map<String, dynamic>> classesList;

  @override
  State<AppBar1> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar1> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            ListTile(
              title: const Text(
                'الرئيسية',
                style: TextStyle(fontFamily: 'Schyler'),
              ),
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  HomePage(classesData: widget.classesList,productsData: widget.productsList,),
                    ),
                  );
                });
              },
            ),
            ListTile(
              title: const Text('الاصناف',
                  style: TextStyle(fontFamily: 'Schyler')),
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Products(
                        classesData: widget.classesList,
                        productsData: widget.productsList,
                      ),
                    ),
                  );
                });
              },
            ),
            ListTile(
              title: const Text('المنتجات',
                  style: TextStyle(fontFamily: 'Schyler')),
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Product(
                          productsData: widget.productsList,
                          classesData: widget.classesList),
                    ),
                  );
                });
              },
            ),
            ListTile(
              title: const Text('طلب خدمة',
                  style: TextStyle(fontFamily: 'Schyler')),
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Service(
                          classesData: widget.classesList,
                          productsData: widget.productsList),
                    ),
                  );
                });
              },
            ),
            ListTile(
              title:
                  const Text('من نحن', style: TextStyle(fontFamily: 'Schyler')),
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUs(
                          classesData: widget.classesList,
                          productsData: widget.productsList),
                    ),
                  );
                });
              },
            ),
            // ListTile(
            //   title:
            //       const Text("التحكم", style: TextStyle(fontFamily: 'Schyler')),
            //   onTap: () {
            //     setState(() {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => const HomeControl(),
            //           ));
            //     });
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
