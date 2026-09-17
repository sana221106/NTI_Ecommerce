class ProductEntity {
  final int results;
  final List<ProductDataEntity> data;

  ProductEntity({
    required this.results,
    required this.data,
  });
}

class ProductDataEntity {
  final String id;
  final String title;
  final String description;
  final int quantity;
  final num price;
  final num? priceAfterDiscount;
  final String imageCover;
  final List<String> images;
  final int ratingsQuantity;
  final num ratingsAverage;
  final String categoryId;

  ProductDataEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
    required this.priceAfterDiscount,
    required this.imageCover,
    required this.images,
    required this.ratingsQuantity,
    required this.ratingsAverage,
    required this.categoryId,
  });
}