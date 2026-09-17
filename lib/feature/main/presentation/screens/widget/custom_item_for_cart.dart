import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:ecommerce/cores/widgets/CustomCahedNetworkImage.dart';
import 'package:ecommerce/feature/main/domain/entities/cartentity.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Cart_Cubit/cart_cubit.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/cart_quantity_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomItemForCart extends StatelessWidget {
  final CartProductEntity cartProduct;

  const CustomItemForCart({super.key, required this.cartProduct});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: SizedBox(
            width: 72.w,
            height: 72.w,
            child: CustomCahedNetworkImage(
              imageUrl: cartProduct.product.imageCover,
            ),
          ),
        ),

        SizedBox(width: 12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      cartProduct.product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: AppColors.Textblack,
                      ),
                    ),
                  ),

                  SizedBox(width: 8.w),

                  InkWell(
                    onTap: () {
                      context.read<CartCubit>().removeFromCart(
                        productId: cartProduct.product.id,
                      );
                    },
                    borderRadius: BorderRadius.circular(20.r),
                    child: Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Icon(
                        Icons.delete_outline,
                        color: AppColors.redButton,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 4.h),

              Text(
                'الكمية: ${cartProduct.count}',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: AppColors.grayhinttext,
                  fontSize: 11.sp,
                ),
              ),

              SizedBox(height: 6.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${cartProduct.price} جنيه',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: AppColors.yellowPrice,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),

                  CartQuantityStepper(cartProduct: cartProduct),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
