import 'package:ecom_payment/datas/product.dart';

class CartItem {
  final Product product;
  final String selectedSize;
  CartItem({required this.product, required this.selectedSize});
}
