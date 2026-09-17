import 'package:ecommerce/feature/main/domain/entities/categoryentity.dart';

class CategoryModel {
  final int results;
  final List<CategoryDataModel> data;

  CategoryModel({
    required this.results,
    required this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      results: json['results'] ?? 0,
      data: (json['data'] as List<dynamic>?)
              ?.map(
                (item) => CategoryDataModel.fromJson(item),
              )
              .toList() ??
          [],
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      results: results,
      data: data.map((item) => item.toEntity()).toList(),
    );
  }
}

class CategoryDataModel {
  final String id;
  final String name;
  final String image;
  final String slug;

  CategoryDataModel({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryDataModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      slug: json['slug'] ?? '',
    );
  }

  CategoryDataEntity toEntity() {
    return CategoryDataEntity(
      id: id,
      name: name,
      image: image,
      slug: slug,
    );
  }
}