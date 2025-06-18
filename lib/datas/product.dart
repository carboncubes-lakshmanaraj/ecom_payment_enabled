// ignore_for_file: public_member_api_docs, sort_constructors_first

class Product {
  Product({
    required this.title,
    required this.moreinfo,
    required this.productDescrip,
    required this.mrpPrice,
    required this.percentageOff,
    required this.categoryIds,
    required this.dealsOfTheDay,
    required this.trendingProducts,
    required this.productImage,
    required this.subCategoryId,
    this.additionalImages, // optional
  });

  final String title;
  final String moreinfo;
  final String productDescrip;
  final double mrpPrice;
  final double percentageOff;
  final List<int> categoryIds;
  final bool dealsOfTheDay;
  final bool trendingProducts;
  final String productImage;
  final int subCategoryId;
  final List<String>? additionalImages; // New optional field

  double get discountedPrice =>
      mrpPrice * (1 - (percentageOff / 100)); // Getter for discounted price.
}
