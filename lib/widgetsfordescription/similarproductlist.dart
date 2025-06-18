import 'package:flutter/material.dart';
import 'package:ecom_payment/datas/product.dart'; // Adjust path as needed

class SimilarProductsHorizontalList extends StatefulWidget {
  final Product currentProduct;
  final List<Product> allProducts;

  SimilarProductsHorizontalList({
    required this.currentProduct,
    required this.allProducts,
  });

  @override
  _SimilarProductsHorizontalListState createState() =>
      _SimilarProductsHorizontalListState();
}

class _SimilarProductsHorizontalListState
    extends State<SimilarProductsHorizontalList> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollAmount = 200.0;
  bool _canScrollLeft = false;
  bool _canScrollRight = true;

  late List<Product> similarProducts;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollButtonVisibility);

    // Filter: same subcategory but not the current product
    similarProducts = widget.allProducts
        .where(
          (p) =>
              p.subCategoryId == widget.currentProduct.subCategoryId &&
              p != widget.currentProduct,
        )
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
    return Container(
      width: 200,

      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
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
            fit: BoxFit.cover,
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
              ); // Dummy 4-star
            }),
          ),
        ],
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
    if (similarProducts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("No similar products found."),
      );
    }

    return Stack(
      children: [
        Positioned.fill(
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: similarProducts.length,
            itemBuilder: (context, index) =>
                _buildProductItem(similarProducts[index]),
          ),
        ),
        if (_canScrollLeft)
          Align(
            alignment: Alignment.centerLeft,
            child: FloatingActionButton.small(
              heroTag: 'scroll_left_similar',
              onPressed: _scrollLeft,
              child: Icon(Icons.arrow_back),
              tooltip: 'Scroll Left',
            ),
          ),
        if (_canScrollRight)
          Align(
            alignment: Alignment.centerRight,
            child: FloatingActionButton.small(
              heroTag: 'scroll_right_similar',
              onPressed: _scrollRight,
              child: Icon(Icons.arrow_forward),
              tooltip: 'Scroll Right',
            ),
          ),
      ],
    );
  }
}
