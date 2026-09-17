import 'package:ecommerce/feature/main/presentation/cubits/Cart_Cubit/cart_cubit.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Cart_Cubit/cart_state.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/CartScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBodyBlocBuilder extends StatelessWidget {
  const CartBodyBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartSuccess) {
          return CartScreen(
            cart: state.cart,
          );
        }

        if (state is CartFailure) {
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