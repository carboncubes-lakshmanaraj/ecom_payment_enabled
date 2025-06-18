import 'package:ecom_payment/datas/dummydata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ecom_payment/datas/product.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: List.generate(wishlistProducts.length, (index) {
          final product = wishlistProducts[index];
          final isBig = index % 2 == 0;

          return StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: isBig ? 3.2 : 2.5,
            child: _buildWishlistCard(product, isBig: isBig),
          );
        }),
      ),
    );
  }

  Widget _buildWishlistCard(Product product, {required bool isBig}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            product.productImage,
            height: isBig ? 150 : 100,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isBig ? 16 : 13,
            ),
            maxLines: isBig ? 2 : 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            product.productDescrip,
            style: TextStyle(fontSize: isBig ? 13 : 11, color: Colors.grey),
            maxLines: 2, // limit to 2 lines always
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                "₹${product.discountedPrice.toStringAsFixed(0)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: isBig ? 14 : 12,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "₹${product.mrpPrice.toStringAsFixed(0)}",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                  fontSize: isBig ? 13 : 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
