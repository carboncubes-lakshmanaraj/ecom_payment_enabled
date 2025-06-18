// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SizeChartWidget extends StatefulWidget {
  final String subCategory;
  final ValueChanged<String?> onSizeSelected; // <-- callback

  const SizeChartWidget({
    Key? key,
    required this.subCategory,
    required this.onSizeSelected,
  }) : super(key: key);

  @override
  State<SizeChartWidget> createState() => _SizeChartWidgetState();
}

class _SizeChartWidgetState extends State<SizeChartWidget> {
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    final sizes = _getSizes(widget.subCategory);

    if (sizes.isEmpty) return SizedBox.shrink(); // Don't show if no sizes

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          _selectedSize != null
              ? "Selected Size: $_selectedSize"
              : "Please select a size",

          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: sizes
              .map(
                (size) => ChoiceChip(
                  label: Text(size),
                  selected: _selectedSize == size,
                  onSelected: (selected) {
                    setState(() {
                      _selectedSize = selected ? size : null;
                      widget.onSizeSelected(_selectedSize); // Notify parent
                    });
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  List<String> _getSizes(String subCategory) {
    switch (subCategory.toLowerCase()) {
      case 'footwear':
        return ['6 UK', '7 UK', '8 UK', '9 UK', '10 UK'];
      case 'dress':
        return ['S', 'M', 'L', 'XL'];
      default:
        return ['Free Size'];
    }
  }
}
