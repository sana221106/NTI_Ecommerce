import 'package:ecommerce/feature/main/domain/entities/productentity.dart';

class ProductModel {
  final int results;
  final List<ProductDataModel> data;

  ProductModel({
    required this.results,
    required this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      results: json['results'] ?? 0,
      data: (json['data'] as List<dynamic>?)
              ?.map(
                (item) => ProductDataModel.fromJson(item),
              )
              .toList() ??
          [],
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      results: results,
      data: data.map((item) => item.toEntity()).toList(),
    );
  }
}

class ProductDataModel {
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

  ProductDataModel({
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

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0,
      priceAfterDiscount: json['priceAfterDiscount'],
      imageCover: json['imageCover'] ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [],
      ratingsQuantity: json['ratingsQuantity'] ?? 0,
      ratingsAverage: json['ratingsAverage'] ?? 0,

      // مهم جدًا
      categoryId: json['category']?['_id'] ?? '',
    );
  }

  ProductDataEntity toEntity() {
    return ProductDataEntity(
      id: id,
      title: title,
      description: description,
      quantity: quantity,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      imageCover: imageCover,
      images: images,
      ratingsQuantity: ratingsQuantity,
      ratingsAverage: ratingsAverage,
      categoryId: categoryId,
    );
  }
}