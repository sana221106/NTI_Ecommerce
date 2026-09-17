import 'package:dartz/dartz.dart';
import 'package:ecommerce/cores/error/Failure.dart';
import 'package:ecommerce/feature/main/domain/entities/cartentity.dart';
import 'package:ecommerce/feature/main/domain/entities/categoryentity.dart';
import 'package:ecommerce/feature/main/domain/entities/productentity.dart';

abstract class Mainrepo {
  Future<Either<Failure, CategoryEntity>> getCategory();
  Future<Either<Failure, ProductEntity>> getProducts();
  Future<Either<Failure, CartEntity>> getCart();

  Future<Either<Failure, CartEntity>> addToCart({required String productId});

  Future<Either<Failure, CartEntity>> updateCart({
    required String productId,
    required int count,
  });

  Future<Either<Failure, CartEntity>> removeFromCart({
    required String productId,
  });
  Future<Either<Failure, CartEntity>> clearCart();
}
