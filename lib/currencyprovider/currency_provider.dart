import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier {
  String _selectedCurrency = "INR";

  String get selectedCurrency => _selectedCurrency;

  void setCurrency(String currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }
}
