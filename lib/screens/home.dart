import 'dart:developer';

import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/login.dart';
import 'package:e_commerce_app/screens/category_products.dart';
import 'package:e_commerce_app/screens/detailpage.dart';
import 'package:e_commerce_app/screens/drawer.dart';
import 'package:e_commerce_app/websevice/webservice.dart';
import 'package:flutter/material.dart';

import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: maincolor,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          //borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
        ),
        title: const Text(
          "E-COMMERCE",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Category",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: WebService().fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 100,
                      // color: Colors.grey,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                log("Clicked");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CategoryProductsPage(
                                        catid: snapshot.data![index].id,
                                        catname: snapshot.data![index].category,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                width: 175,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color:
                                      const Color.fromARGB(255, 239, 245, 238),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data![index].category,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Most Searched Products",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                future: WebService().fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final product = snapshot.data![index];
                          return InkWell(
                            onTap: () {
                              print("Clicked");
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DetailPage(
                                    id: product.id,
                                    name: product.productname,
                                    image:
                                        WebService().imageurl + product.image,
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
                                //child: Text("hello"),
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
                                          //  "https://bootcamp.cyralearnings.com/products/shoes.jpg"
                                          WebService().imageurl + product.image,
                                          // "//th.bing.com/th/id/OIP.owgta6Z8p5EA1GKcinmCdQHaEc?pid=ImgDet&rs=1l",
                                        )),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              product.productname,

                                              //"Shoes",
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Rs " + product.price.toString(),
                                              style: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        staggeredTileBuilder: (context) =>
                            const StaggeredTile.fit(1),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
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
