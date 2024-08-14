import 'package:flutter/material.dart';
import 'package:scurity_system_offfers1/control/Sliders.dart';
import 'package:scurity_system_offfers1/control/add_new_class.dart';
import 'package:scurity_system_offfers1/control/add_new_product.dart';
import 'package:scurity_system_offfers1/control/homeImageList.dart';
import 'package:scurity_system_offfers1/control/show%20_classes.dart';
import 'package:scurity_system_offfers1/control/show_products.dart';
class HomeControl extends StatefulWidget {
  const HomeControl({super.key,});

  @override
  State<HomeControl> createState() => _HomeControlState();
}

class _HomeControlState extends State<HomeControl> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 30,
            title: const Text("التحكم", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
          ),
          body: Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddClass(),
                      ),
                    );
                  },
                  child: const Text("إظافة صنف جديد"),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddProduct(),
                      ),
                    );
                  },
                  child: const Text("إضافة منتج جديد"),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowClasses(),
                      ),
                    );
                  },
                  child: const Text('عرض الاصناف'),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowProducts(),
                      ),
                    );
                  },
                  child: const Text("عرض المنتجات"),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Sliders(),
                      ),
                    );
                  },
                  child: const Text("محتوى شريط التمرير"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeImageList(),
                      ),
                    );
                  },
                  child: const Text("محتوى قائمة الصور في الصفحة الرئيسية"),
                ),
              ],
            ),
          ),
        ));
  }
}
