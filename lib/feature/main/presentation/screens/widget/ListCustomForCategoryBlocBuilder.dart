import 'package:ecommerce/feature/main/presentation/cubits/Product_Cubit/product_cubit.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Product_Cubit/product_state.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/ListCustomForCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCustomForCategoryBlocBuilder extends StatelessWidget {
  const ListCustomForCategoryBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductSuccess) {
          return ListCustomForCategory(
            categories: state.categories,
          );
        }

        if (state is ProductFailure) {
          return Center(
            child: Text(
              state.errmessege,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}