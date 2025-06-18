import 'package:ecom_payment/repositories/order_repository.dart';
import 'package:ecom_payment/screens/ordersummary_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecom_payment/datas/cartitem.dart';
import 'package:ecom_payment/cartprovider/cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cart;

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return CartItemTile(cartItem: cartItem);
              },
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₹${cartProvider.grandTotal.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      final cartProvider = Provider.of<CartProvider>(
                        context,
                        listen: false,
                      );
                      final cartItems = cartProvider.cart;

                      // Step 1: Show dialog to get email
                      String? email = await showDialog<String>(
                        context: context,
                        builder: (context) {
                          TextEditingController emailController =
                              TextEditingController();

                          return AlertDialog(
                            title: Text('Enter Email to Checkout'),
                            content: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'you@example.com',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, null),
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  String enteredEmail = emailController.text
                                      .trim();
                                  if (enteredEmail.isNotEmpty &&
                                      enteredEmail.contains('@')) {
                                    Navigator.pop(context, enteredEmail);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Please enter a valid email",
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Text('Proceed'),
                              ),
                            ],
                          );
                        },
                      );

                      // If cancelled or invalid email
                      if (email == null) return;

                      // Step 2: Save order
                      final orderId = await OrderRepository.createOrder(
                        email: email,
                        cartItems: cartItems,
                      );

                      // Step 3: Clear cart and go to summary page
                      cartProvider.clearCart();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrderSummaryPage(orderId: orderId),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF83758),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Proceed to Checkout',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;

  const CartItemTile({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(8),
      leading: Image.asset(
        cartItem.product.productImage,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
      title: Text(cartItem.product.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Size: ${cartItem.selectedSize}'),
          Text('₹${cartItem.product.discountedPrice.toStringAsFixed(0)}'),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          Provider.of<CartProvider>(
            context,
            listen: false,
          ).removeFromCart(cartItem);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 80, left: 20, right: 20),
              content: Text('${cartItem.product.title} removed from cart'),
            ),
          );
        },
      ),
    );
  }
}
