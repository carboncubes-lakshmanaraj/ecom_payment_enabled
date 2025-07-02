/// ===============================
/// Product Model
/// ===============================
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

  double get discountedPrice => mrpPrice * (1 - (percentageOff / 100));

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
    };
  }

  factory Product.fromMap(
    Map<String, dynamic> map, {
    List<int>? categoryIds,
    List<String>? images,
  }) {
    return Product(
      id: map['id'],
      title: map['title'],
      moreinfo: map['moreinfo'],
      productDescrip: map['productDescrip'],
      mrpPrice: (map['mrpPrice'] as num).toDouble(),
      percentageOff: (map['percentageOff'] as num).toDouble(),
      subCategoryId: map['subCategoryId'],
      dealsOfTheDay: map['dealsOfTheDay'] == 1,
      trendingProducts: map['trendingProducts'] == 1,
      productImage: map['productImage'],
      categoryIds: categoryIds ?? [],
      additionalImages: images ?? [],
    );
  }
}
