import 'package:flutter/material.dart';

class Deliverywithin extends StatelessWidget {
  const Deliverywithin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 78,
      decoration: BoxDecoration(
        color: Color(0xFFFFCCD5), // Pinkish color
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ), // Rounded rectangle
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery in ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              "1 within Hour",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
