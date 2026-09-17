import 'package:ecommerce/cores/constant.dart';
import 'package:ecommerce/cores/widgets/CustomButton.dart';
import 'package:ecommerce/feature/main/domain/entities/cartentity.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Payment_Cubit/payment_cubit.dart';
import 'package:ecommerce/feature/main/presentation/screens/paymob_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartFooter extends StatelessWidget {
  final num totalPrice;
  final List<CartProductEntity> products;

  const CartFooter({
    super.key,
    required this.totalPrice,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          8.h,
          16.w,
          16.h,
        ),
        child: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              // ==========================================
              // MOCK MODE
              // ==========================================

              if (!Constant.useRealPaymob) {
                _showMockPaymentSuccess(context);
                return;
              }

              // ==========================================
              // REAL PAYMOB
              // ==========================================

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymobWebView(
                    paymentKey: state.paymentKey,
                    iframeId: Constant.paymobIframeId,
                  ),
                ),
              );
            }

            if (state is PaymentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is PaymentLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomButton(
              title: 'الدفع $totalPrice جنيه',
              onPressed: () {
                final items = products.map((item) {
                  return {
                    'name': item.product.title ?? 'Product',
                    'amount_cents': (item.price * 100).round(),
                    'description': item.product.title ?? 'Product',
                    'quantity': item.count,
                  };
                }).toList();

                context.read<PaymentCubit>().processPayment(
                  amount: totalPrice.toDouble(),
                  firstName: 'Customer',
                  lastName: 'User',
                  email: 'customer@example.com',
                  phone: '01000000000',
                  items: items,
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showMockPaymentSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'تم الدفع بنجاح',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 70,
              ),
              SizedBox(height: 16.h),
              Text(
                'تم تنفيذ عملية الدفع التجريبية بنجاح.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'المبلغ: $totalPrice جنيه',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('تم'),
            ),
          ],
        );
      },
    );
  }
}