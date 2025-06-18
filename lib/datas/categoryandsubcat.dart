import 'package:flutter/material.dart';

class Category {
  Category({required this.id, required this.title, required this.image});
  final int id; // Refer by ID
  final String title;
  final String image; // Path to image asset or network URL
}

class SubCategory {
  SubCategory({required this.id, required this.title});
  final int id;
  final String title; // e.g. Footwear, Dress, Electronics, Accessories
}
