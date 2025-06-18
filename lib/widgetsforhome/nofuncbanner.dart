import 'package:flutter/material.dart';

class NofuncBanner extends StatelessWidget {
  const NofuncBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Image.asset('assets/offnofuncban.png'),
          SizedBox(width: 15),
          SizedBox(
            width: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Special Offers"),
                SizedBox(height: 5),
                Text("We make sure you get the offer you need at best prices"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
