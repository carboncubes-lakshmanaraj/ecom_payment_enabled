import 'dart:io';
import 'package:ecom_payment/screens/ordersummary_page_for%20payment.dart';
import 'package:ecom_payment/screens/paymentlogviewpage.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ecom_payment/dbmanager/db.dart';

class OrdersDebugPage extends StatefulWidget {
  const OrdersDebugPage({super.key});

  @override
  State<OrdersDebugPage> createState() => _OrdersDebugPageState();
}

class _OrdersDebugPageState extends State<OrdersDebugPage> {
  late Future<List<Map<String, dynamic>>> _ordersFuture;
  String _searchQuery = '';
  String _statusFilter = 'All';
  String _sortOption = 'Date Desc';

  @override
  void initState() {
    super.initState();
    _refreshOrders();
  }

  void _refreshOrders() {
    setState(() {
      _ordersFuture = _fetchOrders();
    });
  }

  Future<List<Map<String, dynamic>>> _fetchOrders() async {
    final db = await DBManager.database;
    String where = '';
    List<String> whereArgs = [];

    if (_searchQuery.isNotEmpty) {
      where += "Email LIKE ?";
      whereArgs.add('%$_searchQuery%');
    }

    if (_statusFilter != 'All') {
      where += (where.isNotEmpty ? " AND " : "") + "OrderStatus = ?";
      whereArgs.add(_statusFilter);
    }

    String orderBy = _sortOption == 'Amount Desc'
        ? 'TotalPrice DESC'
        : 'OrderDate DESC';

    return db.query(
      'Orders',
      where: where.isNotEmpty ? where : null,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );
  }

  Future<List<Map<String, dynamic>>> _fetchOrderItems(int orderId) async {
    final db = await DBManager.database;
    return db.query('OrderItems', where: 'OrderID = ?', whereArgs: [orderId]);
  }

  Future<void> _clearDatabase() async {
    final db = await DBManager.database;
    await db.delete('OrderItems');
    await db.delete('Orders');

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('All orders cleared!')));
    _refreshOrders();
  }

  Future<void> _exportToCSV() async {
    final orders = await _fetchOrders();
    if (orders.isEmpty) return;

    final List<List<dynamic>> csvData = [
      ['OrderID', 'Email', 'Date', 'Total', 'Status', 'PaymentIntentID'],
    ];

    for (final order in orders) {
      csvData.add([
        order['OrderID'],
        order['Email'],
        order['OrderDate'],
        order['TotalPrice'],
        order['OrderStatus'],
        order['PaymentIntentID'] ?? '',
      ]);
    }

    final csv = const ListToCsvConverter().convert(csvData);

    if (await Permission.storage.request().isGranted) {
      final dir = await getExternalStorageDirectory();
      final file = File('${dir!.path}/orders_export.csv');
      await file.writeAsString(csv);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('CSV exported to: ${file.path}')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Debug View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshOrders,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: _exportToCSV,
            tooltip: 'Export to CSV',
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: _clearDatabase,
            tooltip: 'Clear All Orders',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _ordersFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return const Center(child: CircularProgressIndicator());
                final orders = snapshot.data!;
                if (orders.isEmpty)
                  return const Center(child: Text('No orders found.'));
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                OrderSummaryPage(orderId: order['OrderID']),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ExpansionTile(
                          title: Text(
                            'Order #${order['OrderID']} - ₹${order['TotalPrice']}',
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email: ${order['Email']}'),
                              Text('Status: ${order['OrderStatus']}'),
                              Text('Date: ${order['OrderDate']}'),
                              if (order['PaymentIntentID'] != null)
                                Text(
                                  'PaymentIntentID: ${order['PaymentIntentID']}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                          children: [
                            FutureBuilder<List<Map<String, dynamic>>>(
                              future: _fetchOrderItems(order['OrderID']),
                              builder: (context, itemSnap) {
                                if (!itemSnap.hasData)
                                  return const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: CircularProgressIndicator(),
                                  );
                                final items = itemSnap.data!;
                                return Column(
                                  children: [
                                    ...items.map((item) {
                                      return ListTile(
                                        leading: Image.asset(
                                          item['ProductImage'],
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Text(item['ProductTitle']),
                                        subtitle: Text(
                                          'Size: ${item['SelectedSize']} × ${item['Quantity']}',
                                        ),
                                        trailing: Text('₹${item['Price']}'),
                                      );
                                    }).toList(),
                                    const Divider(),
                                    TextButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                PaymentLogViewerPage(
                                                  orderId: order['OrderID'],
                                                ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.receipt_long),
                                      label: const Text("View Payment Logs"),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Wrap(
        runSpacing: 8,
        spacing: 12,
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by Email',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _searchQuery = value;
                _refreshOrders();
              },
            ),
          ),
          DropdownButton<String>(
            value: _statusFilter,
            items: ['All', 'Pending', 'Paid', 'Failed', 'Cancelled']
                .map(
                  (status) =>
                      DropdownMenuItem(value: status, child: Text(status)),
                )
                .toList(),
            onChanged: (val) {
              if (val != null) {
                _statusFilter = val;
                _refreshOrders();
              }
            },
          ),
          DropdownButton<String>(
            value: _sortOption,
            items: ['Date Desc', 'Amount Desc']
                .map(
                  (sort) =>
                      DropdownMenuItem(value: sort, child: Text('Sort: $sort')),
                )
                .toList(),
            onChanged: (val) {
              if (val != null) {
                _sortOption = val;
                _refreshOrders();
              }
            },
          ),
        ],
      ),
    );
  }
}
