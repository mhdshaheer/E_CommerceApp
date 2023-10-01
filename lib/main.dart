import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/screens/cartpage.dart';
import 'package:e_commerce_app/screens/category_products.dart';
import 'package:e_commerce_app/screens/checkoutpage.dart';
import 'package:e_commerce_app/screens/detailpage.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/login.dart';
import 'package:e_commerce_app/register.dart';
import 'package:e_commerce_app/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      //RegisterPage(),
      //HomePage(),
      //CategoryProductsPage(),
      //DetailPage(),
      //CartPage(),
      //   CheckoutPage(
      // cart: [],
      // ),
    );
  }
}
