import 'package:flutter/material.dart';

class NearestRefundpolicyVip extends StatelessWidget {
  const NearestRefundpolicyVip({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('nearest store')));
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            foregroundColor: Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, color: Colors.grey, size: 10),
              SizedBox(width: 5),
              Text(
                'Nearest Store',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
        ),
        SizedBox(width: 5),
        OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('vip')));
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            foregroundColor: Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lock, color: Colors.grey, size: 10),
              SizedBox(width: 5),
              Text('VIP', style: TextStyle(color: Colors.grey, fontSize: 10)),
            ],
          ),
        ),
        SizedBox(width: 5),
        OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('refund policy ')));
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            foregroundColor: Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.replay_circle_filled_rounded,
                color: Colors.grey,
                size: 10,
              ),
              SizedBox(width: 5),
              Text(
                'Refund Policy',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
