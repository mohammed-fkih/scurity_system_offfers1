import 'package:flutter/material.dart';

import '../drower/prodactdisc.dart';

class SearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> searchData;
  final List<Map<String, dynamic>> classesData;

  const SearchPage({Key? key, required this.searchData, required this.classesData})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> filteredData = [];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    filteredData = widget.searchData
                        .where((item) =>
                            item['productName']
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                        .toList();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'ابحث هنا...',
                ),
              ),
            ),
        ),
        body: Column(
          children: [
            
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Map<String, dynamic> productData = {};
                      widget.searchData.forEach((element) {
                        if (element['gID'] == filteredData[index]['gID']) {
                          productData = element;
                        }
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProdactDisc(
                            productsData: widget.searchData,
                            classesData: widget.classesData,
                            prodactData: productData,
                          ),
                        ),
                      );
                    },
                    leading: Image.network(filteredData[index]['imageURL1']),
                    title: Text(filteredData[index]['productName']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}