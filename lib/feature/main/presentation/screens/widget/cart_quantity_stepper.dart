import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:ecommerce/feature/main/domain/entities/cartentity.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Cart_Cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartQuantityStepper extends StatelessWidget {
  final CartProductEntity cartProduct;

  const CartQuantityStepper({
    super.key,
    required this.cartProduct,
  });

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepperButton(
          icon: Icons.remove,
          onTap: () {
            if (cartProduct.count > 1) {
              cartCubit.updateCart(
                productId: cartProduct.product.id,
                count: cartProduct.count - 1,
              );
            } else {
              cartCubit.removeFromCart(
                productId: cartProduct.product.id,
              );
            }
          },
        ),

        SizedBox(width: 8.w),

        SizedBox(
          width: 24.w,
          child: Text(
            '${cartProduct.count}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: AppColors.Textblack,
            ),
          ),
        ),

        SizedBox(width: 8.w),

        _StepperButton(
          icon: Icons.add,
          filled: true,
          onTap: () {
            cartCubit.updateCart(
              productId: cartProduct.product.id,
              count: cartProduct.count + 1,
            );
          },
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;

  const _StepperButton({
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          width: 28.w,
          height: 28.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: filled
                ? AppColors.greenButton
                : AppColors.gray200,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 16.sp,
            color: filled
                ? AppColors.primaryColor
                : AppColors.Textblack,
          ),
        ),
      ),
    );
  }
}