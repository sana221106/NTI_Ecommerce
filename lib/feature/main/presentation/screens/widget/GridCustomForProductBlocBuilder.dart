import 'package:ecommerce/feature/main/presentation/cubits/Product_Cubit/product_cubit.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Product_Cubit/product_state.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/GridCustomForProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridCustomForProductBlocBuilder extends StatelessWidget {
  const GridCustomForProductBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductSuccess) {
          return GridCustomForProduct(
            products: state.products,
          );
        }

        if (state is ProductFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  state.errmessege,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}