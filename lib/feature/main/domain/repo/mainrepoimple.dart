import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/cores/Serveces/databaseService.dart';
import 'package:ecommerce/cores/Serveces/endpoints.dart';
import 'package:ecommerce/cores/Serveces/localdatabaseservice.dart';
import 'package:ecommerce/cores/constant.dart';
import 'package:ecommerce/cores/error/Failure.dart';
import 'package:ecommerce/feature/main/data/repo/mainrepo.dart';
import 'package:ecommerce/feature/main/domain/entities/cartentity.dart';
import 'package:ecommerce/feature/main/domain/entities/categoryentity.dart';
import 'package:ecommerce/feature/main/domain/entities/productentity.dart';
import 'package:ecommerce/feature/main/domain/models/cartmodel.dart';
import 'package:ecommerce/feature/main/domain/models/categorymodel.dart';
import 'package:ecommerce/feature/main/domain/models/productmodel.dart';

class Mainrepoimple extends Mainrepo {
  final Databaseservce databaseservce;
  final LocalDatabaseService localDatabaseService;

  Mainrepoimple({
    required this.databaseservce,
    required this.localDatabaseService,
  });

  Future<String?> _getToken() async {
    final userData = await localDatabaseService.getDatabyKey(
      Constant.userBox,
      Constant.userKey,
    );

    return userData?['token']?.toString();
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategory() async {
    try {
      final response = await databaseservce.getData(
        endpoints: Endpoints.getCategory,
      );

      final CategoryModel categoryModels =
          CategoryModel.fromJson(response);

      final CategoryEntity categoryEntities =
          categoryModels.toEntity();

      return right(categoryEntities);
    } on DioException {
      return left(
        ServerFailure(
          errmessege: "Failed to get category",
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errmessege: "An error occurred: $e",
        ),
      );
    }
  }

 @override
Future<Either<Failure, ProductEntity>> getProducts() async {
  try {
    final response = await databaseservce.getData(
      endpoints: Endpoints.endpoints,
    );

    print('PRODUCT RESPONSE: $response');

    final ProductModel productModels =
        ProductModel.fromJson(response);

    final ProductEntity productEntities =
        productModels.toEntity();

    return right(productEntities);
  } on DioException catch (e) {
    print('PRODUCT DIO ERROR: ${e.message}');
    print('PRODUCT STATUS CODE: ${e.response?.statusCode}');
    print('PRODUCT RESPONSE DATA: ${e.response?.data}');
    print('PRODUCT REQUEST URL: ${e.requestOptions.uri}');

    return left(
      ServerFailure(
        errmessege: "Failed to get products",
      ),
    );
  } catch (e) {
    print('PRODUCT ERROR: $e');

    return left(
      ServerFailure(
        errmessege: "An error occurred: $e",
      ),
    );
  }
}

  @override
  Future<Either<Failure, CartEntity>> getCart() async {
    try {
      final token = await _getToken();

      final response = await databaseservce.getData(
        endpoints: Endpoints.cart,
        token: token,
      );

      final CartModel cartModel =
          CartModel.fromJson(response);

      final CartEntity cartEntity =
          cartModel.toEntity();

      return right(cartEntity);
    } on DioException {
      return left(
        ServerFailure(
          errmessege: "Failed to get cart",
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errmessege: "An error occurred: $e",
        ),
      );
    }
  }

  @override
Future<Either<Failure, CartEntity>> addToCart({
  required String productId,
}) async {
  try {
    final token = await _getToken();

    print('CART TOKEN: $token');
    print('PRODUCT ID: $productId');

    final response = await databaseservce.addData(
      endpoints: Endpoints.cart,
      token: token,
      body: {
        "productId": productId,
      },
    );

    print('ADD CART RESPONSE: $response');

    final CartModel cartModel =
        CartModel.fromJson(response);

    final CartEntity cartEntity =
        cartModel.toEntity();

    return right(cartEntity);
  } on DioException catch (e) {
    print('CART DIO ERROR: ${e.message}');
    print('CART STATUS CODE: ${e.response?.statusCode}');
    print('CART RESPONSE DATA: ${e.response?.data}');
    print('CART REQUEST URL: ${e.requestOptions.uri}');

    return left(
      ServerFailure(
        errmessege: "Failed to add product to cart",
      ),
    );
  } catch (e) {
    print('CART ERROR: $e');

    return left(
      ServerFailure(
        errmessege: "An error occurred: $e",
      ),
    );
  }
}
  @override
  Future<Either<Failure, CartEntity>> updateCart({
    required String productId,
    required int count,
  }) async {
    try {
      final token = await _getToken();

      final response = await databaseservce.updateData(
        endpoints: "${Endpoints.cart}/$productId",
        token: token,
        body: {
          "count": count,
        },
      );

      final CartModel cartModel =
          CartModel.fromJson(response);

      final CartEntity cartEntity =
          cartModel.toEntity();

      return right(cartEntity);
    } on DioException {
      return left(
        ServerFailure(
          errmessege: "Failed to update cart",
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errmessege: "An error occurred: $e",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, CartEntity>> removeFromCart({
    required String productId,
  }) async {
    try {
      final token = await _getToken();

      final response = await databaseservce.deleteData(
        endpoints: "${Endpoints.cart}/$productId",
        token: token,
      );

      final CartModel cartModel =
          CartModel.fromJson(response);

      final CartEntity cartEntity =
          cartModel.toEntity();

      return right(cartEntity);
    } on DioException {
      return left(
        ServerFailure(
          errmessege: "Failed to remove product from cart",
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errmessege: "An error occurred: $e",
        ),
      );
    }
  }
  @override
Future<Either<Failure, CartEntity>> clearCart() async {
  try {
    final token = await _getToken();

    final response = await databaseservce.deleteData(
      endpoints: Endpoints.cart,
      token: token,
    );

    final CartModel cartModel = CartModel.fromJson(response);
    final CartEntity cartEntity = cartModel.toEntity();

    return right(cartEntity);
  } on DioException {
    return left(
      ServerFailure(
        errmessege: "Failed to clear cart",
      ),
    );
  } catch (e) {
    return left(
      ServerFailure(
        errmessege: "An error occurred: $e",
      ),
    );
  }
}
}