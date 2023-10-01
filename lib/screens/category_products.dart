// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:math';

import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/detailpage.dart';
import 'package:e_commerce_app/websevice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

// ignore: must_be_immutable
class CategoryProductsPage extends StatefulWidget {
  String catname;
  int catid;

  CategoryProductsPage({super.key, required this.catid, required this.catname});
  //CategoryProductsPage({super.key});

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: maincolor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
        title: Text(
          widget.catname,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        future: WebService().fetchCatProducts(widget.catid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return InkWell(
                  //inkwell for click event
                  onTap: () {
                    print("clicked");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailPage(
                          id: product.id,
                          name: product.productname,
                          image: WebService().imageurl + product.image,
                          description: product.description,
                          price: product.price.toString());
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 100,
                                maxHeight: 250,
                              ),
                              child: Image(
                                image: NetworkImage(
                                  WebService().imageurl + product.image,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    product.productname,
                                    //procduct.productname!,

                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Rs. ',
                                          style: TextStyle(
                                              color: Colors.red.shade900,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          //"1999.00",
                                          product.price.toString(),

                                          style: TextStyle(
                                              color: Colors.red.shade900,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
