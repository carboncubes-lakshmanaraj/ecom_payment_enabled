import 'package:ecom_payment/alertdialog/dialkogbox_instead_of_scaffold.dart';
import 'package:ecom_payment/alertdialog/dialog_box_time.dart';
import 'package:ecom_payment/cartprovider/cart_provider.dart';
import 'package:ecom_payment/datas/cartitem.dart';
import 'package:ecom_payment/datas/categoryandsubcat.dart';
import 'package:ecom_payment/widgetsfordescription/deliverywithin.dart';
import 'package:ecom_payment/widgetsfordescription/nearest_refundpolicy_vip.dart';
import 'package:ecom_payment/widgetsfordescription/paradescrip.dart';
import 'package:ecom_payment/widgetsfordescription/piccarosole.dart';
import 'package:ecom_payment/widgetsfordescription/sizes.dart';
import 'package:ecom_payment/widgetsfordescription/gotocartorbuynowbutton.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ecom_payment/datas/dummydata.dart';
import 'package:ecom_payment/datas/product.dart';
import 'package:ecom_payment/widgetsfordescription/similarproductlist.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final String? selectedCurrency;

  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.selectedCurrency,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String? _selectedSize;

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

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final allImages = product.additionalImages!;
    final subCategory = subCategories.firstWhere(
      (sc) => sc.id == product.subCategoryId,
      orElse: () => SubCategory(id: 0, title: ''),
    );

    final currencyId = widget.selectedCurrency ?? "INR";
    final currencySymbol = getCurrencySymbol(currencyId);

    double priceToUse = widget.product.mrpPrice;
    final currencyPrice = widget.product.priceFor(currencyId);
    if (currencyPrice != null) {
      priceToUse = currencyPrice;
    }

    final discountedPrice =
        priceToUse * (1 - (widget.product.percentageOff / 100));

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                final sSize = _selectedSize ?? '';

                if (sSize.isNotEmpty) {
                  final cartProvider = Provider.of<CartProvider>(
                    context,
                    listen: false,
                  );
                  final alreadyInCart = cartProvider.cart.any(
                    (item) =>
                        item.product.title == product.title &&
                        item.selectedSize == sSize,
                  );

                  ScaffoldMessenger.of(context).clearSnackBars();

                  if (alreadyInCart) {
                    showThumbsUpDialog(
                      context,
                      'Product already exists in cart!',
                      isSuccess: false,
                    );
                  } else {
                    cartProvider.addToCart(
                      CartItem(product: product, selectedSize: sSize),
                    );

                    showThumbsUpDialog(
                      context,
                      'Product added successfully',
                      isSuccess: true,
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).clearSnackBars();

                  showThumbsUpDialog(
                    context,
                    'Please select size',
                    isSuccess: false,
                  );
                }
              },

              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200, // background color
                ),
                padding: EdgeInsets.all(8), // adjust as needed
                child: Icon(Icons.shopping_cart, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductpicCar(allimages: allImages),
              // if (subCategory.title.toLowerCase() == 'footwear' ||
              //     subCategory.title.toLowerCase() == 'dress')
              SizeChartWidget(
                subCategory: subCategory.title,
                onSizeSelected: (size) {
                  setState(() {
                    _selectedSize = size;
                  });
                },
              ),

              const SizedBox(height: 16),
              Text(
                product.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(product.productDescrip, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "$currencySymbol${discountedPrice.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "$currencySymbol${priceToUse.toStringAsFixed(2)}",
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "-${product.percentageOff.toStringAsFixed(0)}% OFF",
                style: TextStyle(color: Colors.red),
              ),
              TextExpandableWidget(text: product.moreinfo),
              const SizedBox(height: 16),
              NearestRefundpolicyVip(),
              ButtonBuynowGotoCart(
                size: _selectedSize ?? '',
                selectedCurrency: widget
                    .selectedCurrency, // or pass directly from SizeChartWidget
                product: product,
              ),
              Deliverywithin(),
              // Container(
              //   height: 330,
              //   child: SimilarProductsHorizontalList(
              //     currentProduct: product,
              //     allProducts: dummyProducts,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
