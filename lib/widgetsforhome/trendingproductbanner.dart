import 'package:ecom_payment/datas/dummydata.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

final formattedDate = DateFormat('MMMM dd, yyyy').format(trendingProductDate);
// Output: "May 10, 2025"

class TrendingProductbanner extends StatefulWidget {
  const TrendingProductbanner({super.key});

  @override
  State<TrendingProductbanner> createState() => _TrendingProductbannerState();
}

class _TrendingProductbannerState extends State<TrendingProductbanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Color(0xFFFD6E87),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                ' Trending Products',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.calendar_today, color: Colors.white, size: 12),
                  SizedBox(width: 5),
                  Text(
                    "Last Date $formattedDate ",
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  foregroundColor: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('View all', style: TextStyle(color: Colors.white)),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_right_alt, color: Colors.white, size: 25),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
