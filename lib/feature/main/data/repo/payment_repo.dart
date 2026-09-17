import 'package:dartz/dartz.dart';
import 'package:ecommerce/feature/main/domain/models/order_id_model.dart';
import 'package:ecommerce/feature/main/domain/entities/payment_failure.dart';

abstract class PaymentRepo {
  Future<Either<PaymentFailure, String>> getAuthToken();

  Future<Either<PaymentFailure, OrderIdModel>> createOrder({
    required String authToken,
    required double amountCents,
    required List<Map<String, dynamic>> items,
    bool deliveryNeeded,
  });

  Future<Either<PaymentFailure, String>> getPaymentKey({
    required String authToken,
    required int orderId,
    required double amountCents,
    required Map<String, String> billingData,
    required int integrationId,
  });
}