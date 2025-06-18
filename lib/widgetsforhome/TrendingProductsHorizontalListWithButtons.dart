import 'package:ecom_payment/screens/productdetailpage.dart';
import 'package:flutter/material.dart';
import 'package:ecom_payment/datas/product.dart'; // Make sure this import is correct

class TrendingProductsHorizontalListWithButtons extends StatefulWidget {
  final List<Product> products;

  TrendingProductsHorizontalListWithButtons({required this.products});

  @override
  _TrendingProductsHorizontalListWithButtonsState createState() =>
      _TrendingProductsHorizontalListWithButtonsState();
}

class _TrendingProductsHorizontalListWithButtonsState
    extends State<TrendingProductsHorizontalListWithButtons> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollAmount = 200.0;
  bool _canScrollLeft = false;
  bool _canScrollRight = true;

  late List<Product> trendingProducts;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollButtonVisibility);
    trendingProducts = widget.products
        .where((p) => p.trendingProducts)
        .toList();
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

  Widget _buildProductItem(Product product) {
    return GestureDetector(
      //capture click and pass data .
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsPage(product: product),
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
              product.productImage,
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
                  "₹${product.discountedPrice.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  "₹${product.mrpPrice.toStringAsFixed(0)}",
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
                ); // dummy 4-star
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
    return Stack(
      children: [
        Positioned.fill(
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: trendingProducts.length,
            itemBuilder: (context, index) =>
                _buildProductItem(trendingProducts[index]),
          ),
        ),
        if (_canScrollLeft)
          Align(
            alignment: Alignment.centerLeft,
            child: FloatingActionButton.small(
              heroTag: 'back_trendingproduct',
              onPressed: _scrollLeft,
              child: Icon(Icons.arrow_back),
              tooltip: 'Scroll Left',
            ),
          ),
        if (_canScrollRight)
          Align(
            alignment: Alignment.centerRight,
            child: FloatingActionButton.small(
              heroTag: 'front_trendingproduct',
              onPressed: _scrollRight,
              child: Icon(Icons.arrow_forward),
              tooltip: 'Scroll Right',
            ),
          ),
      ],
    );
  }
}
