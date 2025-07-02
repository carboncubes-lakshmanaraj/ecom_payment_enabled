import 'package:ecom_payment/dbmanager/util/sharedb.dart';
import 'package:flutter/material.dart';

class Sharedb extends StatefulWidget {
  const Sharedb({super.key});

  @override
  State<Sharedb> createState() => _SharedbState();
}

class _SharedbState extends State<Sharedb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Share DB")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await ShareUtil.shareDatabase();
          },
          child: Text("Share Database"),
        ),
      ),
    );
  }
}
