import 'package:ecom_payment/alertdialog/dialkogbox_instead_of_scaffold.dart';
import 'package:flutter/material.dart';

void showThumbsUpDialog(
  BuildContext context,
  String message, {
  bool isSuccess = true,
  Duration duration = const Duration(seconds: 2),
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      Future.delayed(duration, () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
      return ThumbsUpDialog(message: message, isSuccess: isSuccess);
    },
  );
}
