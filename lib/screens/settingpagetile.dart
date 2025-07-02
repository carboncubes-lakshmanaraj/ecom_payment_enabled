import 'package:ecom_payment/screens/orders_table_full%20_history_viewpage.dart';
import 'package:ecom_payment/screens/sharedb.dart';
import 'package:flutter/material.dart';

class Settingpagetile extends StatelessWidget {
  final List<_Feature> features = [
    _Feature(title: "order debug page", page: OrdersDebugPage()),
    _Feature(title: "share db categories", page: Sharedb()),
    // _Feature(title: "Notifications", page: NotificationsPage()),
    // _Feature(title: "About", page: AboutPage()),
  ];

  Settingpagetile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: ListView.builder(
        itemCount: features.length,
        itemBuilder: (context, index) {
          final feature = features[index];
          return ListTile(
            title: Text(feature.title),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => feature.page),
              );
            },
          );
        },
      ),
    );
  }
}

class _Feature {
  final String title;
  final Widget page;
  _Feature({required this.title, required this.page});
}
