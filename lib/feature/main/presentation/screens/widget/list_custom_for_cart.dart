import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:ecommerce/feature/main/domain/entities/cartentity.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/custom_item_for_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListCustomForCart extends StatelessWidget {
  final List<CartProductEntity> products;

  const ListCustomForCart({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 4.h,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return CustomItemForCart(
          cartProduct: products[index],
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 24.h,
          thickness: 1,
          color: AppColors.cartDivider,
        );
      },
    );
  }
}