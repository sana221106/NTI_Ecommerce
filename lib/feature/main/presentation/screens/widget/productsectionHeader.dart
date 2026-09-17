import 'package:ecommerce/cores/utiles/app_styleText.dart';
import 'package:flutter/material.dart';

class productsectionHeader extends StatelessWidget {
  const productsectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('المزيد', style: AppStyletext.normal16),

        Text('الأكثر مبيعاً', style: AppStyletext.Bold16),
      ],
    );
  }
}
