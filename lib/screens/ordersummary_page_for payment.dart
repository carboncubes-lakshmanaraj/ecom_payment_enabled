import 'dart:convert';
import 'package:ecom_payment/alertdialog/dialog_box_time.dart';
import 'package:ecom_payment/datas/paymentlog.dart';
import 'package:ecom_payment/dbmanager/db.dart';
import 'package:ecom_payment/repositories/paymentlog_repo.dart';
import 'package:ecom_payment/screens/orders_table_full%20_history_viewpage.dart';
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
  bool _isLoading = false;
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
            appBar: AppBar(
              title: const Text("Order Summary"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: const Center(
              child: Text("Order not found.", style: TextStyle(fontSize: 18)),
            ),
          );
        }

        final order = snapshot.data!['order'];
        final items = snapshot.data!['items'];
        double amount = order['TotalPrice'];
        final currencyId = order['CurrencyID'];
        final currencySymbol = getCurrencySymbol(currencyId);

        return Scaffold(
          appBar: AppBar(
            title: Text("Order #${order['OrderID']}"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
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
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email: ${order['Email']}"),
                          Text(
                            "Total: $currencySymbol${order['TotalPrice'].toStringAsFixed(2)}",
                          ),
                          Text("Order Date: ${order['OrderDate']}"),
                          Text("Status: ${order['OrderStatus']}"),
                          Text("Currency: ${order['CurrencyID']}"),
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
                                subtitle: Text(
                                  "Size: ${items[i]['SelectedSize']}",
                                ),
                                trailing: Text(
                                  " $currencySymbol${(items[i]['Price'] as num).toStringAsFixed(2)}",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_isLoading)
                        Container(
                          color: Colors.black.withOpacity(0.5),
                          child: const Center(
                            child: CircularProgressIndicator(),
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
                  onPressed: order['OrderStatus'] == 'Paid'
                      ? null
                      : () {
                          _showPaymentOptionsDialog(amount, currencyId);
                        },

                  child: Text(
                    order['OrderStatus'] == 'Paid'
                        ? "Already Paid"
                        : "Pay Now  $currencySymbol${order['TotalPrice'].toStringAsFixed(2)}",
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

      showThumbsUpDialog(
        context,
        "Payment failed to initialize.",
        isSuccess: false,
      );
    }
  }

  Future<Map<String, dynamic>?> makeIntentForPayment(
    double amount,
    String currency,
  ) async {
    try {
      final snapshot = await orderData;
      final customerEmail = snapshot['order']['Email'];
      final orderId = snapshot['order']['OrderID'];

      // 1. Reuse existing intent if saved locally
      final existingIntentId = await OrderRepository.getPaymentIntentId(
        orderId,
      );
      if (existingIntentId != null) {
        final existingResponse = await http.get(
          Uri.parse(
            "https://api.stripe.com/v1/payment_intents/$existingIntentId",
          ),
          headers: {"Authorization": "Bearer $secretkey"},
        );

        final existingData = jsonDecode(existingResponse.body);
        if (existingData['status'] == 'succeeded') {
          // Update local DB if needed
          await OrderRepository.updateOrderStatus(orderId, "Paid");

          showThumbsUpDialog(
            context,
            "Recovered: Payment already completed.",
            isSuccess: true,
          );

          _refreshOrder();
          return null;
        } else {
          return existingData;
        }
      }

      // 2. Fallback: Check Stripe by metadata
      final metadataCheck = await fetchPaymentIntentByMetadata(orderId);
      if (metadataCheck != null) {
        if (metadataCheck['status'] == 'succeeded') {
          // Save for future and update status
          await OrderRepository.savePaymentIntentId(
            orderId,
            metadataCheck['id'],
          );
          await OrderRepository.updateOrderStatus(orderId, "Paid");

          showThumbsUpDialog(
            context,
            "Recovered: Payment already completed.",
            isSuccess: true,
          );

          _refreshOrder();
          return null;
        } else {
          // Save for reuse
          await OrderRepository.savePaymentIntentId(
            orderId,
            metadataCheck['id'],
          );
          return metadataCheck;
        }
      }

      // 3. Create new PaymentIntent (safe with Idempotency-Key)
      final Map<String, String> paymentinfo = {
        "amount": (amount * 100).round().toString(),
        "currency": currency,
        "payment_method_types[]": "card",
        "receipt_email": customerEmail,
        "description": "Payment for Order #$orderId",
        "metadata[order_id]": orderId.toString(),
        "metadata[email]": customerEmail,
      };

      debugPrint("🔁 Creating new PaymentIntent:");
      paymentinfo.forEach((k, v) => debugPrint('$k = $v'));

      await PaymentLogRepository.insertLog(
        PaymentLog(
          orderId: orderId,
          direction: 'sent',
          payload: jsonEncode(paymentinfo),
          createdAt: DateTime.now().toIso8601String(),
        ),
      );
      final idempotencyKey = await OrderRepository.ensureIdempotencyKey(
        orderId,
      );
      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: paymentinfo,
        headers: {
          "Authorization": "Bearer $secretkey",
          "Content-Type": "application/x-www-form-urlencoded",
          "Idempotency-Key": idempotencyKey, // 💡 Prevents duplicates
        },
      );

      final intentData = jsonDecode(response.body);
      await PaymentLogRepository.insertLog(
        PaymentLog(
          orderId: orderId,
          direction: 'received',
          payload: response.body,
          createdAt: DateTime.now().toIso8601String(),
        ),
      );

      if (intentData['error'] != null) {
        throw Exception("Stripe Error: ${intentData['error']['message']}");
      }

      await OrderRepository.savePaymentIntentId(orderId, intentData['id']);
      return intentData;
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

      showThumbsUpDialog(context, "Payment successful!", isSuccess: true);
    } on StripeException {
      showThumbsUpDialog(context, "Payment cancelled.", isSuccess: false);
    } catch (e) {
      showDialog(
        context: context,
        builder: (c) => AlertDialog(content: Text("Payment error: $e")),
      );
    }
  }

  Future<Map<String, dynamic>?> fetchPaymentIntentByMetadata(
    int orderId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.stripe.com/v1/payment_intents?limit=5&metadata[order_id]=$orderId",
        ),
        headers: {"Authorization": "Bearer $secretkey"},
      );

      final data = jsonDecode(response.body);
      final intents = data['data'];

      if (intents != null && intents.isNotEmpty) {
        return intents.first; // Return most recent match
      }
    } catch (e) {
      debugPrint("Stripe metadata fetch failed: $e");
    }
    return null;
  }

  void _showPaymentOptionsDialog(double amount, String currencyId) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pay ${getCurrencySymbol(currencyId)}${amount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Image.asset('assets/icons/stripe.png', width: 30),
              title: const Text('Pay with Stripe'),
              onTap: () async {
                Navigator.pop(context);
                setState(() => _isLoading = true);
                await paymentSheetInitialization(amount, currencyId);
                setState(() => _isLoading = false);
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/paytm.png', width: 30),
              title: const Text('Pay with Paytm'),
              onTap: () async {
                Navigator.pop(context);
                setState(() => _isLoading = true);
                _startPaytmFlow(); // when implemented
                setState(() => _isLoading = false);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _startPaytmFlow() {}
}
