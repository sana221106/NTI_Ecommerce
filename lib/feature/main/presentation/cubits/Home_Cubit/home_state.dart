import 'package:ecommerce/feature/main/domain/entities/productentity.dart';
import 'package:flutter/material.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final ProductEntity products;

  HomeSuccess({
    required this.products,
  });
}

final class HomeFailure extends HomeState {
  final String errmessege;

  HomeFailure({
    required this.errmessege,
  });
}