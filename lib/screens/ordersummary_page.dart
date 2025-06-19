import 'dart:convert';
import 'package:ecom_payment/dbmanager/db.dart';
import 'package:ecom_payment/screens/orderstable_viewpage.dart';
import 'package:ecom_payment/stripekeys/keys.dart';
import 'package:flutter/material.dart';
import 'package:ecom_payment/repositories/order_repository.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class OrderSummaryPage extends StatefulWidget {
  final int orderId;
  const OrderSummaryPage({super.key, required this.orderId});

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  late Future<Map<String, dynamic>> orderData;
  Map<String, dynamic>? intentPaymentData;

  @override
  void initState() {
    super.initState();
    orderData = OrderRepository.getOrderWithItems(widget.orderId);
  }

  void _refreshOrder() {
    setState(() {
      orderData = OrderRepository.getOrderWithItems(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: orderData,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(title: const Text("Order Summary")),
            body: const Center(
              child: Text("Order not found.", style: TextStyle(fontSize: 18)),
            ),
          );
        }

        final order = snapshot.data!['order'];
        final items = snapshot.data!['items'];
        double amount = order['TotalPrice'];

        return Scaffold(
          appBar: AppBar(title: Text("Order #${order['OrderID']}")),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final shouldRefresh = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrdersDebugPage()),
              );
              if (shouldRefresh == true) _refreshOrder();
            },
            child: const Icon(Icons.table_chart),
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email: ${order['Email']}"),
                      Text("Total: ₹${order['TotalPrice']}"),
                      Text("Order Date: ${order['OrderDate']}"),
                      Text("Status: ${order['OrderStatus']}"),
                      const Divider(),
                      const Text(
                        "Items:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (ctx, i) => ListTile(
                            leading: Image.asset(
                              items[i]['ProductImage'],
                              width: 50,
                            ),
                            title: Text(items[i]['ProductTitle']),
                            subtitle: Text("Size: ${items[i]['SelectedSize']}"),
                            trailing: Text("₹${items[i]['Price']}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    paymentSheetInitialization(amount, "INR");
                  },
                  child: Text(
                    "Pay Now ₹${order['TotalPrice']}",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> paymentSheetInitialization(
    double amount,
    String currency,
  ) async {
    try {
      intentPaymentData = await makeIntentForPayment(amount, currency);
      if (intentPaymentData == null) return;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          paymentIntentClientSecret: intentPaymentData!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: "Carboncubes",
        ),
      );

      await showPaymentSheet();
    } catch (e) {
      debugPrint("Stripe Init Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment failed to initialize.")),
      );
    }
  }

  Future<Map<String, dynamic>?> makeIntentForPayment(
    double amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> paymentinfo = {
        "amount": (amount * 100).toInt().toString(),
        "currency": currency,
        "payment_method_types[]": "card",
      };

      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: paymentinfo,
        headers: {
          "Authorization": "Bearer $secretkey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      debugPrint("Stripe API response: ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      showDialog(
        context: context,
        builder: (c) => AlertDialog(content: Text("Error: ${e.toString()}")),
      );
      return null;
    }
  }

  Future<void> showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await OrderRepository.updateOrderStatus(widget.orderId, "Paid");
      _refreshOrder();
      intentPaymentData = null;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Payment successful!")));
    } on StripeException {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Payment cancelled.")));
    } catch (e) {
      showDialog(
        context: context,
        builder: (c) => AlertDialog(content: Text("Payment error: $e")),
      );
    }
  }
}
