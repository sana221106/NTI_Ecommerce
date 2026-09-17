import 'package:ecommerce/feature/main/presentation/cubits/Home_Cubit/home_cubit.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Home_Cubit/home_state.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/GridCustomForProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridCustomForHomeBlocBuilder extends StatelessWidget {
  const GridCustomForHomeBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          return GridCustomForProduct(
            products: state.products,
          );
        }

        if (state is HomeFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                state.errmessege,
                style: const TextStyle(
                  color: Colors.red,
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