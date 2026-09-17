import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:ecommerce/cores/utiles/app_styleText.dart';
import 'package:ecommerce/cores/widgets/CustomCahedNetworkImage.dart';
import 'package:ecommerce/feature/main/domain/entities/productentity.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Cart_Cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomItemForProduct extends StatelessWidget {
  final ProductDataEntity product;

  const CustomItemForProduct({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greennoti,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: CustomCahedNetworkImage(
                      imageUrl: product.imageCover,
                    ),
                  ),
                ),

                SizedBox(height: 5.h),

                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: AppStyletext.SemiBold13.copyWith(
                    color: AppColors.Textblack,
                  ),
                ),

                SizedBox(height: 5.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product.price} جنيه / الكيلو',
                      style: AppStyletext.regular11,
                    ),

                    GestureDetector(
                      onTap: () {
                        context.read<CartCubit>().addToCart(
                          productId: product.id,
                        );
                      },
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: const BoxDecoration(
                          color: AppColors.greenButton,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            top: 7.h,
            left: 7.w,
            child: Icon(
              Icons.favorite_border,
              size: 20.sp,
              color: AppColors.Textblack,
            ),
          ),
        ],
      ),
    );
  }
}