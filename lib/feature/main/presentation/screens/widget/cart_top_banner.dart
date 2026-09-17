import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartTopBanner extends StatelessWidget {
  final int itemsCount;

  const CartTopBanner({
    super.key,
    required this.itemsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 12.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.greennoti,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        'لديك $itemsCount ${itemsCount == 1 ? 'منتج' : 'منتجات'} في سلة التسوق',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.greentext,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
        ),
      ),
    );
  }
}