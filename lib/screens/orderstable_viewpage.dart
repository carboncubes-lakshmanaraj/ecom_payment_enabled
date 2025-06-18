import 'package:flutter/material.dart';
import 'package:ecom_payment/dbmanager/db.dart';

class OrdersDebugPage extends StatelessWidget {
  const OrdersDebugPage({super.key});

  Future<List<Map<String, dynamic>>> _fetchOrders() async {
    final db = await DBManager.database;
    return db.query('Orders');
  }

  Future<List<Map<String, dynamic>>> _fetchOrderItems(int orderId) async {
    final db = await DBManager.database;
    return db.query('OrderItems', where: 'OrderID = ?', whereArgs: [orderId]);
  }

  Future<void> _clearDatabase(BuildContext context) async {
    final db = await DBManager.database;

    await db.delete('OrderItems');
    await db.delete('Orders');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All orders and items cleared!'),
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Force widget to rebuild after clearing
    (context as Element).reassemble();

    // Go back to previous screen and signal a refresh
    Navigator.pop(context, true); // 👈 return true to trigger refresh
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders & Items Viewer')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _clearDatabase(context),
        backgroundColor: Colors.red,
        tooltip: 'Clear All Data',
        child: const Icon(Icons.delete),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!;
          if (orders.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return ExpansionTile(
                title: Text(
                  'Order #${order['OrderID']} - ₹${order['TotalPrice']}',
                ),
                subtitle: Text('Email: ${order['Email']}'),
                children: [
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _fetchOrderItems(order['OrderID']),
                    builder: (ctx, snap) {
                      if (!snap.hasData) {
                        return const CircularProgressIndicator();
                      }

                      final items = snap.data!;
                      return Column(
                        children: items.map((item) {
                          return ListTile(
                            leading: Image.asset(
                              item['ProductImage'],
                              width: 40,
                            ),
                            title: Text(item['ProductTitle']),
                            subtitle: Text("Size: ${item['SelectedSize']}"),
                            trailing: Text("₹${item['Price']}"),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
