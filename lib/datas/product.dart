class Product {
  Product({
    this.id,
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
    this.additionalImages,
    this.prices,
  });

  final int? id;
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
  final List<String>? additionalImages;

  /// multi-currency prices (e.g. {"USD": 29.99, "GBP": 24.99})
  final Map<String, double>? prices;

  double get discountedPrice => mrpPrice * (1 - (percentageOff / 100));

  /// Get price in a specific currency if available
  double? priceFor(String currencyId) =>
      prices != null ? prices![currencyId] : null;

  /// Discounted price in a specific currency
  double? discountedPriceFor(String currencyId) {
    final price = priceFor(currencyId);
    return price != null ? price * (1 - (percentageOff / 100)) : null;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'moreinfo': moreinfo,
      'productDescrip': productDescrip,
      'mrpPrice': mrpPrice,
      'percentageOff': percentageOff,
      'subCategoryId': subCategoryId,
      'dealsOfTheDay': dealsOfTheDay ? 1 : 0,
      'trendingProducts': trendingProducts ? 1 : 0,
      'productImage': productImage,
      // optionally store prices as JSON if desired
      // 'prices': prices,
    };
  }

  factory Product.fromMap(
    Map<String, dynamic> map, {
    List<int>? categoryIds,
    List<String>? images,
    Map<String, double>? prices,
  }) {
    return Product(
      id: map['id'],
      title: map['title'],
      moreinfo: map['moreinfo'] ?? "",
      productDescrip: map['productDescrip'] ?? "",
      mrpPrice: (map['mrpPrice'] as num?)?.toDouble() ?? 0.0,
      percentageOff: (map['percentageOff'] as num?)?.toDouble() ?? 0.0,
      subCategoryId: map['subCategoryId'],
      dealsOfTheDay: map['dealsOfTheDay'] == 1,
      trendingProducts: map['trendingProducts'] == 1,
      productImage: map['productImage'] ?? "",
      categoryIds: categoryIds ?? [],
      additionalImages: images ?? [],
      prices: prices ?? {},
    );
  }
}
