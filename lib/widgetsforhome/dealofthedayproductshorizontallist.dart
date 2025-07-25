// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ecom_payment/datas/product.dart';
import 'package:ecom_payment/screens/productdetailpage.dart';

class HorizontalListWithButtons extends StatefulWidget {
  final List<Product> products;
  final String? selectedCurrency;

  HorizontalListWithButtons({
    Key? key,
    required this.products,
    required this.selectedCurrency,
  }) : super(key: key);

  @override
  _HorizontalListWithButtonsState createState() =>
      _HorizontalListWithButtonsState();
}

class _HorizontalListWithButtonsState extends State<HorizontalListWithButtons> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollAmount = 200.0;
  bool _canScrollLeft = false;
  bool _canScrollRight = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollButtonVisibility);
  }

  @override
  void didUpdateWidget(covariant HorizontalListWithButtons oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCurrency != widget.selectedCurrency) {
      setState(() {
        // force rebuild to reflect currency change
      });
    }
  }

  void _updateScrollButtonVisibility() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentOffset = _scrollController.offset;

    setState(() {
      _canScrollLeft = currentOffset > 0;
      _canScrollRight = currentOffset < maxScroll;
    });
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      (_scrollController.offset - _scrollAmount).clamp(
        0,
        _scrollController.position.maxScrollExtent,
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      (_scrollController.offset + _scrollAmount).clamp(
        0,
        _scrollController.position.maxScrollExtent,
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  String getCurrencySymbol(String? currencyId) {
    switch (currencyId) {
      case "INR":
        return "₹";
      case "USD":
        return "\$";
      case "GBP":
        return "£";
      default:
        return "";
    }
  }

  Widget _buildProductItem(Product product) {
    final currencyId = widget.selectedCurrency ?? "INR";
    final currencySymbol = getCurrencySymbol(currencyId);

    // Try to get price from selected currency
    double priceToUse = product.mrpPrice;
    final currencyPrice = product.priceFor(currencyId);

    if (currencyPrice != null) {
      priceToUse = currencyPrice;
    }

    final discountedPrice = priceToUse * (1 - (product.percentageOff / 100));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsPage(
              product: product,
              selectedCurrency: widget.selectedCurrency,
            ),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.productImage.isNotEmpty
                  ? product.productImage
                  : "assets/placeholder.png",
              height: 130,
              width: 200,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 8),
            Text(
              product.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              product.productDescrip,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  "$currencySymbol${discountedPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  "$currencySymbol${priceToUse.toStringAsFixed(2)}",
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  "-${product.percentageOff.toStringAsFixed(0)}%",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  size: 16,
                  color: index < 4 ? Colors.orange : Colors.grey[300],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollButtonVisibility);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dealsOfTheDay = widget.products
        .where((p) => p.dealsOfTheDay)
        .toList();

    if (dealsOfTheDay.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(child: Text("No deals of the day available.")),
      );
    }

    return Stack(
      children: [
        Positioned.fill(
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: dealsOfTheDay.length,
            itemBuilder: (context, index) =>
                _buildProductItem(dealsOfTheDay[index]),
          ),
        ),
        if (_canScrollLeft)
          Align(
            alignment: Alignment.centerLeft,
            child: FloatingActionButton.small(
              heroTag: 'back_dealoftheday_${hashCode}',
              onPressed: _scrollLeft,
              child: Icon(Icons.arrow_back),
              tooltip: 'Scroll Left',
            ),
          ),
        if (_canScrollRight)
          Align(
            alignment: Alignment.centerRight,
            child: FloatingActionButton.small(
              heroTag: 'front_dealoftheday_${hashCode}',
              onPressed: _scrollRight,
              child: Icon(Icons.arrow_forward),
              tooltip: 'Scroll Right',
            ),
          ),
      ],
    );
  }
}
