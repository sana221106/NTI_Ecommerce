import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:ecommerce/feature/main/domain/entities/cartentity.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Cart_Cubit/cart_cubit.dart';
import 'package:ecommerce/feature/main/presentation/screens/delivery_location_card.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/cart_footer.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/cart_top_banner.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/list_custom_for_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  final CartEntity cart;

  const CartScreen({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    final cartData = cart.data;

    if (cartData == null || cartData.products.isEmpty) {
      return const Center(
        child: Text(
          'السلة فارغة',
          style: TextStyle(
            fontFamily: 'Cairo',
          ),
        ),
      );
    }

    return Column(
      children: [
        CartTopBanner(
          itemsCount: cart.numOfCartItems,
        ),

        const DeliveryLocationCard(),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                context.read<CartCubit>().clearCart();
              },
              icon: Icon(
                Icons.delete_sweep_outlined,
                color: AppColors.redButton,
                size: 20.sp,
              ),
              label: Text(
                'مسح السلة',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: AppColors.redButton,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 4.h),

        Expanded(
          child: ListCustomForCart(
            products: cartData.products,
          ),
        ),

        CartFooter(
          totalPrice: cartData.totalCartPrice,
          products: cartData.products,
        ),
      ],
    );
  }
}