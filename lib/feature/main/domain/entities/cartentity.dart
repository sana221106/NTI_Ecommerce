import 'package:ecommerce/feature/main/domain/entities/productentity.dart';

class CartEntity {
  final String status;
  final String message;
  final int numOfCartItems;
  final String? cartId;
  final CartDataEntity? data;

  CartEntity({
    required this.status,
    required this.message,
    required this.numOfCartItems,
    required this.cartId,
    required this.data,
  });
}

class CartDataEntity {
  final String id;
  final String cartOwner;
  final List<CartProductEntity> products;
  final String createdAt;
  final String updatedAt;
  final num totalCartPrice;

  CartDataEntity({
    required this.id,
    required this.cartOwner,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
    required this.totalCartPrice,
  });
}

class CartProductEntity {
  final int count;
  final String id;
  final ProductDataEntity product;
  final num price;

  CartProductEntity({
    required this.count,
    required this.id,
    required this.product,
    required this.price,
  });
}