import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:ecommerce/cores/widgets/CustomCahedNetworkImage.dart';
import 'package:ecommerce/feature/main/domain/entities/categoryentity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customitemforcategpry extends StatelessWidget {
  final CategoryDataEntity categoryentity;

  const Customitemforcategpry({
    super.key,
    required this.categoryentity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: SizedBox(
            width: 64.w,
            height: 64.h,
            child: CustomCahedNetworkImage(
              imageUrl: categoryentity.image,
            ),
          ),
        ),

        SizedBox(height: 8.h),

        Text(
          categoryentity.name,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: AppColors.Textblack,
            fontSize: 13,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            height: 1.70,
          ),
        ),
      ],
    );
  }
}