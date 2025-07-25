import 'package:ecom_payment/alertdialog/dialog_box_time.dart';
import 'package:ecom_payment/currencyprovider/currency_provider.dart';
import 'package:ecom_payment/datas/product.dart';
import 'package:ecom_payment/repositories/order_repository.dart';
import 'package:ecom_payment/screens/ordersummary_page_for%20payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecom_payment/datas/cartitem.dart';
import 'package:ecom_payment/cartprovider/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cart;
    final selectedCurrency = context.watch<CurrencyProvider>().selectedCurrency;
    final currencySymbol = getCurrencySymbol(selectedCurrency);
    final total = cartItems.fold<double>(
      0.0,
      (sum, item) => sum + getDiscountedPrice(item.product, selectedCurrency),
    );

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
                return CartItemTile(
                  cartItem: cartItem,
                  selectedCurrency: selectedCurrency,
                );
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
                        'Currency type:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${selectedCurrency}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
                        '$currencySymbol${total.toStringAsFixed(2)}',
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
                                    showThumbsUpDialog(
                                      context,
                                      "Please enter a valid email",
                                      isSuccess: false,
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
                        selectedcurrency: selectedCurrency!,
                        email: email,
                        cartItems: cartItems,
                      );

                      // Step 3: Clear cart and go to summary page
                      cartProvider.clearCart();

                      Navigator.push(
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
  final String? selectedCurrency;
  const CartItemTile({
    Key? key,
    required this.cartItem,
    required this.selectedCurrency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencySymbol = getCurrencySymbol(selectedCurrency);
    final discountedPrice = getDiscountedPrice(
      cartItem.product,
      selectedCurrency,
    );

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
          Text('$currencySymbol${discountedPrice.toStringAsFixed(2)}'),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          Provider.of<CartProvider>(
            context,
            listen: false,
          ).removeFromCart(cartItem);

          showThumbsUpDialog(
            context,
            '${cartItem.product.title} removed from cart',
            isSuccess: true,
          );
        },
      ),
    );
  }
}

String getCurrencySymbol(String? currencyId) {
  switch (currencyId) {
    case "INR":
      return "₹";
    case "USD":
      return "\$";
    case "GBP":
      return "£";
    default:
      return "";
  }
}

double getProductPrice(Product product, String? currencyId) {
  if (currencyId == null || currencyId == "INR") {
    return product.mrpPrice;
  }

  final price = product.priceFor(currencyId);
  return price ?? product.mrpPrice;
}

double getDiscountedPrice(Product product, String? currencyId) {
  final price = getProductPrice(product, currencyId);
  return price * (1 - (product.percentageOff / 100));
}
