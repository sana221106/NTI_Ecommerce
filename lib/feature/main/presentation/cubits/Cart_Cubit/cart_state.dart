import 'package:ecommerce/feature/main/domain/entities/cartentity.dart';
import 'package:flutter/material.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final CartEntity cart;

  CartSuccess({
    required this.cart,
  });
}

final class CartFailure extends CartState {
  final String errmessege;

  CartFailure({
    required this.errmessege,
  });
}