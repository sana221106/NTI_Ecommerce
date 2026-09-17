import 'package:dartz/dartz.dart';
import 'package:ecommerce/cores/constant.dart';
import 'package:ecommerce/cores/Serveces/apiService.dart';
import 'package:ecommerce/feature/main/domain/entities/payment_failure.dart';
import 'package:ecommerce/feature/main/domain/models/order_id_model.dart';
import 'package:ecommerce/feature/main/data/repo/payment_repo.dart';

class PaymentRepoImple implements PaymentRepo {
  final Apiserver apiServes;

  PaymentRepoImple(this.apiServes);

  @override
  Future<Either<PaymentFailure, String>> getAuthToken() async {
    try {
      final response = await apiServes.addData(
        endpoints: 'auth/tokens',
        body: {
          'api_key': Constant.paymobApiKey,
        },
      );

      final token = response['token'];

      if (token == null) {
        return Left(
          PaymentFailure(
            message: 'Paymob did not return an auth token.',
          ),
        );
      }

      return Right(token.toString());
    } catch (e) {
      return Left(
        PaymentFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<PaymentFailure, OrderIdModel>> createOrder({
    required String authToken,
    required double amountCents,
    required List<Map<String, dynamic>> items,
    bool deliveryNeeded = false,
  }) async {
    try {
      final response = await apiServes.addData(
        endpoints: 'ecommerce/orders',
        body: {
          'auth_token': authToken,
          'delivery_needed': deliveryNeeded,
          'amount_cents': amountCents,
          'currency': 'EGP',
          'items': items,
        },
      );

      return Right(
        OrderIdModel.fromJson(response),
      );
    } catch (e) {
      return Left(
        PaymentFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<PaymentFailure, String>> getPaymentKey({
    required String authToken,
    required int orderId,
    required double amountCents,
    required Map<String, String> billingData,
    required int integrationId,
  }) async {
    try {
      final response = await apiServes.addData(
        endpoints: 'acceptance/payment_keys',
        body: {
          'auth_token': authToken,
          'amount_cents': amountCents,
          'expiration': 3600,
          'order_id': orderId,
          'billing_data': billingData,
          'currency': 'EGP',
          'integration_id': integrationId,
        },
      );

      final paymentKey = response['token'];

      if (paymentKey == null) {
        return Left(
          PaymentFailure(
            message: 'Paymob did not return a payment key.',
          ),
        );
      }

      return Right(paymentKey.toString());
    } catch (e) {
      return Left(
        PaymentFailure(
          message: e.toString(),
        ),
      );
    }
  }
}