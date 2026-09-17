import 'dart:async';

import 'package:ecommerce/cores/constant.dart';
import 'package:ecommerce/feature/main/data/repo/payment_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo paymentRepo;

  PaymentCubit(this.paymentRepo) : super(PaymentInitial());

  Future<void> processPayment({
    required double amount,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    List<Map<String, dynamic>> items = const [],
  }) async {
    // ==========================================
    // MOCK PAYMENT
    // ==========================================

    if (!Constant.useRealPaymob) {
      emit(
        PaymentLoading(
          message: 'جاري تجهيز الدفع...',
        ),
      );

      await Future.delayed(
        const Duration(seconds: 1),
      );

      emit(
        PaymentSuccess(
          paymentKey: Constant.mockPaymentKey,
        ),
      );

      return;
    }

    // ==========================================
    // REAL PAYMOB
    // ==========================================

    emit(
      PaymentLoading(
        message: 'Preparing payment...',
      ),
    );

    // ==========================================
    // 1. Get Auth Token
    // ==========================================

    final authResult = await paymentRepo.getAuthToken();

    String? authToken;

    final authFailed = authResult.fold(
      (failure) {
        emit(
          PaymentFailure(
            failure.message,
          ),
        );

        return true;
      },
      (token) {
        authToken = token;
        return false;
      },
    );

    if (authFailed || authToken == null) {
      return;
    }

    // ==========================================
    // 2. Create Paymob Order
    // ==========================================

    final amountCents = (amount * 100).roundToDouble();

    final orderResult = await paymentRepo.createOrder(
      authToken: authToken!,
      amountCents: amountCents,
      items: items,
      deliveryNeeded: false,
    );

    int? orderId;

    final orderFailed = orderResult.fold(
      (failure) {
        emit(
          PaymentFailure(
            failure.message,
          ),
        );

        return true;
      },
      (order) {
        orderId = int.tryParse(order.id);
        return false;
      },
    );

    if (orderFailed || orderId == null) {
      emit(
        PaymentFailure(
          'Invalid Paymob order ID.',
        ),
      );

      return;
    }

    // ==========================================
    // 3. Get Payment Key
    // ==========================================

    final paymentKeyResult = await paymentRepo.getPaymentKey(
      authToken: authToken!,
      orderId: orderId!,
      amountCents: amountCents,
      integrationId: Constant.paymobCardIntegrationId,
      billingData: {
        'first_name': firstName.isEmpty ? 'Customer' : firstName,
        'last_name': lastName.isEmpty ? 'User' : lastName,
        'email': email.isEmpty ? 'customer@example.com' : email,
        'phone_number': phone.isEmpty ? '01000000000' : phone,
        'apartment': 'NA',
        'floor': 'NA',
        'street': 'NA',
        'building': 'NA',
        'shipping_method': 'NA',
        'postal_code': 'NA',
        'city': 'Cairo',
        'country': 'EG',
        'state': 'Cairo',
      },
    );

    paymentKeyResult.fold(
      (failure) {
        emit(
          PaymentFailure(
            failure.message,
          ),
        );
      },
      (paymentKey) {
        emit(
          PaymentSuccess(
            paymentKey: paymentKey,
          ),
        );
      },
    );
  }
}