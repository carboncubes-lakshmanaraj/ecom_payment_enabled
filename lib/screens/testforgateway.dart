import 'dart:async';

import 'package:ecom_payment/widgetfortestgateway/containeraccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ecom_payment/datas/product.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int _currentDot = 0;
  Timer? _timer;

  void _showLoadingDialog() {
    _currentDot = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!mounted) return;
      setState(() {
        _currentDot = (_currentDot + 1) % 3;
      });
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 280,
            height: 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/tick.png", // Replace with your actual image
                  width: 160,
                  height: 160,
                ),

                Text("Payment done successfully."),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _timer?.cancel();
        Navigator.of(context).pop(); // Dismiss the dialog
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(color: Color(0xFFC6C6C6), thickness: 1, height: 1),
          ),
          title: const Text(
            'Checkout',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Order'),
                  const Spacer(),
                  Text(widget.product.discountedPrice.toStringAsFixed(2)),
                ],
              ),
              Row(children: const [Text('Shipping'), Spacer(), Text("30")]),
              Row(
                children: [
                  const Text('Total'),
                  const Spacer(),
                  Text(
                    (widget.product.discountedPrice + 30).toStringAsFixed(2),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(),
              const Text("Payment"),
              const SizedBox(height: 20),

              /// ✅ Fixed the layout issue here
              Expanded(child: SelectableImageContainers()),

              const SizedBox(height: 20),

              /// ✅ Button triggers dialog
              SizedBox(
                width: 310,
                height: 60,
                child: ElevatedButton(
                  onPressed: _showLoadingDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF83758),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
