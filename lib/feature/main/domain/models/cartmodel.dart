import 'package:ecommerce/feature/main/domain/entities/cartentity.dart';
import 'package:ecommerce/feature/main/domain/models/productmodel.dart';

class CartModel {
  final String status;
  final String message;
  final int numOfCartItems;
  final String? cartId;
  final CartDataModel? data;

  CartModel({
    required this.status,
    required this.message,
    required this.numOfCartItems,
    required this.cartId,
    required this.data,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      numOfCartItems: json['numOfCartItems'] ?? 0,
      cartId: json['cartId'],
      data: json['data'] != null
          ? CartDataModel.fromJson(json['data'])
          : null,
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      status: status,
      message: message,
      numOfCartItems: numOfCartItems,
      cartId: cartId,
      data: data?.toEntity(),
    );
  }
}

class CartDataModel {
  final String id;
  final String cartOwner;
  final List<CartProductModel> products;
  final String createdAt;
  final String updatedAt;
  final num totalCartPrice;

  CartDataModel({
    required this.id,
    required this.cartOwner,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
    required this.totalCartPrice,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      id: json['_id'] ?? '',
      cartOwner: json['cartOwner'] ?? '',
      products: (json['products'] as List<dynamic>?)
              ?.map((item) => CartProductModel.fromJson(item))
              .toList() ??
          [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      totalCartPrice: json['totalCartPrice'] ?? 0,
    );
  }

  CartDataEntity toEntity() {
    return CartDataEntity(
      id: id,
      cartOwner: cartOwner,
      products: products.map((item) => item.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
      totalCartPrice: totalCartPrice,
    );
  }
}

class CartProductModel {
  final int count;
  final String id;
  final ProductDataModel product;
  final num price;

  CartProductModel({
    required this.count,
    required this.id,
    required this.product,
    required this.price,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      count: json['count'] ?? 0,
      id: json['_id'] ?? '',
      product: ProductDataModel.fromJson(json['product'] ?? {}),
      price: json['price'] ?? 0,
    );
  }

  CartProductEntity toEntity() {
    return CartProductEntity(
      count: count,
      id: id,
      product: product.toEntity(),
      price: price,
    );
  }
}