part of 'payment_cubit.dart';

sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {
  final String message;

  PaymentLoading({
    required this.message,
  });
}

final class PaymentSuccess extends PaymentState {
  final String paymentKey;

  PaymentSuccess({
    required this.paymentKey,
  });
}

final class PaymentFailure extends PaymentState {
  final String message;

  PaymentFailure(this.message);
}