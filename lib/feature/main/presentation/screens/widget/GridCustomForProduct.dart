import 'package:ecommerce/feature/main/domain/entities/productentity.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/customItemForProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridCustomForProduct extends StatelessWidget {
  final ProductEntity products;

  const GridCustomForProduct({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverGrid.builder(
        itemCount: products.data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          return CustomItemForProduct(
            product: products.data[index],
          );
        },
      ),
    );
  }
}