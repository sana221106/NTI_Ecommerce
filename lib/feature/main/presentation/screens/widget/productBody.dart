import 'package:ecommerce/cores/utiles/app_styleText.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Product_Cubit/product_cubit.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/GridCustomForProductBlocBuilder.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/ListCustomForCategoryBlocBuilder.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/SearchField.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/productsectionHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Productbody extends StatelessWidget {
  const Productbody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Column(
              children: [
                const SizedBox(height: 22),

                SearchField(
                  onChanged: (value) {
                    context
                        .read<ProductCubit>()
                        .searchProducts(value);
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المزيد',
                      style: AppStyletext.normal16,
                    ),
                    Text(
                      'منتاجتنا ',
                      style: AppStyletext.Bold16,
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                ListCustomForCategoryBlocBuilder(),

                const SizedBox(height: 10),

                productsectionHeader(),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),

        GridCustomForProductBlocBuilder(),
      ],
    );
  }
}