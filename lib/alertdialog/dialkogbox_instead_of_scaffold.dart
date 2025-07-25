import 'package:flutter/material.dart';

class ThumbsUpDialog extends StatelessWidget {
  final String message;
  final bool isSuccess;

  const ThumbsUpDialog({
    super.key,
    required this.message,
    this.isSuccess = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSuccess ? Icons.thumb_up : Icons.thumb_down,
            size: 64,
            color: isSuccess ? Colors.green : Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
