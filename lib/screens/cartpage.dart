import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/screens/checkoutpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  List<CartProduct> cartlist = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: const Text(
            "Cart",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            context.watch<Cart>().getItems.isEmpty
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      context.read<Cart>().clearCart();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
        body: context.watch<Cart>().getItems.isEmpty
            ? const Center(
                child: Text("Empty Cart"),
              )
            : Consumer<Cart>(builder: (context, cart, child) {
                cartlist = cart.getItems;
                return ListView.builder(
                    itemCount: cart.count,
                    itemBuilder: (context, Index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: const Color.fromARGB(255, 250, 255, 250),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: SizedBox(
                            height: 100,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 9),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              cartlist[Index].imagesUrl,
                                              // cart.getItems[Index].imagesUrl,
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Wrap(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            cartlist[Index].name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                cartlist[Index]
                                                    .price
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red.shade800,
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade400,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        cartlist[Index].qty == 1
                                                            ? cart.removeItem(
                                                                cart.getItems[
                                                                    Index])
                                                            : cart.reduceByOne(
                                                                cartlist[
                                                                    Index]);
                                                      },
                                                      icon:
                                                          cartlist[Index].qty ==
                                                                  1
                                                              ? const Icon(
                                                                  Icons.delete,
                                                                  size: 18,
                                                                )
                                                              : const Icon(
                                                                  Icons
                                                                      .minimize_rounded,
                                                                  size: 18,
                                                                ),
                                                    ),
                                                    Text(
                                                      cartlist[Index]
                                                          .qty
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          cart.increment(
                                                              cartlist[Index]);
                                                        },
                                                        icon: const Icon(
                                                          Icons.add,
                                                          size: 18,
                                                        ))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: ${context.watch<Cart>().totalPrice}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<Cart>().getItems.isEmpty
                      ? ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          content: Text("Cart is empty !!!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              )),
                        ))
                      : Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return CheckoutPage(cart: cartlist);
                          },
                        ));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: maincolor,
                  ),
                  child: const Center(
                    child: Text(
                      "Order Now",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
