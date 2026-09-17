import 'package:ecommerce/feature/main/domain/entities/categoryentity.dart';
import 'package:ecommerce/feature/main/domain/entities/productentity.dart';
import 'package:flutter/material.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final CategoryEntity categories;
  final ProductEntity products;

  ProductSuccess({
    required this.categories,
    required this.products,
  });
}
final class ProductFailure extends ProductState {
  final String errmessege;

  ProductFailure({
    required this.errmessege,
  });
}