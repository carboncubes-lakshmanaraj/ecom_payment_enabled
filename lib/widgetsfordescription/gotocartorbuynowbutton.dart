// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom_payment/alertdialog/dialog_box_time.dart';
import 'package:ecom_payment/datas/cartitem.dart';
import 'package:ecom_payment/datas/product.dart';
import 'package:ecom_payment/screens/cartpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecom_payment/cartprovider/cart_provider.dart';
import 'package:ecom_payment/screens/checkoutform.dart';

class ButtonBuynowGotoCart extends StatelessWidget {
  final Product product;
  final String size;
  final String? selectedCurrency;
  const ButtonBuynowGotoCart({
    Key? key,
    required this.product,
    required this.size,
    required this.selectedCurrency,
  }) : super(key: key);

  void _onPress(BuildContext context) {
    // if (size.isNotEmpty) {
    //   Provider.of<CartProvider>(
    //     context,
    //     listen: false,
    //   ).addToCart(CartItem(product: product, selectedSize: size));

    //   ScaffoldMessenger.of(context).clearSnackBars();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       behavior: SnackBarBehavior.floating,
    //       margin: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
    //       content: Text('Product added successfully!'),
    //     ),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).clearSnackBars();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       behavior: SnackBarBehavior.floating,
    //       margin: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
    //       content: Text('Please select size'),
    //     ),
    //   );
    // }

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => CartPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 5, 5),
            child: SizedBox(
              height: 40,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Gradient background for the button
                  Positioned(
                    left: 0,
                    child: Container(
                      width: 156,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF0B3689), Color(0xFF3F92FF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () => _onPress(context),

                        //() {
                        //   Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder:
                        //           (context) =>
                        //               Checkoutform(), //checkoutform----------------------------------
                        //     ),
                        //   );
                        // },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        child: Text(
                          "      Go To Cart",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  // Gradient circle with icon
                  Positioned(
                    left: -15,
                    top: -2,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF0B3689), Color(0xFF3F92FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.shopping_cart,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
            child: SizedBox(
              height: 40,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Gradient background for the button
                  Positioned(
                    left: 0,
                    child: Container(
                      width: 136,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF31B769),
                            Color.fromARGB(255, 113, 249, 169),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (size.isNotEmpty) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    Checkoutform(product: product, size: size),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).clearSnackBars();

                            showThumbsUpDialog(
                              context,
                              'Please select size',
                              isSuccess: false,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        child: Text(
                          "   Buy Now",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  // Gradient circle with icon
                  Positioned(
                    left: -15,
                    top: -2,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF31B769),
                            Color.fromARGB(255, 113, 249, 169),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.ads_click,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
