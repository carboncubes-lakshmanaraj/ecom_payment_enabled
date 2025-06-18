import 'package:ecom_payment/datas/dummydata.dart';
import 'package:flutter/material.dart';

class SortedandFilteredWL extends StatelessWidget {
  const SortedandFilteredWL({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text("${wishlistProducts.length.toString()} items"),
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  12,
                ), // Adjust corner radius here
              ),
              backgroundColor: Colors.white, // Optional background color
              foregroundColor: Colors.black, // Text & icon color
            ),
            onPressed: () {
              // Your action
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Sort'),
                SizedBox(width: 8), // spacing between text and icon
                Transform.rotate(
                  angle: 90 * 3.1416 / 180, // 90 degrees in radians
                  child: Icon(Icons.compare_arrows_outlined),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  12,
                ), // Adjust corner radius here
              ),
              backgroundColor: Colors.white, // Optional background color
              foregroundColor: Colors.black, // Text & icon color
            ),
            onPressed: () {
              // Your action
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Filter'),
                SizedBox(width: 8), // spacing between text and icon
                Icon(Icons.filter_alt),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
