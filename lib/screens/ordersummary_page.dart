import 'package:ecom_payment/dbmanager/db.dart';
import 'package:ecom_payment/screens/orderstable_viewpage.dart';
import 'package:flutter/material.dart';
import 'package:ecom_payment/repositories/order_repository.dart';

class OrderSummaryPage extends StatefulWidget {
  final int orderId;

  const OrderSummaryPage({super.key, required this.orderId});

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  late Future<Map<String, dynamic>> orderData;

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

  void _handlePayNow(Map<String, dynamic> order) {
    // ✅ Placeholder for Paytm integration
    // You would typically call a method to invoke the Paytm SDK or open a payment screen here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Initiating payment for ₹${order['TotalPrice']}")),
    );
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

              /// 🔻 Bottom fixed button
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
                  onPressed: () => _handlePayNow(order),
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
}
