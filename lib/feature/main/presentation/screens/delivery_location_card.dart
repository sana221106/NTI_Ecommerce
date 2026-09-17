import 'package:ecommerce/feature/main/presentation/cubits/Location_Cubit/location_cubit.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Location_Cubit/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryLocationCard extends StatelessWidget {
  const DeliveryLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationLoading) {
          return _buildCard(
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
                SizedBox(width: 10.w),
                const Text(
                  'Getting your location...',
                ),
              ],
            ),
          );
        }

        if (state is LocationSuccess) {
          return _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.green,
                      size: 24.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Delivery Location',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                Text(
                  state.address,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 5.h),

                Text(
                  'Location selected ✓',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12.sp,
                    color: Colors.green,
                  ),
                ),

                SizedBox(height: 5.h),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      context.read<LocationCubit>().getLocation();
                    },
                    icon: const Icon(Icons.my_location),
                    label: const Text(
                      'Change Location',
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is LocationFailure) {
          return _buildCard(
            child: Row(
              children: [
                Icon(
                  Icons.location_off,
                  color: Colors.red,
                  size: 24.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Unable to detect your location',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12.sp,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return _buildCard(
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              const Text(
                'Detecting delivery location...',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCard({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: child,
    );
  }
}